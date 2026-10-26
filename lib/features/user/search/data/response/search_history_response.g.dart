// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchHistoryListResponse _$SearchHistoryListResponseFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryListResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              SearchHistoryItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchHistoryListResponseToJson(
        SearchHistoryListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

SearchHistoryItemResponse _$SearchHistoryItemResponseFromJson(
        Map<String, dynamic> json) =>
    SearchHistoryItemResponse(
      id: json['id'] as String?,
      query: json['query'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$SearchHistoryItemResponseToJson(
        SearchHistoryItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'query': instance.query,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
