// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationsResponse _$ConversationsResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationsResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ConversationDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$ConversationsResponseToJson(
        ConversationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

ConversationDataResponse _$ConversationDataResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationDataResponse(
      id: json['id'] as String?,
      userInfo: json['userInfo'] == null
          ? null
          : ConversationUserInfoResponse.fromJson(
              json['userInfo'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessageResponse.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
      latestOffer: json['latestOffer'] as Map<String, dynamic>?,
      unreadCount: (json['unreadCount'] as num?)?.toInt(),
      hasUnread: json['hasUnread'] as bool?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ConversationDataResponseToJson(
        ConversationDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userInfo': instance.userInfo,
      'lastMessage': instance.lastMessage,
      'latestOffer': instance.latestOffer,
      'unreadCount': instance.unreadCount,
      'hasUnread': instance.hasUnread,
      'updatedAt': instance.updatedAt,
    };

ConversationUserInfoResponse _$ConversationUserInfoResponseFromJson(
        Map<String, dynamic> json) =>
    ConversationUserInfoResponse(
      id: json['id'] as String?,
      fullName: json['fullName'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$ConversationUserInfoResponseToJson(
        ConversationUserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'image': instance.image,
    };

LastMessageResponse _$LastMessageResponseFromJson(Map<String, dynamic> json) =>
    LastMessageResponse(
      id: json['id'] as String?,
      content: json['content'] as String?,
      senderId: json['senderId'] as String?,
      createdAt: json['createdAt'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              LastMessageAttachmentResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LastMessageResponseToJson(
        LastMessageResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'senderId': instance.senderId,
      'createdAt': instance.createdAt,
      'attachments': instance.attachments,
    };

LastMessageAttachmentResponse _$LastMessageAttachmentResponseFromJson(
        Map<String, dynamic> json) =>
    LastMessageAttachmentResponse(
      kind: json['kind'] as String?,
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$LastMessageAttachmentResponseToJson(
        LastMessageAttachmentResponse instance) =>
    <String, dynamic>{
      'kind': instance.kind,
      'mimeType': instance.mimeType,
    };
