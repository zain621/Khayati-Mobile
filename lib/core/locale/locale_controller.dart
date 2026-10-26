import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:app_mobile/constants/constants/constants.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/di/dependency_injection.dart';
import '../storage/local/app_settings_prefs.dart';

class LocaleController extends GetxController {
  Locale? locale;
  final RxBool isChangingLanguage = false.obs;
  final AppSettingsPrefs _appSettingsPrefs = instance<AppSettingsPrefs>();

  Future<void> changeLanguage(String langCode, {bool force = false}) async {
    final selectedLocale = _getLocaleFromString(langCode);

    if (!force && locale?.languageCode == selectedLocale.languageCode) {
      return;
    }

    isChangingLanguage.value = true;
    locale = selectedLocale;
    await _appSettingsPrefs.setLocale(locale: langCode);

    if (instance.isRegistered<Dio>()) {
      instance<Dio>().options.headers[Constants.acceptLanguage] = langCode;
    }

    final currentContext = Get.context;
    if (currentContext != null) {
      await EasyLocalization.of(currentContext)?.setLocale(selectedLocale);
    }

    await Get.updateLocale(selectedLocale);
    Get.forceAppUpdate();
    // Brief pause so the rebuild completes before hiding the overlay
    await Future.delayed(const Duration(milliseconds: 200));
    isChangingLanguage.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    final appLocale = _appSettingsPrefs.getLocale().pareWithDefaultLocale();
    locale = _getLocaleFromString(appLocale);
  }

  Locale _getLocaleFromString(String appLocale) {
    switch (appLocale) {
      case 'ar':
        return const Locale('ar');
      case 'en':
        return const Locale('en');
      case 'ur':
        return const Locale('ur');
      default:
        return const Locale('en');
    }
  }
}
