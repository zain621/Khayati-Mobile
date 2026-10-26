// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_top_shops_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetTopShopsResponse _$GetTopShopsResponseFromJson(Map<String, dynamic> json) =>
    GetTopShopsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : GetTopShopsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetTopShopsResponseToJson(
        GetTopShopsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

GetTopShopsDataResponse _$GetTopShopsDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetTopShopsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => TopShopItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetTopShopsDataResponseToJson(
        GetTopShopsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };

TopShopItemResponse _$TopShopItemResponseFromJson(Map<String, dynamic> json) =>
    TopShopItemResponse(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      rating: json['rating'] as num?,
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      productsCount: (json['productsCount'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      address: _topShopAddressFromJson(json['address']),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) =>
              TopShopCategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => TopShopProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopShopItemResponseToJson(
        TopShopItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'isAvailable': instance.isAvailable,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'completedOrdersCount': instance.completedOrdersCount,
      'productsCount': instance.productsCount,
      'bio': instance.bio,
      'specializations': instance.specializations,
      'address': instance.address,
      'categories': instance.categories,
      'products': instance.products,
    };

TopShopCategoryResponse _$TopShopCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    TopShopCategoryResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      productsCount: (json['productsCount'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => TopShopProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopShopCategoryResponseToJson(
        TopShopCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productsCount': instance.productsCount,
      'products': instance.products,
    };

TopShopProductResponse _$TopShopProductResponseFromJson(
        Map<String, dynamic> json) =>
    TopShopProductResponse(
      id: json['id'] as String?,
      variantId: json['variantId'] as String?,
      variantColor: json['variantColor'] as String?,
      variantSize: json['variantSize'] as String?,
      name: json['name'] as String?,
      shopName: json['shopName'] as String?,
      shopId: json['shopId'] as String?,
      price: json['price'] as num?,
      priceBeforeDiscount: json['priceBeforeDiscount'] as num?,
      imageUrl: json['imageUrl'] as String?,
      isBestSelling: json['isBestSelling'] as bool?,
      rating: json['rating'] as num?,
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      isAvailable: json['isAvailable'] as bool?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$TopShopProductResponseToJson(
        TopShopProductResponse instance) =>
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
