import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:app_mobile/core/service/session_reset_service.dart';
import 'package:app_mobile/features/common/logout/domain/use_case/logout_use_case.dart';
import 'package:app_mobile/features/common/delete_account/domain/use_case/delete_account_use_case.dart';
import '../../domain/model/user_profile_model.dart';
import '../../domain/use_case/user_profile_use_case.dart';

class UserProfileController extends GetxController {
  final UserProfileUseCase _userProfileUseCase;
  final LogoutUseCase _logoutUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  UserProfileController(
    this._userProfileUseCase,
    this._logoutUseCase,
    this._deleteAccountUseCase,
  );

  // State
  final RxBool isLoading = true.obs;
  final RxBool isLoggingOut = false.obs;
  final RxBool isDeleting = false.obs;
  final Rxn<UserProfileModel> profile = Rxn<UserProfileModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  /// Fetches the user profile from the API.
  Future<void> fetchProfile() async {
    isLoading.value = true;

    final Either<Failure, UserProfileModel> result =
        await _userProfileUseCase.execute();

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) async {
        profile.value = data;
        // Keep SharedPreferences in sync so home header never shows a stale user.
        final prefs = instance<AppSettingsPrefs>();
        await prefs.setUserFullName(data.fullName);
        await prefs.setUserImage(data.image);
      },
    );

    isLoading.value = false;
  }

  /// Refreshes the profile data.
  Future<void> refreshProfile() async {
    await fetchProfile();
  }

  /// Calls the logout API, clears local auth data, and navigates to the
  /// post-logout screen (login again / close app).
  Future<void> logout() async {
    if (isLoggingOut.value) return;

    isLoggingOut.value = true;
    // Keep the premium overlay visible long enough for the animation to land.
    await Future.wait([
      unregisterPushOnLogout(),
      clearLocalAuthArtifacts(),
      Future.delayed(const Duration(milliseconds: 1400)),
    ]);
    unawaited(_logoutUseCase.execute());
    Get.offAllNamed(Routes.loggedOutScreen);
    resetSessionControllers();
  }

  /// Sends the delete account request, clears local auth data, and navigates to login.
  Future<void> deleteAccount() async {
    isDeleting.value = true;
    final Either<Failure, bool> result = await _deleteAccountUseCase.execute();
    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        isDeleting.value = false;
      },
      (_) async {
        AppSnackbar.success(
          ManagerStrings.deleteAccountSuccess,
          englishMessage: ManagerStrings.deleteAccountSuccessEn,
        );
        await unregisterPushOnLogout();
        await clearLocalAuthArtifacts();
        Get.offAllNamed(Routes.loginScreen);
        resetSessionControllers();
      },
    );
  }
}
