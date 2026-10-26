import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/conversations_response.dart';
import '../../domain/model/conversation_model.dart';

/// Maps a single [ConversationDataResponse] → [ConversationModel].
extension ConversationDataMapper on ConversationDataResponse {
  ConversationModel toDomain() {
    return ConversationModel(
      id: id.onNull(),
      otherUserName: userInfo?.fullName.onNull() ?? '',
      otherUserImage: userInfo?.image,
      lastMessage: lastMessage?.content,
      lastMessageAttachmentType: _resolveAttachmentType(lastMessage),
      unreadCount: unreadCount.onNull(),
      hasUnread: hasUnread.onNull(),
      updatedAt: updatedAt.onNull(),
    );
  }

  /// Returns `'image'` or `'file'` based on the first attachment's kind/mime,
  /// or `null` when there are no attachments.
  String? _resolveAttachmentType(LastMessageResponse? msg) {
    final attachments = msg?.attachments;
    if (attachments == null || attachments.isEmpty) return null;
    final first = attachments.first;
    final kind = first.kind?.toLowerCase() ?? '';
    final mime = first.mimeType?.toLowerCase() ?? '';
    if (kind == 'image' || mime.startsWith('image/')) return 'image';
    return 'file';
  }
}

/// Maps [ConversationsResponse] → list of [ConversationModel].
extension ConversationsMapper on ConversationsResponse {
  List<ConversationModel> toDomain() {
    return (data ?? []).map((item) => item.toDomain()).toList();
  }
}
