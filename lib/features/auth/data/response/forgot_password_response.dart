import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'forgot_password_response.g.dart';

/// Inner data: contains the userId needed for subsequent steps.
@JsonSerializable()
class ForgotPasswordDataResponse {
  @JsonKey(name: ResponseConstants.userId)
  String? userId;

  ForgotPasswordDataResponse({this.userId});

  factory ForgotPasswordDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordDataResponseToJson(this);
}

/// Top-level response for POST /auth/forgot-password.
@JsonSerializable()
class ForgotPasswordResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ForgotPasswordDataResponse? data;

  ForgotPasswordResponse({this.status, this.code, this.message, this.data});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
