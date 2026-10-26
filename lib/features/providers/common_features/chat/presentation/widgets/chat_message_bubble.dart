import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/util/chat_time_formatter.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/model/message_model.dart';

/// Displays a single chat message — green (me) or light (them).
/// Includes formatted time, attachments (images inline, files as cards),
/// and a double-checkmark for sent messages.
class ChatMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;
  final List<MessageAttachmentModel>? attachments;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.time,
    required this.isMe,
    this.attachments,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = formatMessageTime(time);
    final hasAttachments =
        attachments != null && attachments!.isNotEmpty;
    final showText = message.trim().isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(
        left: isMe ? ManagerWidth.w48 : ManagerWidth.w12,
        right: isMe ? ManagerWidth.w12 : ManagerWidth.w48,
        top: ManagerHeight.h3,
        bottom: ManagerHeight.h3,
      ),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w12,
            vertical: ManagerHeight.h10,
          ),
          decoration: BoxDecoration(
            color: isMe
                ? ManagerColors.primaryColor
                : const Color(0xFFF2F4F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ManagerRadius.r16),
              topRight: Radius.circular(ManagerRadius.r16),
              bottomLeft: isMe
                  ? Radius.circular(ManagerRadius.r16)
                  : Radius.circular(ManagerRadius.r4),
              bottomRight: isMe
                  ? Radius.circular(ManagerRadius.r4)
                  : Radius.circular(ManagerRadius.r16),
            ),
            boxShadow: [
              BoxShadow(
                color: ManagerColors.black.withOpacity(0.04),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              // ── Attachments ───────────────────────────────────────────
              if (hasAttachments) ...[
                ...attachments!.map((a) => _buildAttachment(a)),
                if (showText) SizedBox(height: ManagerHeight.h6),
              ],
              // ── Message text ──────────────────────────────────────────
              if (showText)
                Text(
                  message,
                  textDirection: Directionality.of(context),
                  textAlign: TextAlign.right,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: isMe ? ManagerColors.white : ManagerColors.black,
                  ),
                ),
              SizedBox(height: ManagerHeight.h4),
              // ── Time + read receipt ────────────────────────────────────
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isMe) ...[
                    Icon(
                      Icons.done_all_rounded,
                      size: ManagerFontSize.s12,
                      color: ManagerColors.white.withOpacity(0.80),
                    ),
                    SizedBox(width: ManagerWidth.w3),
                  ],
                  Text(
                    formattedTime,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s10,
                      color: isMe
                          ? ManagerColors.white.withOpacity(0.70)
                          : ManagerColors.greyWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttachment(MessageAttachmentModel attachment) {
    if (attachment.isImage) {
      return Padding(
        padding: EdgeInsets.only(bottom: ManagerHeight.h4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          child: Image.network(
            attachment.url,
            width: ManagerWidth.w200,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) => progress == null
                ? child
                : Container(
                    width: ManagerWidth.w200,
                    height: ManagerHeight.h120,
                    color: ManagerColors.black.withOpacity(0.05),
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
            errorBuilder: (_, __, ___) => Container(
              width: ManagerWidth.w200,
              height: ManagerHeight.h80,
              color: ManagerColors.black.withOpacity(0.05),
              child: const Icon(Icons.broken_image_outlined, size: 32),
            ),
          ),
        ),
      );
    }
    // Non-image file card
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h4),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w10,
          vertical: ManagerHeight.h8,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? ManagerColors.white.withOpacity(0.15)
              : ManagerColors.black.withOpacity(0.06),
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              color: isMe ? ManagerColors.white : ManagerColors.primaryColor,
              size: 22,
            ),
            SizedBox(width: ManagerWidth.w8),
            Flexible(
              child: Text(
                attachment.originalName ?? '',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: isMe ? ManagerColors.white : ManagerColors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

