import 'package:json_annotation/json_annotation.dart';
import '../../../../../../constants/response_constants/response_constants.dart';

part 'get_products_response.g.dart';

// ─── Product Image ─────────────────────────────────────────────────────────

@JsonSerializable()
class ProductImageResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;
  @JsonKey(name: ResponseConstants.imageUrl)
  String? imageUrl;
  @JsonKey(name: ResponseConstants.sortOrder)
  int? sortOrder;

  ProductImageResponse({this.id, this.imageUrl, this.sortOrder});

  factory ProductImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductImageResponseToJson(this);
}

// ─── Single-product details wrapper ──────────────────────────────────────

@JsonSerializable()
class GetProductDetailsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.data)
  ProductItemResponse? data;
  @JsonKey(name: ResponseConstants.message)
  String? message;

  GetProductDetailsResponse({this.status, this.code, this.data, this.message});

  factory GetProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductDetailsResponseToJson(this);
}

// ─── Products List ─────────────────────────────────────────────────────────

@JsonSerializable()
class GetProductsResponse {
  @JsonKey(name: ResponseConstants.status)
  String? status;
  @JsonKey(name: ResponseConstants.code)
  int? code;
  @JsonKey(name: ResponseConstants.data)
  ProductsDataResponse? data;
  @JsonKey(name: ResponseConstants.message)
  String? message;

  GetProductsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory GetProductsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetProductsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductsResponseToJson(this);
}

@JsonSerializable()
class ProductsDataResponse {
  @JsonKey(name: ResponseConstants.items)
  List<ProductItemResponse>? items;
  @JsonKey(name: ResponseConstants.total)
  int? total;

  ProductsDataResponse({
    this.items,
    this.total,
  });

  factory ProductsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsDataResponseToJson(this);
}

@JsonSerializable()
class ProductItemResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;
  @JsonKey(name: ResponseConstants.shopId)
  String? shopId;
  @JsonKey(name: ResponseConstants.name)
  String? name;
  @JsonKey(name: ResponseConstants.categoryId)
  String? categoryId;
  @JsonKey(name: ResponseConstants.category)
  ProductCategoryResponse? category;
  @JsonKey(name: ResponseConstants.price)
  double? price;
  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  double? priceBeforeDiscount;
  @JsonKey(name: ResponseConstants.careInstructions)
  List<String>? careInstructions;
  @JsonKey(name: ResponseConstants.features)
  List<String>? features;
  @JsonKey(name: ResponseConstants.deliveryTimeMin)
  int? deliveryTimeMin;
  @JsonKey(name: ResponseConstants.deliveryTimeMax)
  int? deliveryTimeMax;
  @JsonKey(name: ResponseConstants.orderStatus)
  String? status;
  @JsonKey(name: ResponseConstants.nameAr)
  String? nameAr;
  @JsonKey(name: ResponseConstants.nameEn)
  String? nameEn;
  @JsonKey(name: ResponseConstants.nameUr)
  String? nameUr;
  @JsonKey(name: ResponseConstants.images)
  List<ProductImageResponse>? images;
  @JsonKey(name: ResponseConstants.variants)
  List<ProductVariantResponse>? variants;
  @JsonKey(name: ResponseConstants.createdAt)
  String? createdAt;
  @JsonKey(name: ResponseConstants.updatedAt)
  String? updatedAt;

  ProductItemResponse({
    this.id,
    this.shopId,
    this.name,
    this.categoryId,
    this.category,
    this.price,
    this.priceBeforeDiscount,
    this.careInstructions,
    this.features,
    this.deliveryTimeMin,
    this.deliveryTimeMax,
    this.status,
    this.nameAr,
    this.nameEn,
    this.nameUr,
    this.images,
    this.variants,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductItemResponseToJson(this);
}

@JsonSerializable()
class ProductCategoryResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;
  @JsonKey(name: ResponseConstants.name)
  String? name;

  ProductCategoryResponse({
    this.id,
    this.name,
  });

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryResponseToJson(this);
}

@JsonSerializable()
class ProductVariantResponse {
  @JsonKey(name: ResponseConstants.entityId)
  String? id;
  @JsonKey(name: ResponseConstants.color)
  String? color;
  @JsonKey(name: ResponseConstants.hexCode)
  String? hexCode;
  @JsonKey(name: ResponseConstants.size)
  String? size;
  @JsonKey(name: ResponseConstants.quantity)
  int? quantity;

  ProductVariantResponse({
    this.id,
    this.color,
    this.hexCode,
    this.size,
    this.quantity,
  });

  factory ProductVariantResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductVariantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductVariantResponseToJson(this);
}
