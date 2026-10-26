import 'package:json_annotation/json_annotation.dart';
import '../../../../../constants/response_constants/response_constants.dart';

part 'notification_response.g.dart';

// ─── Root wrapper ─────────────────────────────────────────────────────────────

@JsonSerializable()
class NotificationListResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final NotificationDataResponse? data;

  const NotificationListResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationListResponseToJson(this);
}

// ─── Paginated data wrapper ───────────────────────────────────────────────────

@JsonSerializable()
class NotificationDataResponse {
  @JsonKey(name: ResponseConstants.items)
  final List<NotificationItemResponse>? items;

  @JsonKey(name: ResponseConstants.total)
  final int? total;

  const NotificationDataResponse({this.items, this.total});

  factory NotificationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationDataResponseToJson(this);
}

// ─── Single notification item ─────────────────────────────────────────────────

@JsonSerializable()
class NotificationItemResponse {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: ResponseConstants.notificationType)
  final String? type;

  @JsonKey(name: ResponseConstants.notificationTitle)
  final String? title;

  @JsonKey(name: ResponseConstants.notificationBody)
  final String? body;

  @JsonKey(name: ResponseConstants.notificationIsRead)
  final bool? isRead;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.notificationReadAt)
  final String? readAt;

  @JsonKey(name: ResponseConstants.data)
  final Map<String, dynamic>? data;

  const NotificationItemResponse({
    this.id,
    this.type,
    this.title,
    this.body,
    this.isRead,
    this.createdAt,
    this.readAt,
    this.data,
  });

  factory NotificationItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationItemResponseToJson(this);
}

// ─── Mark as read wrapper ─────────────────────────────────────────────────────

@JsonSerializable()
class MarkNotificationReadResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  const MarkNotificationReadResponse({this.status, this.code, this.message});

  factory MarkNotificationReadResponse.fromJson(Map<String, dynamic> json) =>
      _$MarkNotificationReadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarkNotificationReadResponseToJson(this);
}
