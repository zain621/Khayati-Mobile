// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserProfileDataResponse _$UpdateUserProfileDataResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserProfileDataResponse(
      fullName: json['fullName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UpdateUserProfileDataResponseToJson(
        UpdateUserProfileDataResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'image': instance.image,
    };

UpdateUserProfileResponse _$UpdateUserProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateUserProfileResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UpdateUserProfileDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateUserProfileResponseToJson(
        UpdateUserProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
