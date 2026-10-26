import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'shop_owner_profile_response.g.dart';

@JsonSerializable()
class ShopOwnerProfileDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.nameAr)
  String? nameAr;

  @JsonKey(name: ResponseConstants.nameEn)
  String? nameEn;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.coverImageUrl)
  String? coverImageUrl;

  @JsonKey(name: ResponseConstants.bio)
  String? bio;

  @JsonKey(name: ResponseConstants.isAvailable)
  bool? isAvailable;

  @JsonKey(name: ResponseConstants.rating)
  double? rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  int? ratersCount;

  @JsonKey(name: ResponseConstants.productsCount)
  int? productsCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  int? completedOrdersCount;

  ShopOwnerProfileDataResponse({
    this.id,
    this.nameAr,
    this.nameEn,
    this.imageUrl,
    this.coverImageUrl,
    this.bio,
    this.isAvailable,
    this.rating,
    this.ratersCount,
    this.productsCount,
    this.completedOrdersCount,
  });

  factory ShopOwnerProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerProfileDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerProfileDataResponseToJson(this);
}

@JsonSerializable()
class ShopOwnerProfileResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  ShopOwnerProfileDataResponse? data;

  ShopOwnerProfileResponse({this.status, this.code, this.message, this.data});

  factory ShopOwnerProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopOwnerProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopOwnerProfileResponseToJson(this);
}
