// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponse _$ProductDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ProductDetailsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProductDetailsResponseToJson(
        ProductDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ProductDetailsDataResponse _$ProductDetailsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsDataResponse(
      id: json['id'] as String?,
      shopId: json['shopId'] as String?,
      shopName: json['shopName'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] == null
          ? null
          : ProductCategoryResponse.fromJson(
              json['category'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      priceBeforeDiscount: (json['priceBeforeDiscount'] as num?)?.toDouble(),
      careInstructions: (json['careInstructions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      deliveryTimeMin: (json['deliveryTimeMin'] as num?)?.toInt(),
      deliveryTimeMax: (json['deliveryTimeMax'] as num?)?.toInt(),
      status: json['status'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map(
              (e) => ProductVariantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      rating: (json['rating'] as num?)?.toDouble(),
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      isBestSelling: json['isBestSelling'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductDetailsDataResponseToJson(
        ProductDetailsDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'careInstructions': instance.careInstructions,
      'features': instance.features,
      'deliveryTimeMin': instance.deliveryTimeMin,
      'deliveryTimeMax': instance.deliveryTimeMax,
      'status': instance.status,
      'isAvailable': instance.isAvailable,
      'images': instance.images,
      'variants': instance.variants,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'isBestSelling': instance.isBestSelling,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

ProductCategoryResponse _$ProductCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductCategoryResponseToJson(
        ProductCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductVariantResponse _$ProductVariantResponseFromJson(
        Map<String, dynamic> json) =>
    ProductVariantResponse(
      id: json['id'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductVariantResponseToJson(
        ProductVariantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'size': instance.size,
      'quantity': instance.quantity,
    };

ProductImageResponse _$ProductImageResponseFromJson(
        Map<String, dynamic> json) =>
    ProductImageResponse(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      sortOrder: (json['sortOrder'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductImageResponseToJson(
        ProductImageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'sortOrder': instance.sortOrder,
    };
