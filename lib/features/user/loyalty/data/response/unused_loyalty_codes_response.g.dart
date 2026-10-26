// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unused_loyalty_codes_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnusedLoyaltyCodesResponse _$UnusedLoyaltyCodesResponseFromJson(
        Map<String, dynamic> json) =>
    UnusedLoyaltyCodesResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => UnusedCodeItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UnusedLoyaltyCodesResponseToJson(
        UnusedLoyaltyCodesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

UnusedCodeItemResponse _$UnusedCodeItemResponseFromJson(
        Map<String, dynamic> json) =>
    UnusedCodeItemResponse(
      id: json['id'] as String?,
      code: json['code'] as String?,
      rewardId: json['rewardId'] as String?,
      rewardTitleAr: json['rewardTitleAr'] as String?,
      rewardTitleEn: json['rewardTitleEn'] as String?,
      rewardTitleUr: json['rewardTitleUr'] as String?,
      discountType: json['discountType'] as String?,
      discountValue: (json['discountValue'] as num?)?.toDouble(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$UnusedCodeItemResponseToJson(
        UnusedCodeItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'rewardId': instance.rewardId,
      'rewardTitleAr': instance.rewardTitleAr,
      'rewardTitleEn': instance.rewardTitleEn,
      'rewardTitleUr': instance.rewardTitleUr,
      'discountType': instance.discountType,
      'discountValue': instance.discountValue,
      'createdAt': instance.createdAt,
    };
