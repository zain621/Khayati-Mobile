// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) =>
    SendMessageResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : SendMessageDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$SendMessageResponseToJson(
        SendMessageResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

SendMessageDataResponse _$SendMessageDataResponseFromJson(
        Map<String, dynamic> json) =>
    SendMessageDataResponse(
      id: json['id'] as String?,
      conversationId: json['conversationId'] as String?,
      senderId: json['senderId'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] as String?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) =>
              SendMessageAttachmentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SendMessageDataResponseToJson(
        SendMessageDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'senderId': instance.senderId,
      'content': instance.content,
      'createdAt': instance.createdAt,
      'attachments': instance.attachments,
    };

SendMessageAttachmentData _$SendMessageAttachmentDataFromJson(
        Map<String, dynamic> json) =>
    SendMessageAttachmentData(
      id: json['id'] as String?,
      url: json['url'] as String?,
      kind: json['kind'] as String?,
      mimeType: json['mimeType'] as String?,
      originalName: json['originalName'] as String?,
      sizeBytes: (json['sizeBytes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SendMessageAttachmentDataToJson(
        SendMessageAttachmentData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'kind': instance.kind,
      'mimeType': instance.mimeType,
      'originalName': instance.originalName,
      'sizeBytes': instance.sizeBytes,
    };
