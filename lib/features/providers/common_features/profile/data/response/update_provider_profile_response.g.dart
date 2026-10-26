// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_provider_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProviderProfileResponse _$UpdateProviderProfileResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProviderProfileResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$UpdateProviderProfileResponseToJson(
        UpdateProviderProfileResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
