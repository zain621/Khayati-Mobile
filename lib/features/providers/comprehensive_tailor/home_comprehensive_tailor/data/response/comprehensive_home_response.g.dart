// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comprehensive_home_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ComprehensiveHomeResponse _$ComprehensiveHomeResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveHomeResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ComprehensiveHomeDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComprehensiveHomeResponseToJson(
        ComprehensiveHomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ComprehensiveHomeDataResponse _$ComprehensiveHomeDataResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveHomeDataResponse(
      profile: json['profile'] == null
          ? null
          : ComprehensiveHomeProfileResponse.fromJson(
              json['profile'] as Map<String, dynamic>),
      dashboard: json['dashboard'] == null
          ? null
          : ComprehensiveHomeDashboardResponse.fromJson(
              json['dashboard'] as Map<String, dynamic>),
      shop: json['shop'] == null
          ? null
          : ComprehensiveHomeShopResponse.fromJson(
              json['shop'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ComprehensiveHomeDataResponseToJson(
        ComprehensiveHomeDataResponse instance) =>
    <String, dynamic>{
      'profile': instance.profile,
      'dashboard': instance.dashboard,
      'shop': instance.shop,
    };

ComprehensiveHomeProfileResponse _$ComprehensiveHomeProfileResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveHomeProfileResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
      bio: json['bio'] as String?,
      role: json['role'] as String?,
      isAvailable: json['isAvailable'] as bool?,
    );

Map<String, dynamic> _$ComprehensiveHomeProfileResponseToJson(
        ComprehensiveHomeProfileResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'bio': instance.bio,
      'role': instance.role,
      'isAvailable': instance.isAvailable,
    };

ComprehensiveHomeDashboardResponse _$ComprehensiveHomeDashboardResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveHomeDashboardResponse(
      shopStatus: json['shopStatus'] as String?,
      isAcceptingOrders: json['isAcceptingOrders'] as bool?,
      withdrawableBalance: (json['withdrawableBalance'] as num?)?.toDouble(),
      lastLoginAt: json['lastLoginAt'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
      isAvailable: json['isAvailable'] as bool?,
      zoqakOrdersCount: (json['zoqakOrdersCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ComprehensiveHomeDashboardResponseToJson(
        ComprehensiveHomeDashboardResponse instance) =>
    <String, dynamic>{
      'shopStatus': instance.shopStatus,
      'isAcceptingOrders': instance.isAcceptingOrders,
      'withdrawableBalance': instance.withdrawableBalance,
      'lastLoginAt': instance.lastLoginAt,
      'averageRating': instance.averageRating,
      'reviewsCount': instance.reviewsCount,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
      'isAvailable': instance.isAvailable,
      'zoqakOrdersCount': instance.zoqakOrdersCount,
    };

ComprehensiveHomeShopResponse _$ComprehensiveHomeShopResponseFromJson(
        Map<String, dynamic> json) =>
    ComprehensiveHomeShopResponse(
      shopStatus: json['shopStatus'] as String?,
      isAcceptingOrders: json['isAcceptingOrders'] as bool?,
      withdrawableBalance: (json['withdrawableBalance'] as num?)?.toDouble(),
      lastLoginAt: json['lastLoginAt'] as String?,
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      reviewsCount: (json['reviewsCount'] as num?)?.toInt(),
      rank: json['rank'] as String?,
      rankLabel: json['rankLabel'] as String?,
    );

Map<String, dynamic> _$ComprehensiveHomeShopResponseToJson(
        ComprehensiveHomeShopResponse instance) =>
    <String, dynamic>{
      'shopStatus': instance.shopStatus,
      'isAcceptingOrders': instance.isAcceptingOrders,
      'withdrawableBalance': instance.withdrawableBalance,
      'lastLoginAt': instance.lastLoginAt,
      'averageRating': instance.averageRating,
      'reviewsCount': instance.reviewsCount,
      'rank': instance.rank,
      'rankLabel': instance.rankLabel,
    };

ChangeAvailabilityResponse _$ChangeAvailabilityResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeAvailabilityResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ChangeAvailabilityDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChangeAvailabilityResponseToJson(
        ChangeAvailabilityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ChangeAvailabilityDataResponse _$ChangeAvailabilityDataResponseFromJson(
        Map<String, dynamic> json) =>
    ChangeAvailabilityDataResponse(
      isAcceptingOrders: json['isAcceptingOrders'] as bool?,
    );

Map<String, dynamic> _$ChangeAvailabilityDataResponseToJson(
        ChangeAvailabilityDataResponse instance) =>
    <String, dynamic>{
      'isAcceptingOrders': instance.isAcceptingOrders,
    };
