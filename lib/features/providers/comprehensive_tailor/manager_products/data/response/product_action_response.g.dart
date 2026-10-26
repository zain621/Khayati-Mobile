// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_action_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductActionResponse _$ProductActionResponseFromJson(
        Map<String, dynamic> json) =>
    ProductActionResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ProductActionResponseToJson(
        ProductActionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
