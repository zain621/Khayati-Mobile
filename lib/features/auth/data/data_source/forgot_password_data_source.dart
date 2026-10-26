import 'package:app_mobile/core/network/app_api.dart';
import '../response/forgot_password_response.dart';
import '../response/verify_code_response.dart';
import '../response/reset_password_response.dart';

abstract class ForgotPasswordDataSource {
  Future<ForgotPasswordResponse> forgotPassword(String phoneNumber);
  Future<VerifyCodeResponse> verifyCode(String userId, String code);
  Future<ForgotPasswordResponse> resendCode(String phoneNumber);
  Future<ResetPasswordResponse> resetPassword(String userId, String newPassword);
}

class ForgotPasswordDataSourceImplement implements ForgotPasswordDataSource {
  final AppService _appService;

  ForgotPasswordDataSourceImplement(this._appService);

  @override
  Future<ForgotPasswordResponse> forgotPassword(String phoneNumber) async {
    return await _appService.forgotPassword(phoneNumber);
  }

  @override
  Future<VerifyCodeResponse> verifyCode(String userId, String code) async {
    return await _appService.verifyCode(userId, code);
  }

  @override
  Future<ForgotPasswordResponse> resendCode(String phoneNumber) async {
    return await _appService.resendCode(phoneNumber);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(
      String userId, String newPassword) async {
    return await _appService.resetPassword(userId, newPassword);
  }
}
