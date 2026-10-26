// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_points_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyPointsResponse _$LoyaltyPointsResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyPointsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : LoyaltyPointsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoyaltyPointsResponseToJson(
        LoyaltyPointsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

LoyaltyPointsDataResponse _$LoyaltyPointsDataResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyPointsDataResponse(
      points: (json['points'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoyaltyPointsDataResponseToJson(
        LoyaltyPointsDataResponse instance) =>
    <String, dynamic>{
      'points': instance.points,
    };
