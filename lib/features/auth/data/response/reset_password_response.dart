import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'reset_password_response.g.dart';

/// Top-level response for POST /auth/reset-password (data is empty object).
@JsonSerializable()
class ResetPasswordResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  ResetPasswordResponse({this.status, this.code, this.message});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}
