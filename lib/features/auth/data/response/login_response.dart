import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';
import '../../../../../core/response/user_response.dart';

part 'login_response.g.dart';

int? _loginStatusCodeFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

/// Inner data object: contains either (accessToken + user) for normal login,
/// or (requiresVerification + temporaryToken) when OTP is required.
@JsonSerializable()
class LoginDataResponse {
  @JsonKey(name: ResponseConstants.accessToken)
  String? accessToken;

  @JsonKey(name: ResponseConstants.user)
  UserResponse? user;

  @JsonKey(name: ResponseConstants.requiresVerification)
  bool? requiresVerification;

  @JsonKey(name: ResponseConstants.temporaryToken)
  String? temporaryToken;

  @JsonKey(name: 'otpCode')
  String? otpCode;

  LoginDataResponse({
    this.accessToken,
    this.user,
    this.requiresVerification,
    this.temporaryToken,
    this.otpCode,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);
}

/// Top-level login response wrapper.
@JsonSerializable()
class LoginResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code, fromJson: _loginStatusCodeFromJson)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  LoginDataResponse? data;

  LoginResponse({this.status, this.code, this.message, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
