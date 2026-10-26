import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'all_products_response.g.dart';

@JsonSerializable()
class AllProductsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;

  @JsonKey(name: ResponseConstants.code)
  int? code;

  @JsonKey(name: ResponseConstants.message)
  String? message;

  @JsonKey(name: ResponseConstants.data)
  AllProductsDataResponse? data;

  AllProductsResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory AllProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$AllProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductsResponseToJson(this);
}

@JsonSerializable()
class AllProductsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<ProductItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  int? total;

  AllProductsDataResponse({
    this.items,
    this.total,
  });

  factory AllProductsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$AllProductsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AllProductsDataResponseToJson(this);
}

@JsonSerializable()
class ProductItemResponse {
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

  ProductItemResponse({
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

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemResponseToJson(this);
}
