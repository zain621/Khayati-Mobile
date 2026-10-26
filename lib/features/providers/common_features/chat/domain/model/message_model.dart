/// A file attachment on a message.
class MessageAttachmentModel {
  final String id;
  final String url;
  final String kind; // "image" | "document" | "video" etc.
  final String? mimeType;
  final String? originalName;
  final int? sizeBytes;

  const MessageAttachmentModel({
    required this.id,
    required this.url,
    required this.kind,
    this.mimeType,
    this.originalName,
    this.sizeBytes,
  });

  bool get isImage => kind == 'image';
}

/// Domain model for a single message in a conversation.
/// For offer-type items, [offerId] is non-null and [isOffer] returns true.
class MessageModel {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderType;
  final String content;
  final String createdAt;
  final bool isMe;
  final List<MessageAttachmentModel>? attachments;

  // Offer-specific fields (null for regular messages)
  final String? offerId;
  final String? offerTitle;
  final String? offerDescription;
  final double? offerAmount;
  final List<String>? offerAdditions;
  final String? offerStatus;

  MessageModel({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderType,
    required this.content,
    required this.createdAt,
    required this.isMe,
    this.attachments,
    this.offerId,
    this.offerTitle,
    this.offerDescription,
    this.offerAmount,
    this.offerAdditions,
    this.offerStatus,
  });

  bool get isOffer => offerId != null && offerId!.isNotEmpty;
  bool get hasAttachments => attachments != null && attachments!.isNotEmpty;

  MessageModel copyWith({
    String? id,
    String? conversationId,
    String? senderId,
    String? senderType,
    String? content,
    String? createdAt,
    bool? isMe,
    List<MessageAttachmentModel>? attachments,
    String? offerId,
    String? offerTitle,
    String? offerDescription,
    double? offerAmount,
    List<String>? offerAdditions,
    String? offerStatus,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      senderType: senderType ?? this.senderType,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      isMe: isMe ?? this.isMe,
      attachments: attachments ?? this.attachments,
      offerId: offerId ?? this.offerId,
      offerTitle: offerTitle ?? this.offerTitle,
      offerDescription: offerDescription ?? this.offerDescription,
      offerAmount: offerAmount ?? this.offerAmount,
      offerAdditions: offerAdditions ?? this.offerAdditions,
      offerStatus: offerStatus ?? this.offerStatus,
    );
  }
}
