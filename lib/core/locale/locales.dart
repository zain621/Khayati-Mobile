import 'package:flutter/material.dart';
import '../../constants/constants/constants.dart';
import '../../constants/di/dependency_injection.dart';
import '../storage/local/app_settings_prefs.dart';

LocaleSettings localeSettings = LocaleSettings();

class LocaleSettings {
  final AppSettingsPrefs settingsPrefs;

  LocaleSettings() : settingsPrefs = instance<AppSettingsPrefs>();

  /// All locales the app can load (includes Urdu for visitors).
  static const Map<String, String> languages = {
    Constants.english: Constants.englishName,
    Constants.arabic: Constants.arabicName,
    Constants.urdu: Constants.urduName,
  };

  /// Tailor / provider language set.
  static const Map<String, String> tailorLanguages = {
    Constants.english: Constants.englishName,
    Constants.arabic: Constants.arabicName,
  };

  /// Visitor / customer language set.
  static const Map<String, String> visitorLanguages = {
    Constants.english: Constants.englishName,
    Constants.arabic: Constants.arabicName,
    Constants.urdu: Constants.urduName,
  };

  List<Locale> get locales => languages.keys.map((e) => Locale(e)).toList();

  Locale get defaultLocale => Locale(settingsPrefs.getLocale());
}
