import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:app_mobile/core/service/session_reset_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/util/phone_validator.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import '../../data/request/login_request.dart';
import '../../domain/model/demo_accounts.dart';
import '../../domain/model/login_model.dart';
import '../../domain/use_case/login_use_case.dart';

class LoginController extends GetxController {
  final LoginUseCase _loginUseCase;
  final AppSettingsPrefs _appSettingsPrefs;

  LoginController(this._loginUseCase, this._appSettingsPrefs);

  // Text controllers
  final TextEditingController phoneController = TextEditingController();

  // Selected country code for phone field
  final RxString selectedCountryCode = '+971'.obs;

  // State
  final RxBool isLoading = false.obs;

  Future<void> applyDemoAccount(DemoAccount account) async {
    selectedCountryCode.value = account.dialCode;
    phoneController.text = account.nationalNumber;
    phoneController.selection = TextSelection.collapsed(
      offset: phoneController.text.length,
    );
  }

  Future<void> login() async {
    // Validate phone
    final phoneError = PhoneValidator.validate(
      phoneController.text,
      selectedCountryCode.value,
    );
    if (phoneError == PhoneValidationError.empty) {
      AppSnackbar.warning(
        ManagerStrings.loginErrorPhoneEmpty,
        englishMessage: ManagerStrings.loginErrorPhoneEmptyEn,
      );
      return;
    }
    if (phoneError == PhoneValidationError.invalid) {
      AppSnackbar.warning(
        ManagerStrings.loginErrorPhoneInvalid,
        englishMessage: ManagerStrings.loginErrorPhoneInvalidEn,
      );
      return;
    }

    isLoading.value = true;

    final phoneNumber = PhoneValidator.toE164(
      phoneController.text,
      selectedCountryCode.value,
    );
    final request = LoginRequest(
      phoneNumber: phoneNumber,
    );

    final Either<Failure, LoginModel> result =
        await _loginUseCase.execute(request);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) async {
        final loginData = data.data;
        // OTP was sent — wipe previous account identity first so temp token
        // cannot sit next to the old user's name/avatar in prefs.
        if (loginData.needsVerification) {
          await _appSettingsPrefs.clearAuthData();
          final temporaryToken = loginData.temporaryToken;
          if (temporaryToken != null && temporaryToken.isNotEmpty) {
            await _appSettingsPrefs.setToken(token: temporaryToken);
          }

          AppSnackbar.success(
            ManagerStrings.loginOtpSent,
            englishMessage: ManagerStrings.loginOtpSent,
          );

          final demoOtp = DemoAccounts.isDemoPhone(phoneNumber)
              ? DemoAccounts.otp
              : loginData.otpCode;
          Get.toNamed(
            Routes.providerLoginVerification,
            arguments: {
              'phoneNumber': phoneNumber,
              if (demoOtp != null && demoOtp.isNotEmpty) 'otpCode': demoOtp,
            },
          );
          return;
        }

        // Normal login success — clear any leftover identity, then write new.
        final user = loginData.user;
        final accessToken = loginData.accessToken;
        if (user == null || accessToken == null || accessToken.isEmpty) {
          AppSnackbar.error(
            data.message.isNotEmpty
                ? data.message
                : ManagerStrings.loginUserNotFound,
          );
          return;
        }

        await _appSettingsPrefs.clearAuthData();
        await _appSettingsPrefs.setToken(token: accessToken);
        await _appSettingsPrefs.setUserLoggedIn();
        await _appSettingsPrefs.setUserData(user);

        await registerPushAfterAuth();

        AppSnackbar.success(
          ManagerStrings.loginSuccess,
          englishMessage: ManagerStrings.loginSuccessEn,
        );

        // Navigate based on role returned from the API
        _navigateByRole(user.role);
      },
    );

    isLoading.value = false;
  }

  /// Routes the user to the correct home screen based on their role.
  /// Additional roles will be wired here as they are defined.
  void _navigateByRole(String role) {
    // Clear previous account controllers before opening home. Home screens
    // then forceRefresh on initState. Provider dispose must NOT Get.delete
    // (that races with offAllNamed and wipes the new session).
    resetSessionControllers();
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
        Get.offAllNamed(Routes.loginScreen);
        break;
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
