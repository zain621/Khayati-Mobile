// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordResponse _$ResetPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ResetPasswordResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ResetPasswordResponseToJson(
        ResetPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
