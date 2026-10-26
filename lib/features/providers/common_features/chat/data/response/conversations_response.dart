import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'conversations_response.g.dart';

@JsonSerializable()
class ConversationsResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final List<ConversationDataResponse>? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  ConversationsResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory ConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationsResponseToJson(this);
}

@JsonSerializable()
class ConversationDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.userInfo)
  final ConversationUserInfoResponse? userInfo;

  @JsonKey(name: ResponseConstants.lastMessage)
  final LastMessageResponse? lastMessage;

  @JsonKey(name: ResponseConstants.latestOffer)
  final Map<String, dynamic>? latestOffer;

  @JsonKey(name: ResponseConstants.unreadCount)
  final int? unreadCount;

  @JsonKey(name: ResponseConstants.hasUnread)
  final bool? hasUnread;

  @JsonKey(name: ResponseConstants.updatedAt)
  final String? updatedAt;

  ConversationDataResponse({
    this.id,
    this.userInfo,
    this.lastMessage,
    this.latestOffer,
    this.unreadCount,
    this.hasUnread,
    this.updatedAt,
  });

  factory ConversationDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationDataResponseToJson(this);
}

@JsonSerializable()
class ConversationUserInfoResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.fullName)
  final String? fullName;

  @JsonKey(name: ResponseConstants.image)
  final String? image;

  ConversationUserInfoResponse({
    this.id,
    this.fullName,
    this.image,
  });

  factory ConversationUserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationUserInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationUserInfoResponseToJson(this);
}

@JsonSerializable()
class LastMessageResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.content)
  final String? content;

  @JsonKey(name: ResponseConstants.senderId)
  final String? senderId;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: 'attachments')
  final List<LastMessageAttachmentResponse>? attachments;

  LastMessageResponse({
    this.id,
    this.content,
    this.senderId,
    this.createdAt,
    this.attachments,
  });

  factory LastMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$LastMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageResponseToJson(this);
}

@JsonSerializable()
class LastMessageAttachmentResponse {
  @JsonKey(name: 'kind')
  final String? kind;

  @JsonKey(name: 'mimeType')
  final String? mimeType;

  LastMessageAttachmentResponse({
    this.kind,
    this.mimeType,
  });

  factory LastMessageAttachmentResponse.fromJson(Map<String, dynamic> json) =>
      _$LastMessageAttachmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageAttachmentResponseToJson(this);
}
