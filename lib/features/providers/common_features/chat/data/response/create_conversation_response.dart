import 'package:json_annotation/json_annotation.dart';
import 'package:app_mobile/constants/response_constants/response_constants.dart';
import 'conversations_response.dart';

part 'create_conversation_response.g.dart';

@JsonSerializable()
class CreateConversationResponse {
  @JsonKey(name: ResponseConstants.status)
  final String? status;

  @JsonKey(name: ResponseConstants.code)
  final int? code;

  @JsonKey(name: ResponseConstants.data)
  final CreateConversationDataResponse? data;

  @JsonKey(name: ResponseConstants.message)
  final String? message;

  CreateConversationResponse({
    this.status,
    this.code,
    this.data,
    this.message,
  });

  factory CreateConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateConversationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateConversationResponseToJson(this);
}

@JsonSerializable()
class CreateConversationDataResponse {
  @JsonKey(name: ResponseConstants.entityId)
  final String? id;

  @JsonKey(name: ResponseConstants.tailorId)
  final String? tailorId;

  @JsonKey(name: ResponseConstants.userId)
  final String? userId;

  @JsonKey(name: ResponseConstants.tailor)
  final ConversationUserInfoResponse? tailor;

  @JsonKey(name: ResponseConstants.user)
  final ConversationUserInfoResponse? user;

  @JsonKey(name: ResponseConstants.createdAt)
  final String? createdAt;

  CreateConversationDataResponse({
    this.id,
    this.tailorId,
    this.userId,
    this.tailor,
    this.user,
    this.createdAt,
  });

  factory CreateConversationDataResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CreateConversationDataResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateConversationDataResponseToJson(this);
}
