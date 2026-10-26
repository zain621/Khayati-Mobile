import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/change_password_request.dart';
import '../../domain/use_case/change_password_use_case.dart';

class ChangePasswordController extends GetxController {
  final ChangePasswordUseCase _changePasswordUseCase;

  ChangePasswordController({
    required ChangePasswordUseCase changePasswordUseCase,
  }) : _changePasswordUseCase = changePasswordUseCase;

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isSubmitting = false.obs;
  final currentObscure = true.obs;
  final newObscure = true.obs;
  final confirmObscure = true.obs;

  String? validate() {
    final current = currentPasswordController.text.trim();
    final newPass = newPasswordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
      return ManagerStrings.contactUsFillAllFields;
    }
    if (newPass.length < 6) {
      return ManagerStrings.newPasswordErrorTooShort;
    }
    if (newPass != confirm) {
      return ManagerStrings.newPasswordErrorMismatch;
    }
    return null;
  }

  Future<void> submit() async {
    final error = validate();
    if (error != null) {
      AppSnackbar.error(error);
      return;
    }

    isSubmitting.value = true;

    final result = await _changePasswordUseCase.execute(
      ChangePasswordRequest(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      ),
    );

    isSubmitting.value = false;

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (message) {
        AppSnackbar.success(
          message.isNotEmpty ? message : 'تم تغيير كلمة المرور بنجاح',
        );
        Get.back();
      },
    );
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
