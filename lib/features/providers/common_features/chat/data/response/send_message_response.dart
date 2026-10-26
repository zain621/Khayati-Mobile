import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'send_message_response.g.dart';

@JsonSerializable()
class SendMessageResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final SendMessageDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  SendMessageResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory SendMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageResponseToJson(this);
}

@JsonSerializable()
class SendMessageDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.conversationId)
  final String? conversationId;

  @JsonKey(name: ResponseConstants.senderId)
  final String? senderId;

  @JsonKey(name: ResponseConstants.content)
  final String? content;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: 'attachments')
  final List<SendMessageAttachmentData>? attachments;

  SendMessageDataResponse({
    this.id,
    this.conversationId,
    this.senderId,
    this.content,
    this.createdAt,
    this.attachments,
  });

  factory SendMessageDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SendMessageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageDataResponseToJson(this);
}

@JsonSerializable()
class SendMessageAttachmentData {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: 'url')
  final String? url;

  @JsonKey(name: 'kind')
  final String? kind;

  @JsonKey(name: 'mimeType')
  final String? mimeType;

  @JsonKey(name: 'originalName')
  final String? originalName;

  @JsonKey(name: 'sizeBytes')
  final int? sizeBytes;

  SendMessageAttachmentData({
    this.id,
    this.url,
    this.kind,
    this.mimeType,
    this.originalName,
    this.sizeBytes,
  });

  factory SendMessageAttachmentData.fromJson(Map<String, dynamic> json) =>
      _$SendMessageAttachmentDataFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageAttachmentDataToJson(this);
}
