// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_offer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatOfferResponse _$ChatOfferResponseFromJson(Map<String, dynamic> json) =>
    ChatOfferResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : ChatOfferDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatOfferResponseToJson(ChatOfferResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ChatOfferDataResponse _$ChatOfferDataResponseFromJson(
        Map<String, dynamic> json) =>
    ChatOfferDataResponse(
      id: _readChatOfferId(json, 'id') as String?,
      conversationId: json['conversationId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      additions: (json['additions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      offerStatus: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ChatOfferDataResponseToJson(
        ChatOfferDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'additions': instance.additions,
      'status': instance.offerStatus,
      'createdAt': instance.createdAt,
    };
