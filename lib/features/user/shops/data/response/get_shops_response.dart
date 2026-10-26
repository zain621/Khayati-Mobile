import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'get_shops_response.g.dart';

@JsonSerializable()
class GetShopsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  GetShopsDataResponse? data;

  GetShopsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetShopsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetShopsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetShopsResponseToJson(this);
}

@JsonSerializable()
class GetShopsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<ShopItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  int? total;

  @JsonKey(name: ResponseConstants.ads)
  List<AdItemResponse>? ads;

  GetShopsDataResponse({
    this.items,
    this.total,
    this.ads,
  });

  factory GetShopsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetShopsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetShopsDataResponseToJson(this);
}

@JsonSerializable()
class ShopItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.userId)
  String? userId;

  @JsonKey(name: ResponseConstants.productsCount)
  int? productsCount;

  @JsonKey(name: ResponseConstants.rating)
  num? rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  int? ratersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.latitude)
  double? latitude;

  @JsonKey(name: ResponseConstants.longitude)
  double? longitude;

  ShopItemResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.userId,
    this.productsCount,
    this.rating,
    this.ratersCount,
    this.completedOrdersCount,
    this.latitude,
    this.longitude,
  });

  factory ShopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopItemResponseToJson(this);
}

@JsonSerializable()
class AdItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.linkUrl)
  String? linkUrl;

  @JsonKey(name: ResponseConstants.adTitle)
  String? title;

  @JsonKey(name: ResponseConstants.adSubtitle)
  String? subtitle;

  AdItemResponse({
    this.id,
    this.imageUrl,
    this.linkUrl,
    this.title,
    this.subtitle,
  });

  factory AdItemResponse.fromJson(Map<String, dynamic> json) =>
      _$AdItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AdItemResponseToJson(this);
}
