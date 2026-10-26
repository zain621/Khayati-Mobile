// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordDataResponse _$ForgotPasswordDataResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordDataResponse(
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$ForgotPasswordDataResponseToJson(
        ForgotPasswordDataResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ForgotPasswordDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
