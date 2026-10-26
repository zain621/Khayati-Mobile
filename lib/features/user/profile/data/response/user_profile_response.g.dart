// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDataResponse _$UserProfileDataResponseFromJson(
        Map<String, dynamic> json) =>
    UserProfileDataResponse(
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
      completedOrdersCount: (json['completedOrdersCount'] as num?)?.toInt(),
      inProgressOrdersCount: (json['inProgressOrdersCount'] as num?)?.toInt(),
      loyaltyPoints: (json['loyaltyPoints'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserProfileDataResponseToJson(
        UserProfileDataResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
      'completedOrdersCount': instance.completedOrdersCount,
      'inProgressOrdersCount': instance.inProgressOrdersCount,
      'loyaltyPoints': instance.loyaltyPoints,
    };

UserProfileResponse _$UserProfileResponseFromJson(Map<String, dynamic> json) =>
    UserProfileResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserProfileDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileResponseToJson(
        UserProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
