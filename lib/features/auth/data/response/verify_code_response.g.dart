// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_code_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyCodeResponse _$VerifyCodeResponseFromJson(Map<String, dynamic> json) =>
    VerifyCodeResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$VerifyCodeResponseToJson(VerifyCodeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
