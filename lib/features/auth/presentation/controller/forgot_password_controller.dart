import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/use_case/forgot_password_use_case.dart';
import '../../domain/use_case/verify_code_use_case.dart';
import '../../domain/use_case/resend_code_use_case.dart';
import '../../domain/use_case/reset_password_use_case.dart';

class ForgotPasswordController extends GetxController {
  final ForgotPasswordUseCase _forgotPasswordUseCase;
  final VerifyCodeUseCase _verifyCodeUseCase;
  final ResendCodeUseCase _resendCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgotPasswordController(
    this._forgotPasswordUseCase,
    this._verifyCodeUseCase,
    this._resendCodeUseCase,
    this._resetPasswordUseCase,
  );

  // Text controllers
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // State
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;

  // Stored between screens
  String? _userId;
  String? _phoneNumber;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // ─────────────────────────────────────────────────
  // Step 1: Send OTP
  // ─────────────────────────────────────────────────

  Future<void> sendForgotPassword() async {
    final phone = phoneController.text.trim();

    if (phone.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.resetPasswordErrorPhoneEmpty,
        englishMessage: ManagerStrings.resetPasswordErrorPhoneEmptyEn,
      );
      return;
    }

    isLoading.value = true;

    final result = await _forgotPasswordUseCase.execute(phone);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        _userId = data.userId;
        _phoneNumber = phone;

        AppSnackbar.success(
          ManagerStrings.forgotPasswordSuccess,
          englishMessage: ManagerStrings.forgotPasswordSuccessEn,
        );

        Get.toNamed(Routes.verificationCode, arguments: {
          'phoneNumber': phone,
        });
      },
    );

    isLoading.value = false;
  }

  // ─────────────────────────────────────────────────
  // Step 2: Verify OTP
  // ─────────────────────────────────────────────────

  Future<void> verifyCode(String code) async {
    if (code.length < 6) {
      AppSnackbar.warning(
        ManagerStrings.verifyCodeErrorEmpty,
        englishMessage: ManagerStrings.verifyCodeErrorEmptyEn,
      );
      return;
    }

    if (_userId == null) {
      AppSnackbar.error('حدث خطأ، يرجى المحاولة مرة أخرى');
      return;
    }

    isLoading.value = true;

    final result = await _verifyCodeUseCase
        .execute(VerifyCodeUseCaseInput(userId: _userId!, code: code));

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (_) {
        AppSnackbar.success(
          ManagerStrings.verifyCodeSuccess,
          englishMessage: ManagerStrings.verifyCodeSuccessEn,
        );
        Get.toNamed(Routes.newPassword);
      },
    );

    isLoading.value = false;
  }

  // ─────────────────────────────────────────────────
  // Step 2b: Resend OTP
  // ─────────────────────────────────────────────────

  Future<void> resendCode() async {
    if (_phoneNumber == null) return;

    isLoading.value = true;

    final result = await _resendCodeUseCase.execute(_phoneNumber!);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        _userId = data.userId;

        AppSnackbar.success(
          ManagerStrings.resendCodeSuccess,
          englishMessage: ManagerStrings.resendCodeSuccessEn,
        );
      },
    );

    isLoading.value = false;
  }

  // ─────────────────────────────────────────────────
  // Step 3: Reset Password
  // ─────────────────────────────────────────────────

  Future<void> resetPassword() async {
    final newPass = newPasswordController.text.trim();
    final confirmPass = confirmPasswordController.text.trim();

    if (newPass.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.newPasswordErrorEmpty,
        englishMessage: ManagerStrings.newPasswordErrorEmptyEn,
      );
      return;
    }

    if (newPass.length < 8) {
      AppSnackbar.warning(
        ManagerStrings.newPasswordErrorTooShort,
        englishMessage: ManagerStrings.newPasswordErrorTooShortEn,
      );
      return;
    }

    if (confirmPass.isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.newPasswordErrorConfirmEmpty,
        englishMessage: ManagerStrings.newPasswordErrorConfirmEmptyEn,
      );
      return;
    }

    if (newPass != confirmPass) {
      AppSnackbar.warning(
        ManagerStrings.newPasswordErrorMismatch,
        englishMessage: ManagerStrings.newPasswordErrorMismatchEn,
      );
      return;
    }

    if (_userId == null) {
      AppSnackbar.error('حدث خطأ، يرجى المحاولة مرة أخرى');
      return;
    }

    isLoading.value = true;

    final result = await _resetPasswordUseCase.execute(
      ResetPasswordUseCaseInput(userId: _userId!, newPassword: newPass),
    );

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (_) {
        AppSnackbar.success(
          ManagerStrings.resetPasswordFlowSuccess,
          englishMessage: ManagerStrings.resetPasswordFlowSuccessEn,
        );
        Get.offAllNamed(Routes.passwordChangedSuccess);
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    phoneController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
