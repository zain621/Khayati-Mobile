import 'package:app_mobile/core/service/push_notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/util/phone_validator.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import '../../data/request/customer_register_request.dart';
import '../../data/request/customer_register_verify_request.dart';
import '../../domain/model/customer_register_model.dart';
import '../../domain/model/login_model.dart';
import '../../domain/use_case/customer_register_use_case.dart';
import '../../domain/use_case/customer_register_verify_use_case.dart';

class CustomerRegisterController extends GetxController {
  final CustomerRegisterUseCase _registerUseCase;
  final CustomerRegisterVerifyUseCase _verifyUseCase;
  final AppSettingsPrefs _appSettingsPrefs;

  CustomerRegisterController(
    this._registerUseCase,
    this._verifyUseCase,
    this._appSettingsPrefs,
  );

  // Text controllers — Register screen
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Selected country code for phone field
  final RxString selectedCountryCode = '+971'.obs;

  // Text controllers — Verification screen
  final TextEditingController codeController = TextEditingController();

  // State
  final RxBool isLoading = false.obs;

  // Holds phone from step-1 to pass into step-2 request
  String _registeredPhone = '';

  // ──────────────────────────────────────────────
  // Step 1 — Submit registration info
  // ──────────────────────────────────────────────
  Future<void> submitRegister() async {
    if (fullNameController.text.trim().isEmpty) {
      AppSnackbar.warning(
        ManagerStrings.registerErrorNameEmpty,
        englishMessage: ManagerStrings.registerErrorNameEmptyEn,
      );
      return;
    }

    final phoneError = PhoneValidator.validate(
      phoneController.text,
      selectedCountryCode.value,
    );
    if (phoneError == PhoneValidationError.empty) {
      AppSnackbar.warning(
        ManagerStrings.registerErrorPhoneEmpty,
        englishMessage: ManagerStrings.registerErrorPhoneEmptyEn,
      );
      return;
    }
    if (phoneError == PhoneValidationError.invalid) {
      AppSnackbar.warning(
        ManagerStrings.registerErrorPhoneInvalid,
        englishMessage: ManagerStrings.registerErrorPhoneInvalidEn,
      );
      return;
    }

    isLoading.value = true;

    final phoneNumber = PhoneValidator.toE164(
      phoneController.text,
      selectedCountryCode.value,
    );
    final request = CustomerRegisterRequest(
      fullName: fullNameController.text.trim(),
      phoneNumber: phoneNumber,
    );

    final Either<Failure, CustomerRegisterModel> result =
        await _registerUseCase.execute(request);

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        _registeredPhone = phoneNumber;
        final demoCode = data.verificationCode.trim();
        if (demoCode.isNotEmpty) {
          codeController.text = demoCode;
        }
        AppSnackbar.success(
          demoCode.isNotEmpty
              ? '${ManagerStrings.registerCodeSent} ($demoCode)'
              : ManagerStrings.registerCodeSent,
          englishMessage: ManagerStrings.registerCodeSentEn,
        );
        Get.toNamed(
          Routes.customerRegisterVerification,
          arguments: {'phoneNumber': _registeredPhone},
        );
      },
    );

    isLoading.value = false;
  }

  // ──────────────────────────────────────────────
  // Step 2 — Submit verification code
  // ──────────────────────────────────────────────
  Future<void> submitVerify() async {
    if (codeController.text.trim().length < 6) {
      AppSnackbar.warning(
        ManagerStrings.registerErrorCodeEmpty,
        englishMessage: ManagerStrings.registerErrorCodeEmptyEn,
      );
      return;
    }

    isLoading.value = true;

    final request = CustomerRegisterVerifyRequest(
      phoneNumber: _registeredPhone.isNotEmpty
          ? _registeredPhone
          : phoneController.text.trim(),
      code: codeController.text.trim(),
    );

    final Either<Failure, LoginModel> result =
        await _verifyUseCase.execute(request);

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
          ManagerStrings.registerVerifySuccess,
          englishMessage: ManagerStrings.registerVerifySuccessEn,
        );

        Get.toNamed(Routes.customerRegisterSuccess);
      },
    );

    isLoading.value = false;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    phoneController.dispose();
    codeController.dispose();
    super.onClose();
  }
}
