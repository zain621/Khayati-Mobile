import 'package:json_annotation/json_annotation.dart';
import '../../../../constants/response_constants/response_constants.dart';

part 'provider_register_response.g.dart';

/// Inner data object: contains the request ID.
@JsonSerializable()
class ProviderRegisterDataResponse {
  @JsonKey(name: ResponseConstants.requestId)
  String? requestId;

  ProviderRegisterDataResponse({this.requestId});

  factory ProviderRegisterDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderRegisterDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderRegisterDataResponseToJson(this);
}

/// Top-level provider register response wrapper.
@JsonSerializable()
class ProviderRegisterResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ProviderRegisterDataResponse? data;

  ProviderRegisterResponse({this.status, this.code, this.message, this.data});

  factory ProviderRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$ProviderRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderRegisterResponseToJson(this);
}
