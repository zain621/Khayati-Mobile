import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'home_response.g.dart';

@JsonSerializable()
class HomeResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final HomeDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const HomeResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class HomeDataResponse {
  @JsonKey(name: ResponseConstants.latestProducts)
  final List<HomeProductResponse>? latestProducts;

  @JsonKey(name: ResponseConstants.shops)
  final List<HomeShopResponse>? shops;

  @JsonKey(name: ResponseConstants.bestTailors)
  final List<HomeTailorResponse>? bestTailors;

  @JsonKey(name: ResponseConstants.nearbyTailors)
  final List<HomeTailorResponse>? nearbyTailors;

  @JsonKey(name: ResponseConstants.availableTailorsCount)
  final int? availableTailorsCount;

  const HomeDataResponse({
    this.latestProducts,
    this.shops,
    this.bestTailors,
    this.nearbyTailors,
    this.availableTailorsCount,
  });

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataResponseToJson(this);
}

@JsonSerializable()
class HomeProductResponse {
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

  @JsonKey(name: ResponseConstants.imageUrl)
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

  @JsonKey(name: ResponseConstants.orderStatus)
  final String? status;

  const HomeProductResponse({
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

  factory HomeProductResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeProductResponseToJson(this);
}

@JsonSerializable()
class HomeShopResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.name)
  final String? name;

  @JsonKey(name: ResponseConstants.imageUrl)
  final String? imageUrl;

  @JsonKey(name: ResponseConstants.userId)
  final String? userId;

  @JsonKey(name: ResponseConstants.productsCount)
  final int? productsCount;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  final int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.latitude)
  final dynamic latitude;

  @JsonKey(name: ResponseConstants.longitude)
  final dynamic longitude;

  const HomeShopResponse({
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

  factory HomeShopResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeShopResponseToJson(this);
}

@JsonSerializable()
class HomeTailorResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  /// API returns "fullName" for the tailor's display name.
  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  /// API returns "image" (not "imageUrl") for the tailor's photo.
  @JsonKey(name: ResponseConstants.image)
  final String? image;

  @JsonKey(name: ResponseConstants.rank)
  final String? rank;

  @JsonKey(name: ResponseConstants.rankLabel)
  final String? rankLabel;

  @JsonKey(name: ResponseConstants.role)
  final String? role;

  @JsonKey(name: ResponseConstants.isAvailable)
  final bool? isAvailable;

  @JsonKey(name: ResponseConstants.rating)
  final dynamic rating;

  @JsonKey(name: ResponseConstants.ratersCount)
  final int? ratersCount;

  @JsonKey(name: ResponseConstants.offersCount)
  final int? offersCount;

  @JsonKey(name: ResponseConstants.ordersCount)
  final int? ordersCount;

  @JsonKey(name: ResponseConstants.completedOrdersCount)
  final int? completedOrdersCount;

  @JsonKey(name: ResponseConstants.latitude)
  final dynamic latitude;

  @JsonKey(name: ResponseConstants.longitude)
  final dynamic longitude;

  @JsonKey(name: ResponseConstants.distanceKm)
  final dynamic distanceKm;

  const HomeTailorResponse({
    this.id,
    this.fullName,
    this.image,
    this.rank,
    this.rankLabel,
    this.role,
    this.isAvailable,
    this.rating,
    this.ratersCount,
    this.offersCount,
    this.ordersCount,
    this.completedOrdersCount,
    this.latitude,
    this.longitude,
    this.distanceKm,
  });

  factory HomeTailorResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeTailorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeTailorResponseToJson(this);
}
