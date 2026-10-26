// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressDataResponse _$AddressDataResponseFromJson(Map<String, dynamic> json) =>
    AddressDataResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      detailedDescription: json['detailedDescription'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$AddressDataResponseToJson(
        AddressDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'detailedDescription': instance.detailedDescription,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) =>
    AddressResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AddressDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressResponseToJson(AddressResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
