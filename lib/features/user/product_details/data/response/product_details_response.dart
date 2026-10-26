import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'product_details_response.g.dart';

@JsonSerializable()
class ProductDetailsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final ProductDetailsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const ProductDetailsResponse(
      {this.status, this.code, this.data, this.message});

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseToJson(this);
}

@JsonSerializable()
class ProductDetailsDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.shopId)
  final String? shopId;

  @JsonKey(name: ResponseConstants.shopName)
  final String? shopName;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.description)
  final String? description;

  @JsonKey(name: ResponseConstants.category)
  final ProductCategoryResponse? category;

  @JsonKey(name: ResponseConstants.price)
  final double? price;

  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  final double? priceBeforeDiscount;

  @JsonKey(name: ResponseConstants.careInstructions)
  final List<String>? careInstructions;

  @JsonKey(name: ResponseConstants.features)
  final List<String>? features;

  @JsonKey(name: ResponseConstants.deliveryTimeMin)
  final int? deliveryTimeMin;

  @JsonKey(name: ResponseConstants.deliveryTimeMax)
  final int? deliveryTimeMax;

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.images)
  final List<ProductImageResponse>? images;

  @JsonKey(name: ResponseConstants.variants)
  final List<ProductVariantResponse>? variants;

  @JsonKey(name: ResponseConstants.rating)
  final double? rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.isBestSelling)
  final bool? isBestSelling;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const ProductDetailsDataResponse({
    this.id,
    this.shopId,
    this.shopName,
    this.name,
    this.description,
    this.category,
    this.price,
    this.priceBeforeDiscount,
    this.careInstructions,
    this.features,
    this.deliveryTimeMin,
    this.deliveryTimeMax,
    this.status,
    this.isAvailable,
    this.images,
    this.variants,
    this.rating,
    this.ratersCount,
    this.isBestSelling,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductDetailsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsDataResponseToJson(this);
}

@JsonSerializable()
class ProductCategoryResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  const ProductCategoryResponse({this.id, this.name});

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryResponseToJson(this);
}

@JsonSerializable()
class ProductVariantResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.color)
  final String? color;

  @JsonKey(name: ResponseConstants.size)
  final String? size;

  @JsonKey(name: ResponseConstants.quantity)
  final int? quantity;

  const ProductVariantResponse({this.id, this.color, this.size, this.quantity});

  factory ProductVariantResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantResponseToJson(this);
}

@JsonSerializable()
class ProductImageResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.sortOrder)
  final int? sortOrder;

  const ProductImageResponse({this.id, this.imageUrl, this.sortOrder});

  factory ProductImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageResponseToJson(this);
}
