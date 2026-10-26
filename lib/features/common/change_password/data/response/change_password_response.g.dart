// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangePasswordResponse _$ChangePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ChangePasswordResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ChangePasswordResponseToJson(
        ChangePasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
