// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllProductsResponse _$AllProductsResponseFromJson(Map<String, dynamic> json) =>
    AllProductsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AllProductsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AllProductsResponseToJson(
        AllProductsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AllProductsDataResponse _$AllProductsDataResponseFromJson(
        Map<String, dynamic> json) =>
    AllProductsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AllProductsDataResponseToJson(
        AllProductsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };

ProductItemResponse _$ProductItemResponseFromJson(Map<String, dynamic> json) =>
    ProductItemResponse(
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

Map<String, dynamic> _$ProductItemResponseToJson(
        ProductItemResponse instance) =>
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
