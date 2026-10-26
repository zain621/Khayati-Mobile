// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessagesResponse _$MessagesResponseFromJson(Map<String, dynamic> json) =>
    MessagesResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : MessagesDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MessagesResponseToJson(MessagesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

MessagesDataResponse _$MessagesDataResponseFromJson(
        Map<String, dynamic> json) =>
    MessagesDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              MessageItemWrapperResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool?,
      nextCursor: json['nextCursor'] as String?,
    );

Map<String, dynamic> _$MessagesDataResponseToJson(
        MessagesDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'hasMore': instance.hasMore,
      'nextCursor': instance.nextCursor,
    };

MessageItemWrapperResponse _$MessageItemWrapperResponseFromJson(
        Map<String, dynamic> json) =>
    MessageItemWrapperResponse(
      type: json['type'] as String?,
      createdAt: json['createdAt'] as String?,
      message: json['message'] == null
          ? null
          : MessageItemResponse.fromJson(
              json['message'] as Map<String, dynamic>),
      offer: json['offer'] == null
          ? null
          : OfferItemResponse.fromJson(json['offer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageItemWrapperResponseToJson(
        MessageItemWrapperResponse instance) =>
    <String, dynamic>{
      'type': instance.type,
      'createdAt': instance.createdAt,
      'message': instance.message,
      'offer': instance.offer,
    };

OfferItemResponse _$OfferItemResponseFromJson(Map<String, dynamic> json) =>
    OfferItemResponse(
      id: _readOfferId(json, 'id') as String?,
      conversationId: json['conversationId'] as String?,
      tailorId: json['tailorId'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      additions: (json['additions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      offerStatus: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$OfferItemResponseToJson(OfferItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'tailorId': instance.tailorId,
      'title': instance.title,
      'description': instance.description,
      'amount': instance.amount,
      'additions': instance.additions,
      'status': instance.offerStatus,
      'createdAt': instance.createdAt,
    };

MessageItemResponse _$MessageItemResponseFromJson(Map<String, dynamic> json) =>
    MessageItemResponse(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      senderId: json['senderId'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              MessageAttachmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MessageItemResponseToJson(
        MessageItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'attachments': instance.attachments,
    };

MessageAttachmentResponse _$MessageAttachmentResponseFromJson(
        Map<String, dynamic> json) =>
    MessageAttachmentResponse(
      id: json['id'] as String?,
      url: json['url'] as String?,
      kind: json['kind'] as String?,
      mimeType: json['mimeType'] as String?,
      originalName: json['originalName'] as String?,
      sizeBytes: (json['sizeBytes'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$MessageAttachmentResponseToJson(
        MessageAttachmentResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'kind': instance.kind,
      'mimeType': instance.mimeType,
      'originalName': instance.originalName,
      'sizeBytes': instance.sizeBytes,
      'createdAt': instance.createdAt,
    };
