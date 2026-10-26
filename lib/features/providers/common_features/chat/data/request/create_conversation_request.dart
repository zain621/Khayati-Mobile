/// Request body for creating or getting a conversation.
class CreateConversationRequest {
  final String tailorId;
  final String userId;

  CreateConversationRequest({
    required this.tailorId,
    required this.userId,
  });
}
