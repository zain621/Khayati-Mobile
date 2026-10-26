import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';

part 'chat_offer_response.g.dart';

/// Generic API response for create / update / cancel offer operations.
@JsonSerializable()
class ChatOfferResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  @JsonKey(name: ResponseConstants.data)
  final ChatOfferDataResponse? data;

  ChatOfferResponse({
    this.status,
    this.code,
    this.message,
    this.data,
  });

  factory ChatOfferResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatOfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatOfferResponseToJson(this);
}

Object? _readChatOfferId(Map json, String key) => json['id'] ?? json['_id'];

@JsonSerializable()
class ChatOfferDataResponse {
  @JsonKey(name: 'id', readValue: _readChatOfferId)
  final String? id;

  @JsonKey(name: ResponseConstants.conversationId)
  final String? conversationId;

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

  ChatOfferDataResponse({
    this.id,
    this.conversationId,
    this.title,
    this.description,
    this.amount,
    this.additions,
    this.offerStatus,
    this.createdAt,
  });

  factory ChatOfferDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatOfferDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatOfferDataResponseToJson(this);
}
