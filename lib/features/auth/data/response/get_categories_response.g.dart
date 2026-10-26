// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryItemResponse _$CategoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryItemResponse(
      id: json['id'] as String?,
      name: json['name'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$CategoryItemResponseToJson(
        CategoryItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

GetCategoriesDataResponse _$GetCategoriesDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CategoryItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GetCategoriesDataResponseToJson(
        GetCategoriesDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
      'limit': instance.limit,
      'offset': instance.offset,
    };

GetCategoriesResponse _$GetCategoriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetCategoriesResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : GetCategoriesDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCategoriesResponseToJson(
        GetCategoriesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
