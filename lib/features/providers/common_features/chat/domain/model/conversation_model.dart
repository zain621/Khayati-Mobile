/// Domain model for a single conversation in the list.
class ConversationModel {
  final String id;
  final String otherUserName;
  final String? otherUserImage;
  final String? lastMessage;

  /// `'image'` or `'file'` when the last message has attachments, `null` otherwise.
  final String? lastMessageAttachmentType;
  final int unreadCount;
  final bool hasUnread;
  final String updatedAt;

  ConversationModel({
    required this.id,
    required this.otherUserName,
    this.otherUserImage,
    this.lastMessage,
    this.lastMessageAttachmentType,
    required this.unreadCount,
    required this.hasUnread,
    required this.updatedAt,
  });
}
