import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/create_conversation_response.dart';
import '../../domain/model/conversation_model.dart';

/// Maps [CreateConversationDataResponse] → [ConversationModel].
///
/// [currentUserId] is used to pick the *other* user's info for display.
extension CreateConversationMapper on CreateConversationDataResponse {
  ConversationModel toDomain(String currentUserId) {
    // If the current user is the regular user, show tailor info and vice versa.
    final isCurrentUser = userId == currentUserId;
    final otherUser = isCurrentUser ? tailor : user;

    return ConversationModel(
      id: id.onNull(),
      otherUserName: otherUser?.fullName.onNull() ?? '',
      otherUserImage: otherUser?.image,
      lastMessage: null,
      unreadCount: 0,
      hasUnread: false,
      updatedAt: createdAt.onNull(),
    );
  }
}

/// Maps the full [CreateConversationResponse] → [ConversationModel].
extension CreateConversationResponseMapper on CreateConversationResponse {
  ConversationModel toDomain(String currentUserId) {
    return data!.toDomain(currentUserId);
  }
}
