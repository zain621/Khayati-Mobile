import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'get_top_shops_response.g.dart';

// Handles polymorphic address: null | String | Map (object with fullName etc.)
String? _topShopAddressFromJson(dynamic value) {
  if (value == null) return null;
  if (value is String) return value.trim().isEmpty ? null : value.trim();
  if (value is Map<String, dynamic>) {
    final fullName = value['fullName'] as String?;
    return fullName?.replaceAll('"', '').trim().isEmpty == false
        ? fullName!.replaceAll('"', '').trim()
        : (value['detailedDescription'] as String?)
            ?.replaceAll('"', '')
            .trim();
  }
  return null;
}

@JsonSerializable()
class GetTopShopsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  GetTopShopsDataResponse? data;

  GetTopShopsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory GetTopShopsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTopShopsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTopShopsResponseToJson(this);
}

@JsonSerializable()
class GetTopShopsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<TopShopItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  int? total;

  GetTopShopsDataResponse({
    this.items,
    this.total,
  });

  factory GetTopShopsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetTopShopsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetTopShopsDataResponseToJson(this);
}

@JsonSerializable()
class TopShopItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.userId)
  String? userId;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.coverImageUrl)
  String? coverImageUrl;

  @JsonKey(name: ResponseConstants.isAvailable)
  bool? isAvailable;

  @JsonKey(name: ResponseConstants.rating)
  num? rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  int? ratersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.productsCount)
  int? productsCount;

  @JsonKey(name: ResponseConstants.bio)
  String? bio;

  @JsonKey(name: ResponseConstants.specializations)
  List<String>? specializations;

  @JsonKey(name: ResponseConstants.address, fromJson: _topShopAddressFromJson)
  String? address;

  @JsonKey(name: ResponseConstants.categories)
  List<TopShopCategoryResponse>? categories;

  @JsonKey(name: ResponseConstants.products)
  List<TopShopProductResponse>? products;

  TopShopItemResponse({
    this.id,
    this.userId,
    this.name,
    this.imageUrl,
    this.coverImageUrl,
    this.isAvailable,
    this.rating,
    this.ratersCount,
    this.completedOrdersCount,
    this.productsCount,
    this.bio,
    this.specializations,
    this.address,
    this.categories,
    this.products,
  });

  factory TopShopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopShopItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopShopItemResponseToJson(this);
}

@JsonSerializable()
class TopShopCategoryResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.productsCount)
  int? productsCount;

  @JsonKey(name: ResponseConstants.products)
  List<TopShopProductResponse>? products;

  TopShopCategoryResponse({
    this.id,
    this.name,
    this.productsCount,
    this.products,
  });

  factory TopShopCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TopShopCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopShopCategoryResponseToJson(this);
}

@JsonSerializable()
class TopShopProductResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;

  @JsonKey(name: ResponseConstants.variantId)
  String? variantId;

  @JsonKey(name: ResponseConstants.variantColor)
  String? variantColor;

  @JsonKey(name: ResponseConstants.variantSize)
  String? variantSize;

  @JsonKey(name: ResponseConstants.name)
  String? name;

  @JsonKey(name: ResponseConstants.shopName)
  String? shopName;

  @JsonKey(name: ResponseConstants.shopId)
  String? shopId;

  @JsonKey(name: ResponseConstants.price)
  num? price;

  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  num? priceBeforeDiscount;

  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;

  @JsonKey(name: ResponseConstants.isBestSelling)
  bool? isBestSelling;

  @JsonKey(name: ResponseConstants.rating)
  num? rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  int? ratersCount;

  @JsonKey(name: ResponseConstants.isAvailable)
  bool? isAvailable;

  @JsonKey(name: ResponseConstants.categoryId)
  String? categoryId;

  @JsonKey(name: ResponseConstants.categoryName)
  String? categoryName;

  @JsonKey(name: ResponseConstants.productStatus)
  String? status;

  TopShopProductResponse({
    this.id,
    this.variantId,
    this.variantColor,
    this.variantSize,
    this.name,
    this.shopName,
    this.shopId,
    this.price,
    this.priceBeforeDiscount,
    this.imageUrl,
    this.isBestSelling,
    this.rating,
    this.ratersCount,
    this.isAvailable,
    this.categoryId,
    this.categoryName,
    this.status,
  });

  factory TopShopProductResponse.fromJson(Map<String, dynamic> json) =>
      _$TopShopProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TopShopProductResponseToJson(this);
}
