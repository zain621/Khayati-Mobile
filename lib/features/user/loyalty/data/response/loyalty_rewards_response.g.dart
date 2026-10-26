// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loyalty_rewards_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoyaltyRewardsResponse _$LoyaltyRewardsResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyRewardsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              LoyaltyRewardItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$LoyaltyRewardsResponseToJson(
        LoyaltyRewardsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

LoyaltyRewardItemResponse _$LoyaltyRewardItemResponseFromJson(
        Map<String, dynamic> json) =>
    LoyaltyRewardItemResponse(
      id: json['id'] as String?,
      titleAr: json['titleAr'] as String?,
      titleEn: json['titleEn'] as String?,
      titleUr: json['titleUr'] as String?,
      pointsRequired: (json['pointsRequired'] as num?)?.toInt(),
      discountType: json['discountType'] as String?,
      discountValue: (json['discountValue'] as num?)?.toDouble(),
      isActive: json['isAvailable'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$LoyaltyRewardItemResponseToJson(
        LoyaltyRewardItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'titleAr': instance.titleAr,
      'titleEn': instance.titleEn,
      'titleUr': instance.titleUr,
      'pointsRequired': instance.pointsRequired,
      'discountType': instance.discountType,
      'discountValue': instance.discountValue,
      'isAvailable': instance.isActive,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
