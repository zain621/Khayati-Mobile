import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

/// Maps FCM / inbox notification payloads to GetX routes by role + type.
class NotificationNavigator {
  NotificationNavigator._();

  static void openFromRemoteMessage(RemoteMessage message) {
    openFromData(Map<String, dynamic>.from(message.data));
  }

  static void openFromData(Map<String, dynamic> data) {
    final type = (data['type'] ?? '').toString();
    if (type.isEmpty) {
      Get.toNamed(Routes.notificationScreen);
      return;
    }

    try {
      _routeByType(type, data);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Notification navigation failed: $e');
      }
      Get.toNamed(Routes.notificationScreen);
    }
  }

  static String get _role {
    try {
      return instance<AppSettingsPrefs>().getUserRole();
    } catch (_) {
      return '';
    }
  }

  static bool get _isCustomer => _role == 'user';

  static bool get _isProvider =>
      _role == 'independent_tailor' ||
      _role == 'shop_owner' ||
      _role == 'comprehensive_tailor';

  static void _routeByType(String type, Map<String, dynamic> data) {
    final orderId = _string(data, 'orderId');
    final conversationId = _string(data, 'conversationId');
    final senderName = _string(data, 'senderName') ?? 'Chat';
    final avatarUrl = _string(data, 'senderImage') ?? _string(data, 'avatarUrl');

    switch (type) {
      // ── Chat ─────────────────────────────────────────────────────────────
      case 'CHAT_MESSAGE_RECEIVED':
        if (conversationId == null || conversationId.isEmpty) {
          Get.toNamed(
            _isCustomer
                ? Routes.userConversationsScreen
                : Routes.conversationsScreen,
          );
          return;
        }
        Get.toNamed(
          _isCustomer ? Routes.userChatDetailScreen : Routes.chatDetailScreen,
          arguments: {
            'conversationId': conversationId,
            'userName': senderName,
            'avatarUrl': avatarUrl,
            'isOnline': false,
          },
        );
        return;

      // ── Customer: offers on their Zoqak order ────────────────────────────
      case 'ZOQAK_OFFER_RECEIVED':
      case 'ZOQAK_OFFER_WITHDRAWN_BY_PROVIDER':
      case 'ZOQAK_OFFER_REMOVED_BY_PROVIDER':
        if (_isCustomer && orderId != null && orderId.isNotEmpty) {
          Get.toNamed(Routes.submittedOffers, arguments: orderId);
          return;
        }
        break;

      case 'ZOQAK_OFFER_ACCEPT_CONFIRMATION':
      case 'ZOQAK_ORDER_STATUS_CHANGED':
      case 'SHOP_ORDER_STATUS_CHANGED':
        if (_isCustomer && orderId != null && orderId.isNotEmpty) {
          Get.toNamed(Routes.orderDetails, arguments: orderId);
          return;
        }
        break;

      // ── Provider: new Zoqak request available ─────────────────────────────
      case 'ZOQAK_ORDER_CREATED':
        if (_isProvider) {
          Get.toNamed(Routes.suggestedRequests);
          return;
        }
        break;

      // ── Provider: own offer lifecycle ─────────────────────────────────────
      case 'ZOQAK_OFFER_CREATED':
      case 'ZOQAK_OFFER_WITHDRAWN':
      case 'ZOQAK_OFFER_REMOVED':
        if (_isProvider) {
          Get.toNamed(Routes.myOffers);
          return;
        }
        break;

      case 'ZOQAK_OFFER_ACCEPTED':
        if (_isProvider) {
          if (orderId != null && orderId.isNotEmpty) {
            Get.toNamed(
              Routes.orderDetailForTailor,
              arguments: {'orderId': orderId},
            );
          } else {
            Get.toNamed(Routes.orderTracking);
          }
          return;
        }
        break;

      // ── Shop order for shop / comprehensive ───────────────────────────────
      case 'SHOP_ORDER_CREATED':
        if (_role == 'shop_owner' || _role == 'comprehensive_tailor') {
          Get.toNamed(Routes.orderTracking);
          return;
        }
        break;

      // ── Provider account approved ──────────────────────────────────────────
      case 'PROVIDER_REQUEST_APPROVED':
        Get.offAllNamed(Routes.loginScreen);
        return;

      default:
        break;
    }

    Get.toNamed(Routes.notificationScreen);
  }

  static String? _string(Map<String, dynamic> data, String key) {
    final value = data[key];
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }
}
