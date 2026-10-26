// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationListResponse _$NotificationListResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationListResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : NotificationDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationListResponseToJson(
        NotificationListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

NotificationDataResponse _$NotificationDataResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationDataResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              NotificationItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NotificationDataResponseToJson(
        NotificationDataResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
      'total': instance.total,
    };

NotificationItemResponse _$NotificationItemResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationItemResponse(
      id: json['id'] as String?,
      type: json['type'] as String?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      isRead: json['isRead'] as bool?,
      createdAt: json['createdAt'] as String?,
      readAt: json['readAt'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$NotificationItemResponseToJson(
        NotificationItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt,
      'readAt': instance.readAt,
      'data': instance.data,
    };

MarkNotificationReadResponse _$MarkNotificationReadResponseFromJson(
        Map<String, dynamic> json) =>
    MarkNotificationReadResponse(
      status: json['status'] as String?,
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MarkNotificationReadResponseToJson(
        MarkNotificationReadResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'code': instance.code,
      'message': instance.message,
    };
