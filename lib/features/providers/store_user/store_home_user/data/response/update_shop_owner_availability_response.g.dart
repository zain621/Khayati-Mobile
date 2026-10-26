// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_shop_owner_availability_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateShopOwnerAvailabilityResponse
    _$UpdateShopOwnerAvailabilityResponseFromJson(Map<String, dynamic> json) =>
        UpdateShopOwnerAvailabilityResponse(
          status: json['status'] as String?,
          code: (json['code'] as num?)?.toInt(),
          message: json['message'] as String?,
          data: json['data'] == null
              ? null
              : UpdateShopOwnerAvailabilityDataResponse.fromJson(
                  json['data'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$UpdateShopOwnerAvailabilityResponseToJson(
        UpdateShopOwnerAvailabilityResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

UpdateShopOwnerAvailabilityDataResponse
    _$UpdateShopOwnerAvailabilityDataResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateShopOwnerAvailabilityDataResponse(
          isOpen: json['isOpen'] as bool?,
        );

Map<String, dynamic> _$UpdateShopOwnerAvailabilityDataResponseToJson(
        UpdateShopOwnerAvailabilityDataResponse instance) =>
    <String, dynamic>{
      'isOpen': instance.isOpen,
    };
