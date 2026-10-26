import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'customer_register_response.g.dart';

/// Inner data object: contains only the verification code sent to the user.
@JsonSerializable()
class CustomerRegisterDataResponse {
  @JsonKey(name: ResponseConstants.code)
  String? code;

  CustomerRegisterDataResponse({this.code});

  factory CustomerRegisterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerRegisterDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRegisterDataResponseToJson(this);
}

/// Top-level register step-1 response wrapper.
@JsonSerializable()
class CustomerRegisterResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  CustomerRegisterDataResponse? data;

  CustomerRegisterResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory CustomerRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRegisterResponseToJson(this);
}
