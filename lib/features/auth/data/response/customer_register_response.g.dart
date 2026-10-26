// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_register_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerRegisterDataResponse _$CustomerRegisterDataResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerRegisterDataResponse(
      code: json['code'] as String?,
    );

Map<String, dynamic> _$CustomerRegisterDataResponseToJson(
        CustomerRegisterDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
    };

CustomerRegisterResponse _$CustomerRegisterResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerRegisterResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : CustomerRegisterDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CustomerRegisterResponseToJson(
        CustomerRegisterResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
