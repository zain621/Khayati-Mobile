import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/forgot_password_response.dart';
import '../../domain/model/forgot_password_model.dart';

/// Maps ForgotPasswordResponse → ForgotPasswordModel.
extension ForgotPasswordMapper on ForgotPasswordResponse {
  ForgotPasswordModel toDomain() {
    return ForgotPasswordModel(
      userId: data?.userId.onNull() ?? '',
    );
  }
}
