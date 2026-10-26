import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'messages_response.g.dart';

@JsonSerializable()
class MessagesResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final MessagesDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  MessagesResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}

@JsonSerializable()
class MessagesDataResponse {
  @JsonKey(name: ResponseConstants.items)
  final List<MessageItemWrapperResponse>? items;

  @JsonKey(name: ResponseConstants.hasMore)
  final bool? hasMore;

  @JsonKey(name: ResponseConstants.nextCursor)
  final String? nextCursor;

  MessagesDataResponse({
    this.items,
    this.hasMore,
    this.nextCursor,
  });

  factory MessagesDataResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesDataResponseToJson(this);
}

/// Wrapper for each item in the messages list.
/// API returns: { "type": "message" | "offer", "createdAt": "...", "message": {...} }
/// Or for offers: { "type": "offer", "createdAt": "...", "offer": {...} }
@JsonSerializable()
class MessageItemWrapperResponse {
  @JsonKey(name: 'type')
  final String? type;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  @JsonKey(name: ResponseConstants.message)
  final MessageItemResponse? message;

  @JsonKey(name: 'offer')
  final OfferItemResponse? offer;

  MessageItemWrapperResponse({
    this.type,
    this.createdAt,
    this.message,
    this.offer,
  });

  factory MessageItemWrapperResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageItemWrapperResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemWrapperResponseToJson(this);
}

/// Offer data nested inside an offer-type message wrapper.
@JsonSerializable()
class OfferItemResponse {
  /// Backend uses `id` (UUID). Keep `_id` as a fallback for older payloads.
  @JsonKey(name: 'id', readValue: _readOfferId)
  final String? id;

  @JsonKey(name: ResponseConstants.conversationId)
  final String? conversationId;

  @JsonKey(name: ResponseConstants.tailorId)
  final String? tailorId;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'amount')
  final double? amount;

  @JsonKey(name: 'additions')
  final List<String>? additions;

  @JsonKey(name: 'status')
  final String? offerStatus;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  OfferItemResponse({
    this.id,
    this.conversationId,
    this.tailorId,
    this.title,
    this.description,
    this.amount,
    this.additions,
    this.offerStatus,
    this.createdAt,
  });

  factory OfferItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferItemResponseToJson(this);
}

Object? _readOfferId(Map json, String key) => json['id'] ?? json['_id'];

/// The actual message data nested inside the wrapper.
@JsonSerializable()
class MessageItemResponse {
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
  final List<MessageAttachmentResponse>? attachments;

  MessageItemResponse({
    this.id,
    this.conversationId,
    this.senderId,
    this.content,
    this.createdAt,
    this.attachments,
  });

  factory MessageItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageItemResponseToJson(this);
}

/// A single file attachment on a message.
@JsonSerializable()
class MessageAttachmentResponse {
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

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  MessageAttachmentResponse({
    this.id,
    this.url,
    this.kind,
    this.mimeType,
    this.originalName,
    this.sizeBytes,
    this.createdAt,
  });

  factory MessageAttachmentResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageAttachmentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MessageAttachmentResponseToJson(this);
}
