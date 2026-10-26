// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_my_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateMyOfferResponse _$UpdateMyOfferResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateMyOfferResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : MyOfferItemResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateMyOfferResponseToJson(
        UpdateMyOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
