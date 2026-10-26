import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final AppSettingsPrefs _appSettingsPrefs;

  SplashController(this._appSettingsPrefs);

  /// Called after the splash animation finishes.
  /// Decides where to send the user based on:
  ///  1. Whether OnBoarding was seen before
  ///  2. Whether the user is logged in
  ///  3. The user's role
  void navigateAfterSplash() {
    // First visit → show OnBoarding
    if (!_appSettingsPrefs.getOutBoardingScreenViewed()) {
      Get.offAllNamed(Routes.onBoarding);
      return;
    }

    // Not logged in → role pick first, then login
    if (!_appSettingsPrefs.getUserLoggedIn()) {
      if (!_appSettingsPrefs.hasAuthAudience) {
        Get.offAllNamed(Routes.authRoleSelection);
      } else {
        Get.offAllNamed(Routes.loginScreen);
      }
      return;
    }

    // Refresh FCM token for returning sessions
    registerPushAfterAuth();

    // Logged in → route by role
    _navigateByRole(_appSettingsPrefs.getUserRole());
  }

  void _navigateByRole(String role) {
    switch (role) {
      case 'user':
        Get.offAllNamed(Routes.mainNavigation);
        break;
      case 'independent_tailor':
        Get.offAllNamed(Routes.independentTailorHome);
        break;
      case 'shop_owner':
        Get.offAllNamed(Routes.storeTailorHome);
        break;
      case 'comprehensive_tailor':
        Get.offAllNamed(Routes.comprehensiveTailorHome);
        break;
      default:
        // Fallback: send to login so the user can re-authenticate
        Get.offAllNamed(Routes.loginScreen);
        break;
    }
  }
}
