import 'dart:async';
import 'dart:convert';

import 'package:app_mobile/constants/di/dependency_injection.dart' as di;
import 'package:app_mobile/core/network/dio_factory.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../firebase_options.dart';
import 'notification_navigator.dart';

/// Background isolate handler — must be a top-level function.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (kIsWeb) return;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService instance = PushNotificationService._();

  static const _androidChannelId = 'khayati_default';
  static const _androidChannelName = 'Khayati Notifications';

  // Lazy — must not touch Firebase before initializeApp (and never on web).
  FirebaseMessaging get _messaging => FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;
  String? _currentToken;
  StreamSubscription<String>? _tokenRefreshSub;

  bool get _isAndroid =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
  bool get _isIOS => !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  Future<void> initialize() async {
    if (_initialized) return;

    // No web Firebase app configured — skip FCM on Chrome/desktop web.
    if (kIsWeb) {
      _initialized = true;
      if (kDebugMode) {
        debugPrint(
          'PushNotificationService: skipped on web '
          '(run flutterfire configure --platforms=web to enable).',
        );
      }
      return;
    }

    // Firebase.initializeApp is called in main() before this.
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    await _setupLocalNotifications();
    await _requestPermission();

    FirebaseMessaging.onMessage.listen(_onForegroundMessage);

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      NotificationNavigator.openFromRemoteMessage(message);
    });

    final initial = await _messaging.getInitialMessage();
    if (initial != null) {
      Future<void>.delayed(const Duration(milliseconds: 1200), () {
        NotificationNavigator.openFromRemoteMessage(initial);
      });
    }

    _tokenRefreshSub = _messaging.onTokenRefresh.listen((token) {
      _currentToken = token;
      unawaited(_persistAndSyncToken(token));
    });

    _initialized = true;

    if (_isLoggedIn()) {
      unawaited(syncTokenWithBackend());
    }
  }

  bool _isLoggedIn() {
    try {
      return di.instance<AppSettingsPrefs>().getUserLoggedIn();
    } catch (_) {
      return false;
    }
  }

  Future<void> _setupLocalNotifications() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _local.initialize(
      const InitializationSettings(android: androidInit, iOS: iosInit),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload;
        if (payload == null || payload.isEmpty) return;
        try {
          final map = jsonDecode(payload) as Map<String, dynamic>;
          NotificationNavigator.openFromData(map);
        } catch (_) {
          // ignore malformed payload
        }
      },
    );

    if (_isAndroid) {
      const channel = AndroidNotificationChannel(
        _androidChannelId,
        _androidChannelName,
        description: 'Order, chat, offer and payment alerts',
        importance: Importance.high,
      );
      await _local
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> _requestPermission() async {
    await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> syncTokenWithBackend() async {
    if (kIsWeb) return;
    try {
      final token = await _messaging.getToken();
      if (token == null || token.isEmpty) return;
      _currentToken = token;
      await _persistAndSyncToken(token);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('FCM token sync failed: $e');
      }
    }
  }

  Future<void> _persistAndSyncToken(String token) async {
    try {
      final prefs = di.instance<AppSettingsPrefs>();
      if (!prefs.getUserLoggedIn()) return;

      final dio = await di.instance<DioFactory>().getDio();
      await dio.post(
        '/notifications/device-token',
        data: {
          'token': token,
          'platform': _isIOS ? 'ios' : 'android',
        },
      );
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Register device token failed: $e');
      }
    }
  }

  Future<void> unregisterTokenOnLogout() async {
    if (kIsWeb) return;
    try {
      final token = _currentToken ?? await _messaging.getToken();
      if (token == null || token.isEmpty) return;

      final dio = await di.instance<DioFactory>().getDio();
      await dio.delete(
        '/notifications/device-token',
        data: {'token': token},
        options: Options(validateStatus: (s) => s != null && s < 500),
      );
    } catch (_) {
      // Best-effort; local logout must continue
    } finally {
      try {
        await _messaging.deleteToken();
      } catch (_) {}
      _currentToken = null;
    }
  }

  Future<void> _onForegroundMessage(RemoteMessage message) async {
    final notification = message.notification;
    final title = notification?.title ?? message.data['title']?.toString();
    final body = notification?.body ?? message.data['body']?.toString();
    if (title == null && body == null) return;

    final payload = jsonEncode({
      ...message.data,
      if (message.messageId != null) 'messageId': message.messageId,
    });

    await _local.show(
      message.hashCode,
      title ?? 'Khayati',
      body ?? '',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannelId,
          _androidChannelName,
          channelDescription: 'Order, chat, offer and payment alerts',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: payload,
    );
  }

  void dispose() {
    _tokenRefreshSub?.cancel();
  }
}

/// Convenience used after successful login / OTP.
Future<void> registerPushAfterAuth() async {
  await PushNotificationService.instance.syncTokenWithBackend();
}

/// Convenience used on logout / delete account.
Future<void> unregisterPushOnLogout() async {
  await PushNotificationService.instance.unregisterTokenOnLogout();
}

/// Optional helper if a screen needs to open notifications inbox.
void openNotificationsInbox() {
  Get.toNamed(Routes.notificationScreen);
}
