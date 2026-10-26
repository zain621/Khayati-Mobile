// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

GetProductDetailsResponse _$GetProductDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    GetProductDetailsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ProductItemResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetProductDetailsResponseToJson(
        GetProductDetailsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

GetProductsResponse _$GetProductsResponseFromJson(Map<String, dynamic> json) =>
    GetProductsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : ProductsDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$GetProductsResponseToJson(
        GetProductsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ProductsDataResponse _$ProductsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProductsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductsDataResponseToJson(
        ProductsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };

ProductItemResponse _$ProductItemResponseFromJson(Map<String, dynamic> json) =>
    ProductItemResponse(
      id: json['id'] as String?,
      shopId: json['shopId'] as String?,
      name: json['name'] as String?,
      categoryId: json['categoryId'] as String?,
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
      nameAr: json['nameAr'] as String?,
      nameEn: json['nameEn'] as String?,
      nameUr: json['nameUr'] as String?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => ProductImageResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map(
              (e) => ProductVariantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ProductItemResponseToJson(
        ProductItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'category': instance.category,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'careInstructions': instance.careInstructions,
      'features': instance.features,
      'deliveryTimeMin': instance.deliveryTimeMin,
      'deliveryTimeMax': instance.deliveryTimeMax,
      'status': instance.status,
      'nameAr': instance.nameAr,
      'nameEn': instance.nameEn,
      'nameUr': instance.nameUr,
      'images': instance.images,
      'variants': instance.variants,
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
      hexCode: json['hexCode'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProductVariantResponseToJson(
        ProductVariantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'hexCode': instance.hexCode,
      'size': instance.size,
      'quantity': instance.quantity,
    };
