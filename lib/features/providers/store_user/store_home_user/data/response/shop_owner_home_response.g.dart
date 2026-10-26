// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_owner_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShopOwnerHomeResponse _$ShopOwnerHomeResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerHomeResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ShopOwnerHomeDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShopOwnerHomeResponseToJson(
        ShopOwnerHomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ShopOwnerHomeDataResponse _$ShopOwnerHomeDataResponseFromJson(
        Map<String, dynamic> json) =>
    ShopOwnerHomeDataResponse(
      shopStatus: json['shopStatus'] as String?,
      isAcceptingOrders: json['isAcceptingOrders'] as bool?,
      withdrawableBalance: (json['withdrawableBalance'] as num?)?.toDouble(),
      lastLoginAt: json['lastLoginAt'] as String?,
      reviews: json['reviews'] as List<dynamic>?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ShopOwnerHomeDataResponseToJson(
        ShopOwnerHomeDataResponse instance) =>
    <String, dynamic>{
      'shopStatus': instance.shopStatus,
      'isAcceptingOrders': instance.isAcceptingOrders,
      'withdrawableBalance': instance.withdrawableBalance,
      'lastLoginAt': instance.lastLoginAt,
      'reviews': instance.reviews,
      'averageRating': instance.averageRating,
      'reviewsCount': instance.reviewsCount,
    };
