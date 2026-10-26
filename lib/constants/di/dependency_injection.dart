import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../constants/constants/constants.dart';
import '../../core/internet_checker/interent_checker.dart';
import '../../core/network/app_api.dart';
import '../../core/network/dio_factory.dart';
import '../../core/socket/chat_socket_service.dart';
import '../../core/storage/local/app_settings_prefs.dart';
import '../../core/service/translation_service.dart';

final instance = GetIt.instance;

/// Init the base module when open app
initModule() async {
  // WidgetsFlutterBinding may already be initialized in main() for Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  await _initGoogleMapsAndroid();
  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: '.env');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  if (!GetIt.I.isRegistered<SharedPreferences>()) {
    instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  }

  if (!GetIt.I.isRegistered<AppSettingsPrefs>()) {
    instance.registerLazySingleton<AppSettingsPrefs>(
        () => AppSettingsPrefs(instance()));
  }

  // Default the app to English so testers can run it in LTR.
  // Runs once; after that the language picker choice is kept.
  const migratedToEnglishKey = 'locale_defaulted_to_english';
  if (!(sharedPrefs.getBool(migratedToEnglishKey) ?? false)) {
    await instance<AppSettingsPrefs>().setLocale(locale: Constants.english);
    await sharedPrefs.setBool(migratedToEnglishKey, true);
  }
  // This is not important code
  // @todo: remove this code
  // AppSettingsPrefs _app = instance<AppSettingsPrefs>();
  // var pref = await SharedPreferences.getInstance();
  // pref.clear();

  if (!GetIt.I.isRegistered<NetworkInfo>()) {
    instance.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImp(InternetConnectionCheckerPlus()));
  }

  if (!GetIt.I.isRegistered<DioFactory>()) {
    instance.registerLazySingleton<DioFactory>(() => DioFactory());
  }
  Dio dio = await instance<DioFactory>().getDio();
  if (!GetIt.I.isRegistered<Dio>()) {
    instance.registerLazySingleton<Dio>(() => dio);
  }
  if (!GetIt.I.isRegistered<AppService>()) {
    instance.registerLazySingleton<AppService>(() => AppService(dio));
  }

  if (!GetIt.I.isRegistered<ChatSocketService>()) {
    instance.registerLazySingleton<ChatSocketService>(
      () => ChatSocketService(instance<AppSettingsPrefs>()),
    );
  }

  if (!GetIt.I.isRegistered<TranslationService>()) {
    instance.registerLazySingleton<TranslationService>(
      () => TranslationService(instance<Dio>()),
    );
  }
}

/// Use the latest Maps renderer on Android to avoid blank/gray maps.
Future<void> _initGoogleMapsAndroid() async {
  if (kIsWeb || !Platform.isAndroid) return;

  try {
    final mapsImplementation = GoogleMapsFlutterPlatform.instance;
    if (mapsImplementation is GoogleMapsFlutterAndroid) {
      await mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
    }
  } catch (_) {
    // Fall back to the default renderer if the latest one is unavailable.
  }
}
