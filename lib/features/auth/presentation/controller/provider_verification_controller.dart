import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:app_mobile/core/service/session_reset_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import '../../data/request/complete_login_with_code_request.dart';
import '../../data/request/login_request.dart';
import '../../domain/model/login_model.dart';
import '../../domain/use_case/complete_login_with_code_use_case.dart';
import '../../domain/use_case/login_use_case.dart';

class ProviderVerificationController extends GetxController {
  final CompleteLoginWithCodeUseCase _completeLoginUseCase;
  final LoginUseCase _loginUseCase;
  final AppSettingsPrefs _appSettingsPrefs;
  final String phoneNumber;

  ProviderVerificationController(
    this._completeLoginUseCase,
    this._loginUseCase,
    this._appSettingsPrefs,
    this.phoneNumber,
  );

  final RxBool isLoading = false.obs;

  /// Submits the 6-digit OTP to complete the provider login.
  Future<void> verifyCode(String code) async {
    if (code.length < 6) {
      AppSnackbar.warning(
        ManagerStrings.verifyCodeErrorEmpty,
        englishMessage: ManagerStrings.verifyCodeErrorEmptyEn,
      );
      return;
    }

    isLoading.value = true;

    final request = CompleteLoginWithCodeRequest(
      phoneNumber: phoneNumber,
      code: code,
    );
    final Either<Failure, LoginModel> result =
        await _completeLoginUseCase.execute(request);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) async {
        final loginData = data.data;
        final user = loginData.user;
        final accessToken = loginData.accessToken;

        if (user == null || accessToken == null || accessToken.isEmpty) {
          AppSnackbar.error(data.message);
          return;
        }

        await _appSettingsPrefs.clearAuthData();
        await _appSettingsPrefs.setToken(token: accessToken);
        await _appSettingsPrefs.setUserLoggedIn();
        await _appSettingsPrefs.setUserData(user);

        await registerPushAfterAuth();

        AppSnackbar.success(
          ManagerStrings.providerLoginOtpSuccess,
          englishMessage: ManagerStrings.providerLoginOtpSuccessEn,
        );

        _navigateByRole(user.role);
      },
    );

    isLoading.value = false;
  }

  /// Resends login OTP via POST /auth/login (same as first send).
  Future<void> resendCode() async {
    final result = await _loginUseCase.execute(
      LoginRequest(phoneNumber: phoneNumber),
    );
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) => AppSnackbar.success(
        ManagerStrings.resendCodeSuccess,
        englishMessage: ManagerStrings.resendCodeSuccessEn,
      ),
    );
  }

  /// Routes the provider to the correct home screen based on their role.
  void _navigateByRole(String role) {
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
}
