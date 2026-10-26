// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopDetailsResponse _$ShopDetailsResponseFromJson(Map<String, dynamic> json) =>
    ShopDetailsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ShopDetailsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ShopDetailsResponseToJson(
        ShopDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ShopDetailsDataResponse _$ShopDetailsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ShopDetailsDataResponse(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      name: json['name'] as String?,
      imageUrl: _imageUrlFromJson(json['imageUrl']),
      coverImageUrl: _imageUrlFromJson(json['coverImageUrl']),
      isAvailable: json['isAvailable'] as bool?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      productsCount: (json['productsCount'] as num?)?.toInt(),
      bio: json['bio'] as String?,
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      address: _addressFromJson(json['address']),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => ShopCategoryResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ShopProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ShopDetailsDataResponseToJson(
        ShopDetailsDataResponse instance) =>
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ShopCategoryResponse _$ShopCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ShopCategoryResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      productsCount: (json['productsCount'] as num?)?.toInt(),
      products: (json['products'] as List<dynamic>?)
          ?.map((e) => ShopProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ShopCategoryResponseToJson(
        ShopCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productsCount': instance.productsCount,
      'products': instance.products,
    };

ShopProductResponse _$ShopProductResponseFromJson(Map<String, dynamic> json) =>
    ShopProductResponse(
      id: json['id'] as String?,
      variantId: json['variantId'] as String?,
      variantColor: json['variantColor'] as String?,
      variantSize: json['variantSize'] as String?,
      name: json['name'] as String?,
      shopName: json['shopName'] as String?,
      shopId: json['shopId'] as String?,
      price: json['price'],
      priceBeforeDiscount: json['priceBeforeDiscount'],
      imageUrl: _imageUrlFromJson(json['imageUrl']),
      isBestSelling: json['isBestSelling'] as bool?,
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      isAvailable: json['isAvailable'] as bool?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$ShopProductResponseToJson(
        ShopProductResponse instance) =>
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
