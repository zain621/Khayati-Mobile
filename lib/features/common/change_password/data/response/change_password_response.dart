import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  ChangePasswordResponse({
    this.status,
    this.code,
    this.message,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ChangePasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePasswordResponseToJson(this);
}
