// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : SearchDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

SearchDataResponse _$SearchDataResponseFromJson(Map<String, dynamic> json) =>
    SearchDataResponse(
      query: json['query'] as String?,
      type: json['type'] as String?,
      counts: json['counts'] == null
          ? null
          : SearchCountsResponse.fromJson(
              json['counts'] as Map<String, dynamic>),
      globalCounts: json['globalCounts'] == null
          ? null
          : SearchCountsResponse.fromJson(
              json['globalCounts'] as Map<String, dynamic>),
      results: json['results'] == null
          ? null
          : SearchResultsResponse.fromJson(
              json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SearchDataResponseToJson(SearchDataResponse instance) =>
    <String, dynamic>{
      'query': instance.query,
      'type': instance.type,
      'counts': instance.counts,
      'globalCounts': instance.globalCounts,
      'results': instance.results,
    };

SearchCountsResponse _$SearchCountsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCountsResponse(
      shops: (json['shops'] as num?)?.toInt(),
      products: (json['products'] as num?)?.toInt(),
      tailors: (json['tailors'] as num?)?.toInt(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchCountsResponseToJson(
        SearchCountsResponse instance) =>
    <String, dynamic>{
      'shops': instance.shops,
      'products': instance.products,
      'tailors': instance.tailors,
      'total': instance.total,
    };

SearchResultsResponse _$SearchResultsResponseFromJson(
        Map<String, dynamic> json) =>
    SearchResultsResponse(
      shops: (json['shops'] as List<dynamic>?)
          ?.map((e) => SearchShopResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      products: (json['products'] as List<dynamic>?)
          ?.map(
              (e) => SearchProductResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      tailors: (json['tailors'] as List<dynamic>?)
          ?.map((e) => SearchTailorResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchResultsResponseToJson(
        SearchResultsResponse instance) =>
    <String, dynamic>{
      'shops': instance.shops,
      'products': instance.products,
      'tailors': instance.tailors,
    };

SearchProductResponse _$SearchProductResponseFromJson(
        Map<String, dynamic> json) =>
    SearchProductResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: _nullableStringFromJson(json['imageUrl']),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      category: json['category'] == null
          ? null
          : SearchCategoryResponse.fromJson(
              json['category'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : SearchShopMiniResponse.fromJson(
              json['shop'] as Map<String, dynamic>),
      price: json['price'],
      priceBeforeDiscount: json['priceBeforeDiscount'],
      isBestSelling: json['isBestSelling'] as bool?,
      isAvailable: json['isAvailable'] as bool?,
      deliveryTimeMin: (json['deliveryTimeMin'] as num?)?.toInt(),
      deliveryTimeMax: (json['deliveryTimeMax'] as num?)?.toInt(),
      variants: (json['variants'] as List<dynamic>?)
          ?.map((e) =>
              SearchProductVariantResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchProductResponseToJson(
        SearchProductResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'images': instance.images,
      'category': instance.category,
      'shop': instance.shop,
      'price': instance.price,
      'priceBeforeDiscount': instance.priceBeforeDiscount,
      'isBestSelling': instance.isBestSelling,
      'isAvailable': instance.isAvailable,
      'deliveryTimeMin': instance.deliveryTimeMin,
      'deliveryTimeMax': instance.deliveryTimeMax,
      'variants': instance.variants,
    };

SearchProductVariantResponse _$SearchProductVariantResponseFromJson(
        Map<String, dynamic> json) =>
    SearchProductVariantResponse(
      id: json['id'] as String?,
      color: json['color'] as String?,
      colorHexCode: json['colorHexCode'] as String?,
      size: json['size'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SearchProductVariantResponseToJson(
        SearchProductVariantResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'color': instance.color,
      'colorHexCode': instance.colorHexCode,
      'size': instance.size,
      'quantity': instance.quantity,
    };

SearchCategoryResponse _$SearchCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    SearchCategoryResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SearchCategoryResponseToJson(
        SearchCategoryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SearchShopMiniResponse _$SearchShopMiniResponseFromJson(
        Map<String, dynamic> json) =>
    SearchShopMiniResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$SearchShopMiniResponseToJson(
        SearchShopMiniResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

SearchShopResponse _$SearchShopResponseFromJson(Map<String, dynamic> json) =>
    SearchShopResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: _nullableStringFromJson(json['imageUrl']),
      coverImageUrl: _nullableStringFromJson(json['coverImageUrl']),
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      location: _searchLocationFromJson(json['location']),
    );

Map<String, dynamic> _$SearchShopResponseToJson(SearchShopResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'coverImageUrl': instance.coverImageUrl,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'location': instance.location,
    };

SearchTailorResponse _$SearchTailorResponseFromJson(
        Map<String, dynamic> json) =>
    SearchTailorResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: _nullableStringFromJson(json['imageUrl']),
      rating: json['rating'],
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      rankLabel: json['rankLabel'] as String?,
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SearchTailorResponseToJson(
        SearchTailorResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating,
      'ratersCount': instance.ratersCount,
      'rankLabel': instance.rankLabel,
      'specializations': instance.specializations,
    };
