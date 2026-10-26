import 'package:get/get.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import '../../data/request/contact_us_request.dart';
import '../../domain/use_case/contact_us_use_case.dart';

class ContactUsController extends GetxController {
  final ContactUsUseCase _contactUsUseCase;

  ContactUsController({required ContactUsUseCase contactUsUseCase})
      : _contactUsUseCase = contactUsUseCase;

  final isSubmitting = false.obs;

  String? _validate(String name, String email, String subject, String message) {
    if (name.isEmpty || email.isEmpty || subject.isEmpty || message.isEmpty) {
      return ManagerStrings.contactUsFillAllFields;
    }
    return null;
  }

  Future<void> submitContactUs({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final error = _validate(name, email, subject, message);
    if (error != null) {
      AppSnackbar.error(
        error,
        englishMessage: ManagerStrings.contactUsFillAllFieldsEn,
      );
      return;
    }

    isSubmitting.value = true;

    final result = await _contactUsUseCase.execute(
      ContactUsRequest(
        name: name,
        email: email,
        subject: subject,
        message: message,
      ),
    );

    isSubmitting.value = false;

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (model) => AppSnackbar.success(
        model.message.isNotEmpty
            ? model.message
            : ManagerStrings.contactUsSendSuccess,
        englishMessage: ManagerStrings.contactUsSendSuccessEn,
      ),
    );
  }
}
