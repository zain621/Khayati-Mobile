// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
      'phoneNumber': instance.phoneNumber,
      'role': instance.role,
    };
