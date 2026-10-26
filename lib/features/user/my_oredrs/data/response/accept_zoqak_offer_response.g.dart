// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_zoqak_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptZoqakOfferResponse _$AcceptZoqakOfferResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptZoqakOfferResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AcceptZoqakOfferDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptZoqakOfferResponseToJson(
        AcceptZoqakOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AcceptZoqakOfferDataResponse _$AcceptZoqakOfferDataResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptZoqakOfferDataResponse(
      offerId: json['offerId'] as String?,
      orderId: json['orderId'] as String?,
      payment: json['payment'] == null
          ? null
          : CheckoutPaymentResponse.fromJson(
              json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptZoqakOfferDataResponseToJson(
        AcceptZoqakOfferDataResponse instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
      'orderId': instance.orderId,
      'payment': instance.payment,
    };
