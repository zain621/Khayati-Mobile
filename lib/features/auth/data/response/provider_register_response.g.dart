// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderRegisterDataResponse _$ProviderRegisterDataResponseFromJson(
        Map<String, dynamic> json) =>
    ProviderRegisterDataResponse(
      requestId: json['requestId'] as String?,
    );

Map<String, dynamic> _$ProviderRegisterDataResponseToJson(
        ProviderRegisterDataResponse instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
    };

ProviderRegisterResponse _$ProviderRegisterResponseFromJson(
        Map<String, dynamic> json) =>
    ProviderRegisterResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ProviderRegisterDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProviderRegisterResponseToJson(
        ProviderRegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
