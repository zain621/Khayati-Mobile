import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.fullName)
  String? fullName;

  @JsonKey(name: ResponseConstants.latitude)
  double? latitude;

  @JsonKey(name: ResponseConstants.longitude)
  double? longitude;

  @JsonKey(name: ResponseConstants.detailedDescription)
  String? detailedDescription;

  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  String? updatedAt;

  AddressDataResponse({
    this.id,
    this.fullName,
    this.latitude,
    this.longitude,
    this.detailedDescription,
    this.createdAt,
    this.updatedAt,
  });

  factory AddressDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataResponseToJson(this);
}

@JsonSerializable()
class AddressResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  AddressDataResponse? data;

  AddressResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseToJson(this);
}
