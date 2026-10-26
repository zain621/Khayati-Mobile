// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'redeem_loyalty_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RedeemLoyaltyDataResponse _$RedeemLoyaltyDataResponseFromJson(
        Map<String, dynamic> json) =>
    RedeemLoyaltyDataResponse(
      code: json['code'] as String?,
    );

Map<String, dynamic> _$RedeemLoyaltyDataResponseToJson(
        RedeemLoyaltyDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

RedeemLoyaltyResponse _$RedeemLoyaltyResponseFromJson(
        Map<String, dynamic> json) =>
    RedeemLoyaltyResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : RedeemLoyaltyDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RedeemLoyaltyResponseToJson(
        RedeemLoyaltyResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
