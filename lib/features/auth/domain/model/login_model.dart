import 'package:app_mobile/core/model/user_model.dart';

/// Domain model for the login data payload.
/// When requiresVerification is true, accessToken and user will be null,
/// and temporaryToken will be set instead.
class LoginDataModel {
  final String? accessToken;
  final UserModel? user;
  final bool requiresVerification;
  final String? temporaryToken;
  final String? otpCode;

  LoginDataModel({
    this.accessToken,
    this.user,
    this.requiresVerification = false,
    this.temporaryToken,
    this.otpCode,
  });

  bool get hasAuthenticatedSession =>
      accessToken != null && accessToken!.isNotEmpty && user != null;

  bool get needsVerification =>
      requiresVerification ||
      (otpCode != null && otpCode!.isNotEmpty) ||
      !hasAuthenticatedSession;
}

/// Top-level domain model for the login API response.
class LoginModel {
  final String status;
  final int code;
  final String message;
  final LoginDataModel data;

  LoginModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });
}
