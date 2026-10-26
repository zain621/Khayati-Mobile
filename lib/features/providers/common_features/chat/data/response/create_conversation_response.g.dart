// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_conversation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateConversationResponse _$CreateConversationResponseFromJson(
        Map<String, dynamic> json) =>
    CreateConversationResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      data: json['data'] == null
          ? null
          : CreateConversationDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$CreateConversationResponseToJson(
        CreateConversationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'data': instance.data,
      'message': instance.message,
    };

CreateConversationDataResponse _$CreateConversationDataResponseFromJson(
        Map<String, dynamic> json) =>
    CreateConversationDataResponse(
      id: json['id'] as String?,
      tailorId: json['tailorId'] as String?,
      userId: json['userId'] as String?,
      tailor: json['tailor'] == null
          ? null
          : ConversationUserInfoResponse.fromJson(
              json['tailor'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : ConversationUserInfoResponse.fromJson(
              json['user'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$CreateConversationDataResponseToJson(
        CreateConversationDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tailorId': instance.tailorId,
      'userId': instance.userId,
      'tailor': instance.tailor,
      'user': instance.user,
      'createdAt': instance.createdAt,
    };
