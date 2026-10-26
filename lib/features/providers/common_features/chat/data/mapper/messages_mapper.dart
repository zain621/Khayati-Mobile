import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/messages_response.dart';
import '../../domain/model/message_model.dart';

/// Maps a single [MessageItemWrapperResponse] → [MessageModel].
///
/// [currentUserId] is used to determine whether the message was sent by
/// the current user — this drives the `isMe` flag in the UI.
extension MessageItemWrapperMapper on MessageItemWrapperResponse {
  MessageModel toDomain(String currentUserId) {
    if (type == 'offer' && offer != null) {
      final o = offer!;
      return MessageModel(
        id: o.id ?? '',
        conversationId: o.conversationId.onNull(),
        senderId: o.tailorId ?? '',
        senderType: 'offer',
        content: o.title ?? '',
        createdAt: o.createdAt ?? createdAt.onNull(),
        isMe: o.tailorId == currentUserId,
        offerId: o.id,
        offerTitle: o.title,
        offerDescription: o.description,
        offerAmount: o.amount?.toDouble(),
        offerAdditions: o.additions,
        offerStatus: o.offerStatus,
      );
    }
    final msg = message;
    return MessageModel(
      id: msg?.id.onNull() ?? '',
      conversationId: msg?.conversationId.onNull() ?? '',
      senderId: msg?.senderId.onNull() ?? '',
      senderType: type.onNull(),
      content: msg?.content.onNull() ?? '',
      createdAt: msg?.createdAt.onNull() ?? createdAt.onNull(),
      isMe: msg?.senderId == currentUserId,
      attachments: (msg?.attachments ?? [])
          .map((a) => MessageAttachmentModel(
                id: a.id ?? '',
                url: a.url ?? '',
                kind: a.kind ?? 'image',
                mimeType: a.mimeType,
                originalName: a.originalName,
                sizeBytes: a.sizeBytes,
              ))
          .toList(),
    );
  }
}

/// Maps [MessagesResponse] → list of [MessageModel].
extension MessagesMapper on MessagesResponse {
  List<MessageModel> toDomain(String currentUserId) {
    return (data?.items ?? [])
        .map((item) => item.toDomain(currentUserId))
        .toList();
  }
}
