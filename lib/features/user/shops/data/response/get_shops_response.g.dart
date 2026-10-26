// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shops_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShopsResponse _$GetShopsResponseFromJson(Map<String, dynamic> json) =>
    GetShopsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : GetShopsDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetShopsResponseToJson(GetShopsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

GetShopsDataResponse _$GetShopsDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetShopsDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ShopItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      ads: (json['ads'] as List<dynamic>?)
          ?.map((e) => AdItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetShopsDataResponseToJson(
        GetShopsDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'ads': instance.ads,
    };

ShopItemResponse _$ShopItemResponseFromJson(Map<String, dynamic> json) =>
    ShopItemResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      imageUrl: json['imageUrl'] as String?,
      userId: json['userId'] as String?,
      productsCount: (json['productsCount'] as num?)?.toInt(),
      rating: json['rating'] as num?,
      ratersCount: (json['ratersCount'] as num?)?.toInt(),
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ShopItemResponseToJson(ShopItemResponse instance) =>
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

AdItemResponse _$AdItemResponseFromJson(Map<String, dynamic> json) =>
    AdItemResponse(
      id: json['id'] as String?,
      imageUrl: json['imageUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
    );

Map<String, dynamic> _$AdItemResponseToJson(AdItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'title': instance.title,
      'subtitle': instance.subtitle,
    };
