import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'shop_details_response.g.dart';

@JsonSerializable()
class ShopDetailsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final ShopDetailsDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const ShopDetailsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory ShopDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDetailsResponseToJson(this);
}

@JsonSerializable()
class ShopDetailsDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.userId)
  final String? userId;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(
    name: ResponseConstants.imageUrl,
    fromJson: _imageUrlFromJson,
  )
  final String? imageUrl;

  @JsonKey(
    name: ResponseConstants.coverImageUrl,
    fromJson: _imageUrlFromJson,
  )
  final String? coverImageUrl;

  @JsonKey(name: ResponseConstants.isOpen)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  final int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.productsCount)
  final int? productsCount;

  @JsonKey(name: ResponseConstants.bio)
  final String? bio;

  @JsonKey(name: ResponseConstants.specializations)
  final List<String>? specializations;

  @JsonKey(
    name: ResponseConstants.address,
    fromJson: _addressFromJson,
  )
  final String? address;

  @JsonKey(name: ResponseConstants.categories)
  final List<ShopCategoryResponse>? categories;

  @JsonKey(name: ResponseConstants.products)
  final List<ShopProductResponse>? products;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  const ShopDetailsDataResponse({
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
    this.createdAt,
    this.updatedAt,
  });

  factory ShopDetailsDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopDetailsDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopDetailsDataResponseToJson(this);
}

@JsonSerializable()
class ShopCategoryResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.productsCount)
  final int? productsCount;

  @JsonKey(name: ResponseConstants.products)
  final List<ShopProductResponse>? products;

  const ShopCategoryResponse({
    this.id,
    this.name,
    this.productsCount,
    this.products,
  });

  factory ShopCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopCategoryResponseToJson(this);
}

@JsonSerializable()
class ShopProductResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.variantId)
  final String? variantId;

  @JsonKey(name: ResponseConstants.variantColor)
  final String? variantColor;

  @JsonKey(name: ResponseConstants.variantSize)
  final String? variantSize;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.shopName)
  final String? shopName;

  @JsonKey(name: ResponseConstants.shopId)
  final String? shopId;

  @JsonKey(name: ResponseConstants.price)
  final dynamic price;

  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  final dynamic priceBeforeDiscount;

  @JsonKey(
    name: ResponseConstants.imageUrl,
    fromJson: _imageUrlFromJson,
  )
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.isBestSelling)
  final bool? isBestSelling;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.categoryId)
  final String? categoryId;

  @JsonKey(name: ResponseConstants.categoryName)
  final String? categoryName;

  @JsonKey(name: ResponseConstants.shopStatus)
  final String? status;

  const ShopProductResponse({
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

  factory ShopProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ShopProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ShopProductResponseToJson(this);
}

String? _normalizedTextFromJson(dynamic value) {
  if (value == null) return null;

  var text = value.toString().trim();
  if (text.isEmpty || text.toLowerCase() == 'null') return null;

  final hasDoubleQuotes = text.startsWith('"') && text.endsWith('"');
  final hasSingleQuotes = text.startsWith("'") && text.endsWith("'");
  if (hasDoubleQuotes || hasSingleQuotes) {
    text = text.substring(1, text.length - 1).trim();
  }

  if (text.endsWith(',')) {
    text = text.substring(0, text.length - 1).trim();
  }

  if (text.isEmpty || text.toLowerCase() == 'null') return null;
  return text;
}

String? _imageUrlFromJson(dynamic value) {
  final url = _normalizedTextFromJson(value);
  if (url == null) return null;

  final uri = Uri.tryParse(url);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
    return null;
  }

  return url;
}

String? _addressFromJson(dynamic value) {
  if (value == null) return null;

  if (value is String) {
    return _normalizedTextFromJson(value);
  }

  if (value is Map) {
    final fullName = _normalizedTextFromJson(value['fullName']);
    final detailed = _normalizedTextFromJson(value['detailedDescription']);
    final latitude = _normalizedTextFromJson(value['latitude']);
    final longitude = _normalizedTextFromJson(value['longitude']);

    if (fullName != null) return fullName;
    if (detailed != null) return detailed;
    if (latitude != null && longitude != null) return '$latitude, $longitude';
    return latitude ?? longitude;
  }

  return null;
}
