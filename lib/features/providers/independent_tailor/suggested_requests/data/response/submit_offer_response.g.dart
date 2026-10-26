// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submit_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitOfferResponse _$SubmitOfferResponseFromJson(Map<String, dynamic> json) =>
    SubmitOfferResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SubmitOfferResponseToJson(
        SubmitOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
