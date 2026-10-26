import 'package:app_mobile/core/extensions/extensions.dart';
import 'package:app_mobile/core/mapper/user_mapper.dart';
import '../response/login_response.dart';
import '../../domain/model/login_model.dart';

/// Maps LoginDataResponse → LoginDataModel.
extension LoginDataMapper on LoginDataResponse {
  LoginDataModel toDomain() {
    return LoginDataModel(
      accessToken: accessToken,
      user: user?.toDomain(),
      requiresVerification: requiresVerification.onNull(),
      temporaryToken: temporaryToken,
      otpCode: otpCode,
    );
  }
}

/// Maps LoginResponse → LoginModel.
extension LoginMapper on LoginResponse {
  LoginModel toDomain() {
    return LoginModel(
      status: status.onNull(),
      code: code.onNull(),
      message: message.onNull(),
      data: data?.toDomain() ?? LoginDataModel(),
    );
  }
}
