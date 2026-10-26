import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'update_shop_owner_availability_response.g.dart';

@JsonSerializable()
class UpdateShopOwnerAvailabilityResponse {
  @JsonKey(name: ResponseConstants.status)  String? status;
  @JsonKey(name: ResponseConstants.code)    int? code;
  @JsonKey(name: ResponseConstants.message) String? message;
  @JsonKey(name: ResponseConstants.data)    UpdateShopOwnerAvailabilityDataResponse? data;

  UpdateShopOwnerAvailabilityResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory UpdateShopOwnerAvailabilityResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateShopOwnerAvailabilityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateShopOwnerAvailabilityResponseToJson(this);
}

@JsonSerializable()
class UpdateShopOwnerAvailabilityDataResponse {
  @JsonKey(name: ResponseConstants.shopIsOpen) bool? isOpen;

  UpdateShopOwnerAvailabilityDataResponse({this.isOpen});

  factory UpdateShopOwnerAvailabilityDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateShopOwnerAvailabilityDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateShopOwnerAvailabilityDataResponseToJson(this);
}
