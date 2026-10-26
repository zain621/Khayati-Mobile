// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_us_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactUsResponse _$ContactUsResponseFromJson(Map<String, dynamic> json) =>
    ContactUsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ContactUsDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ContactUsResponseToJson(ContactUsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ContactUsDataResponse _$ContactUsDataResponseFromJson(
        Map<String, dynamic> json) =>
    ContactUsDataResponse(
      id: json['id'] as String?,
    );

Map<String, dynamic> _$ContactUsDataResponseToJson(
        ContactUsDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
