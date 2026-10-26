import 'dart:convert';

import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:app_mobile/core/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/shared_prefs_constants/shared_prefs_constants.dart';

/// A class defined for save the data to shared preferences
class AppSettingsPrefs {
  final SharedPreferences _sharedPreferences;
  String? _cachedLocale;

  /// Clear the shared prefs
  clear() {
    _sharedPreferences.clear();
  }

  AppSettingsPrefs(
    this._sharedPreferences,
  );

  /// Setting up the app locale
  Future<void> setLocale({
    required String locale,
  }) async {
    _cachedLocale = locale;
    await _sharedPreferences.setString(
      SharedPrefsConstants.locale,
      locale,
    );
  }

  /// Get the app locale
  String getLocale() {
    _cachedLocale ??= _sharedPreferences.getString(
      SharedPrefsConstants.locale,
    );
    return _cachedLocale.pareWithDefaultLocale();
  }

  /// Set if the outBoarding viewed
  Future<void> setOutBoardingScreenViewed() async {
    await _sharedPreferences.setBool(
      SharedPrefsConstants.outBoardingViewed,
      true,
    );
  }

  /// Return true if outBoarding viewed
  bool getOutBoardingScreenViewed() {
    return _sharedPreferences
        .getBool(
          SharedPrefsConstants.outBoardingViewed,
        )
        .onNull();
  }

  /// Set if the user logged in is true
  Future<void> setUserLoggedIn() async {
    await _sharedPreferences.setBool(
      SharedPrefsConstants.isLoggedIn,
      true,
    );
  }

  /// Get if the user logged
  bool getUserLoggedIn() {
    return _sharedPreferences
        .getBool(
          SharedPrefsConstants.isLoggedIn,
        )
        .onNull();
  }

  /// Set the user token
  Future<void> setToken({
    required String token,
  }) async {
    await _sharedPreferences.setString(
      SharedPrefsConstants.token,
      token,
    );
  }

  /// Get the user token
  String getToken() {
    return _sharedPreferences.getString(SharedPrefsConstants.token).onNull();
  }

  /// Save full user data after login.
  /// Always overwrites every identity field so a previous account cannot linger
  /// (e.g. null image must remove the old avatar URL from prefs).
  Future<void> setUserData(UserModel user) async {
    await _sharedPreferences.setString(SharedPrefsConstants.userId, user.id);
    await _sharedPreferences.setString(
        SharedPrefsConstants.userFullName, user.fullName);
    await _sharedPreferences.setString(
        SharedPrefsConstants.userRole, user.role);
    await _sharedPreferences.setString(
        SharedPrefsConstants.userPhone, user.phoneNumber);

    final image = user.image;
    if (image != null && image.isNotEmpty) {
      await _sharedPreferences.setString(SharedPrefsConstants.userImage, image);
    } else {
      await _sharedPreferences.remove(SharedPrefsConstants.userImage);
    }

    // Shop fields belong to the previous account unless this login is a shop —
    // clear them so getShopName / getShopLogo cannot fall back to stale values.
    await _sharedPreferences.remove(SharedPrefsConstants.shopName);
    await _sharedPreferences.remove(SharedPrefsConstants.shopLogo);
  }

  /// Get the stored user id.
  /// Falls back to decoding the JWT token if the stored id is empty.
  String getUserId() {
    final storedId =
        _sharedPreferences.getString(SharedPrefsConstants.userId).onNull();
    if (storedId.isNotEmpty) return storedId;

    // Fallback: extract "sub" from JWT payload
    final token = getToken();
    if (token.isEmpty) return '';
    try {
      final parts = token.split('.');
      if (parts.length != 3) return '';
      String payload = parts[1];
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }
      final decoded = utf8.decode(base64Url.decode(payload));
      final json = jsonDecode(decoded) as Map<String, dynamic>;
      final sub = (json['sub'] as String?) ?? '';
      if (sub.isNotEmpty) {
        _sharedPreferences.setString(SharedPrefsConstants.userId, sub);
      }
      return sub;
    } catch (_) {
      return '';
    }
  }

  /// Get the stored user full name
  String getUserFullName() {
    return _sharedPreferences
        .getString(SharedPrefsConstants.userFullName)
        .onNull();
  }

  /// Get the stored user role (e.g. user, provider)
  String getUserRole() {
    return _sharedPreferences.getString(SharedPrefsConstants.userRole).onNull();
  }

  /// Get the stored user phone number
  String getUserPhone() {
    return _sharedPreferences
        .getString(SharedPrefsConstants.userPhone)
        .onNull();
  }

  /// Get the stored user image url
  String? getUserImage() {
    return _sharedPreferences.getString(SharedPrefsConstants.userImage);
  }

  /// Update only the stored user full name (called after a successful profile edit).
  Future<void> setUserFullName(String fullName) async {
    await _sharedPreferences.setString(
      SharedPrefsConstants.userFullName,
      fullName,
    );
  }

  /// Update only the stored user image URL (called after a successful profile edit).
  /// Pass null or empty to clear a previous account's avatar.
  Future<void> setUserImage(String? imageUrl) async {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      await _sharedPreferences.setString(
        SharedPrefsConstants.userImage,
        imageUrl,
      );
    } else {
      await _sharedPreferences.remove(SharedPrefsConstants.userImage);
    }
  }

  /// Save the shop/business name (shop owner).
  /// Falls back to [getUserFullName] when the key is not set.
  Future<void> setShopName(String name) async {
    if (name.isNotEmpty) {
      await _sharedPreferences.setString(
        SharedPrefsConstants.shopName,
        name,
      );
    }
  }

  /// Get the stored shop/business name.
  /// Falls back to the owner full name if not set.
  String getShopName() {
    final stored =
        _sharedPreferences.getString(SharedPrefsConstants.shopName).onNull();
    return stored.isNotEmpty ? stored : getUserFullName();
  }

  /// Save the shop logo URL (shop owner).
  Future<void> setShopLogo(String logoUrl) async {
    if (logoUrl.isNotEmpty) {
      await _sharedPreferences.setString(
        SharedPrefsConstants.shopLogo,
        logoUrl,
      );
    }
  }

  /// Get the stored shop logo URL. Falls back to [getUserImage] if not set.
  String? getShopLogo() {
    return _sharedPreferences.getString(SharedPrefsConstants.shopLogo) ??
        getUserImage();
  }

  /// Saves the pre-login audience chosen after onboarding.
  /// [audience] must be `visitor` or `tailor`.
  Future<void> setAuthAudience(String audience) async {
    await _sharedPreferences.setString(
      SharedPrefsConstants.authAudience,
      audience,
    );
  }

  /// Returns `visitor`, `tailor`, or empty when not chosen yet.
  String getAuthAudience() {
    return _sharedPreferences
        .getString(SharedPrefsConstants.authAudience)
        .onNull();
  }

  bool get hasAuthAudience => getAuthAudience().isNotEmpty;

  bool get isTailorAudience => getAuthAudience() == 'tailor';

  bool get isVisitorAudience => getAuthAudience() == 'visitor';

  /// Clears all authentication-related data while preserving locale,
  /// onboarding, and the pre-login audience choice.
  Future<void> clearAuthData() async {
    await _sharedPreferences.remove(SharedPrefsConstants.token);
    await _sharedPreferences.remove(SharedPrefsConstants.isLoggedIn);
    await _sharedPreferences.remove(SharedPrefsConstants.userId);
    await _sharedPreferences.remove(SharedPrefsConstants.userFullName);
    await _sharedPreferences.remove(SharedPrefsConstants.userRole);
    await _sharedPreferences.remove(SharedPrefsConstants.userPhone);
    await _sharedPreferences.remove(SharedPrefsConstants.userImage);
    await _sharedPreferences.remove(SharedPrefsConstants.shopName);
    await _sharedPreferences.remove(SharedPrefsConstants.shopLogo);
  }
}
