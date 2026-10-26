// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_order_stage_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateOrderStageResponse _$UpdateOrderStageResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateOrderStageResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateOrderStageResponseToJson(
        UpdateOrderStageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
