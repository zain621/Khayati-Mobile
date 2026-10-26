import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'verify_code_response.g.dart';

/// Top-level response for POST /auth/verify-code (data is empty object).
@JsonSerializable()
class VerifyCodeResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  VerifyCodeResponse({this.status, this.code, this.message});

  factory VerifyCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeResponseToJson(this);
}
