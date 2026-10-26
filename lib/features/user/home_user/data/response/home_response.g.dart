// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : HomeDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

HomeDataResponse _$HomeDataResponseFromJson(Map<String, dynamic> json) =>
    HomeDataResponse(
      latestProducts: (json['latestProducts'] as List<dynamic>?)
          ?.map((e) => HomeProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => HomeShopResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      bestTailors: (json['bestTailors'] as List<dynamic>?)
          ?.map((e) => HomeTailorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      nearbyTailors: (json['nearbyTailors'] as List<dynamic>?)
          ?.map((e) => HomeTailorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableTailorsCount: (json['availableTailorsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HomeDataResponseToJson(HomeDataResponse instance) =>
    <String, dynamic>{
      'latestProducts': instance.latestProducts,
      'shops': instance.shops,
      'bestTailors': instance.bestTailors,
      'nearbyTailors': instance.nearbyTailors,
      'availableTailorsCount': instance.availableTailorsCount,
    };

HomeProductResponse _$HomeProductResponseFromJson(Map<String, dynamic> json) =>
    HomeProductResponse(
      id: json['id'] as String?,
      variantId: json['variantId'] as String?,
      variantColor: json['variantColor'] as String?,
      variantSize: json['variantSize'] as String?,
      name: json['name'] as String?,
      shopName: json['shopName'] as String?,
      shopId: json['shopId'] as String?,
      price: json['price'],
      priceBeforeDiscount: json['priceBeforeDiscount'],
      imageUrl: json['imageUrl'] as String?,
      isBestSelling: json['isBestSelling'] as bool?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      isAvailable: json['isAvailable'] as bool?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$HomeProductResponseToJson(
        HomeProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'variantId': instance.variantId,
      'variantColor': instance.variantColor,
      'variantSize': instance.variantSize,
      'name': instance.name,
      'shopName': instance.shopName,
      'shopId': instance.shopId,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'imageUrl': instance.imageUrl,
      'isBestSelling': instance.isBestSelling,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'isAvailable': instance.isAvailable,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'status': instance.status,
    };

HomeShopResponse _$HomeShopResponseFromJson(Map<String, dynamic> json) =>
    HomeShopResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String?,
      productsCount: (json['productsCount'] as num?)?.toInt(),
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      latitude: json['latitude'],
      longitude: json['longitude'],
    );

Map<String, dynamic> _$HomeShopResponseToJson(HomeShopResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'userId': instance.userId,
      'productsCount': instance.productsCount,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'completedOrdersCount': instance.completedOrdersCount,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

HomeTailorResponse _$HomeTailorResponseFromJson(Map<String, dynamic> json) =>
    HomeTailorResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      role: json['role'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      offersCount: (json['offersCount'] as num?)?.toInt(),
      ordersCount: (json['ordersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      latitude: json['latitude'],
      longitude: json['longitude'],
      distanceKm: json['distanceKm'],
    );

Map<String, dynamic> _$HomeTailorResponseToJson(HomeTailorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'role': instance.role,
      'isAvailable': instance.isAvailable,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'offersCount': instance.offersCount,
      'ordersCount': instance.ordersCount,
      'completedOrdersCount': instance.completedOrdersCount,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'distanceKm': instance.distanceKm,
    };
