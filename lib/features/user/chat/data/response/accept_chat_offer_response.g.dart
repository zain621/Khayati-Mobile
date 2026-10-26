// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_chat_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptChatOfferResponse _$AcceptChatOfferResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptChatOfferResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : AcceptChatOfferDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptChatOfferResponseToJson(
        AcceptChatOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

AcceptChatOfferDataResponse _$AcceptChatOfferDataResponseFromJson(
        Map<String, dynamic> json) =>
    AcceptChatOfferDataResponse(
      offerId: json['offerId'] as String?,
      conversationId: json['conversationId'] as String?,
      payment: json['payment'] == null
          ? null
          : CheckoutPaymentResponse.fromJson(
              json['payment'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptChatOfferDataResponseToJson(
        AcceptChatOfferDataResponse instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
      'conversationId': instance.conversationId,
      'payment': instance.payment,
    };
