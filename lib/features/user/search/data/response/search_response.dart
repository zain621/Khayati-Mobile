import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final SearchDataResponse? data;

  const SearchResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class SearchDataResponse {
  @JsonKey(name: ResponseConstants.searchQuery)
  final String? query;

  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: ResponseConstants.counts)
  final SearchCountsResponse? counts;

  @JsonKey(name: ResponseConstants.globalCounts)
  final SearchCountsResponse? globalCounts;

  @JsonKey(name: ResponseConstants.results)
  final SearchResultsResponse? results;

  const SearchDataResponse({
    this.query,
    this.type,
    this.counts,
    this.globalCounts,
    this.results,
  });

  factory SearchDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchDataResponseToJson(this);
}

@JsonSerializable()
class SearchCountsResponse {
  @JsonKey(name: ResponseConstants.shops)
  final int? shops;

  @JsonKey(name: ResponseConstants.products)
  final int? products;

  @JsonKey(name: ResponseConstants.tailors)
  final int? tailors;

  @JsonKey(name: ResponseConstants.total)
  final int? total;

  const SearchCountsResponse({
    this.shops,
    this.products,
    this.tailors,
    this.total,
  });

  factory SearchCountsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCountsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCountsResponseToJson(this);
}

@JsonSerializable()
class SearchResultsResponse {
  @JsonKey(name: ResponseConstants.shops)
  final List<SearchShopResponse>? shops;

  @JsonKey(name: ResponseConstants.products)
  final List<SearchProductResponse>? products;

  @JsonKey(name: ResponseConstants.tailors)
  final List<SearchTailorResponse>? tailors;

  const SearchResultsResponse({
    this.shops,
    this.products,
    this.tailors,
  });

  factory SearchResultsResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResultsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResultsResponseToJson(this);
}

@JsonSerializable()
class SearchProductResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(
    name: ResponseConstants.imageUrl,
    fromJson: _nullableStringFromJson,
  )
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.images)
  final List<String>? images;

  @JsonKey(name: ResponseConstants.category)
  final SearchCategoryResponse? category;

  @JsonKey(name: ResponseConstants.shop)
  final SearchShopMiniResponse? shop;

  @JsonKey(name: ResponseConstants.price)
  final dynamic price;

  @JsonKey(name: ResponseConstants.priceBeforeDiscount)
  final dynamic priceBeforeDiscount;

  @JsonKey(name: ResponseConstants.isBestSelling)
  final bool? isBestSelling;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.deliveryTimeMin)
  final int? deliveryTimeMin;

  @JsonKey(name: ResponseConstants.deliveryTimeMax)
  final int? deliveryTimeMax;

  @JsonKey(name: ResponseConstants.variants)
  final List<SearchProductVariantResponse>? variants;

  const SearchProductResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.images,
    this.category,
    this.shop,
    this.price,
    this.priceBeforeDiscount,
    this.isBestSelling,
    this.isAvailable,
    this.deliveryTimeMin,
    this.deliveryTimeMax,
    this.variants,
  });

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductResponseToJson(this);
}

@JsonSerializable()
class SearchProductVariantResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.color)
  final String? color;

  @JsonKey(name: ResponseConstants.colorHexCode)
  final String? colorHexCode;

  @JsonKey(name: ResponseConstants.size)
  final String? size;

  @JsonKey(name: ResponseConstants.quantity)
  final int? quantity;

  const SearchProductVariantResponse({
    this.id,
    this.color,
    this.colorHexCode,
    this.size,
    this.quantity,
  });

  factory SearchProductVariantResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchProductVariantResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchProductVariantResponseToJson(this);
}

@JsonSerializable()
class SearchCategoryResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  const SearchCategoryResponse({this.id, this.name});

  factory SearchCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchCategoryResponseToJson(this);
}

@JsonSerializable()
class SearchShopMiniResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  const SearchShopMiniResponse({this.id, this.name});

  factory SearchShopMiniResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchShopMiniResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchShopMiniResponseToJson(this);
}

@JsonSerializable()
class SearchShopResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(
    name: ResponseConstants.imageUrl,
    fromJson: _nullableStringFromJson,
  )
  final String? imageUrl;

  @JsonKey(
    name: ResponseConstants.coverImageUrl,
    fromJson: _nullableStringFromJson,
  )
  final String? coverImageUrl;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(
    name: ResponseConstants.location,
    fromJson: _searchLocationFromJson,
  )
  final String? location;

  const SearchShopResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.coverImageUrl,
    this.rating,
    this.ratersCount,
    this.location,
  });

  factory SearchShopResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchShopResponseToJson(this);
}

@JsonSerializable()
class SearchTailorResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(
    name: ResponseConstants.imageUrl,
    fromJson: _nullableStringFromJson,
  )
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  @JsonKey(name: ResponseConstants.specializations)
  final List<String>? specializations;

  const SearchTailorResponse({
    this.id,
    this.name,
    this.imageUrl,
    this.rating,
    this.ratersCount,
    this.rankLabel,
    this.specializations,
  });

  factory SearchTailorResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchTailorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchTailorResponseToJson(this);
}

String? _nullableStringFromJson(dynamic value) {
  if (value == null) return null;

  final normalized = value.toString().trim();
  if (normalized.isEmpty || normalized.toLowerCase() == 'null') {
    return null;
  }

  return normalized;
}

String? _searchLocationFromJson(dynamic value) {
  if (value == null) return null;

  if (value is String) {
    return _nullableStringFromJson(value);
  }

  if (value is Map) {
    final latitude = value['latitude'];
    final longitude = value['longitude'];

    final lat = _nullableStringFromJson(latitude);
    final lng = _nullableStringFromJson(longitude);

    if (lat == null && lng == null) return null;
    if (lat != null && lng != null) return '$lat, $lng';
    return lat ?? lng;
  }

  return null;
}
