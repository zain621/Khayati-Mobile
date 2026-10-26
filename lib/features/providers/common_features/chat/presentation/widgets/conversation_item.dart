import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/util/chat_time_formatter.dart';

/// A single conversation row in the conversations list.
class ConversationItem extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String time;
  final String? avatarUrl;
  final bool isOnline;
  final bool hasUnreadMessages;

  /// `'image'`, `'file'`, or `null`.
  final String? lastMessageAttachmentType;
  final VoidCallback onTap;

  const ConversationItem({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.time,
    this.avatarUrl,
    this.isOnline = false,
    this.hasUnreadMessages = false,
    this.lastMessageAttachmentType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        child: Row(
          children: [
            /// Avatar with online indicator
            Stack(
              children: [
                Container(
                  width: ManagerWidth.w48,
                  height: ManagerHeight.h48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                    border: Border.all(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.2),
                      width: 1.5,
                    ),
                    image: avatarUrl != null && avatarUrl!.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(avatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: avatarUrl == null
                      ? Icon(
                          Icons.person,
                          color: ManagerColors.greyWhiteColor,
                          size: ManagerWidth.w24,
                        )
                      : null,
                ),
                if (isOnline)
                  Positioned(
                    bottom: 2,
                    right: 2,
                    child: Container(
                      width: ManagerWidth.w12,
                      height: ManagerHeight.h12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ManagerColors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: ManagerWidth.w12),

            /// Name + Last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  // Show "متاح الآن" with green dot when online, else last message
                  if (isOnline)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: ManagerWidth.w6,
                          height: ManagerHeight.h6,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w5),
                        Text(
                          ManagerStrings.chatActiveNow,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: const Color(0xFF4CAF50),
                          ),
                        ),
                      ],
                    )
                  else
                    _buildLastMessageRow(),
                ],
              ),
            ),

            SizedBox(width: ManagerWidth.w8),

            /// Time + Unread badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatConversationTime(time),
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                SizedBox(height: ManagerHeight.h6),
                if (hasUnreadMessages)
                  Container(
                    width: ManagerWidth.w8,
                    height: ManagerHeight.h8,
                    decoration: const BoxDecoration(
                      color: ManagerColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the last-message subtitle row.
  /// When [lastMessageAttachmentType] is set → show typed indicator.
  /// When content is empty and no type info → show generic attachment label.
  Widget _buildLastMessageRow() {
    final hasText = lastMessage.trim().isNotEmpty;
    final isImage = lastMessageAttachmentType == 'image';
    final isFile = lastMessageAttachmentType == 'file';
    final hasAttachment = isImage || isFile;

    // Known attachment type (with or without text)
    if (hasAttachment) {
      return Row(
        children: [
          Icon(
            isImage
                ? Icons.photo_camera_rounded
                : Icons.insert_drive_file_rounded,
            size: 14,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(width: ManagerWidth.w4),
          Flexible(
            child: Text(
              hasText
                  ? lastMessage
                  : (isImage
                      ? ManagerStrings.chatLastMessagePhoto
                      : ManagerStrings.chatLastMessageFile),
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    // Empty content without explicit type → generic attachment fallback
    if (!hasText) {
      return Row(
        children: [
          Icon(
            Icons.attach_file_rounded,
            size: 14,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(width: ManagerWidth.w4),
          Text(
            ManagerStrings.chatLastMessageFile,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      );
    }

    // Normal text message
    return Text(
      lastMessage,
      style: getRegularTextStyle(
        fontSize: ManagerFontSize.s12,
        color: ManagerColors.greyWhiteColor,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

/// Wraps a child widget with a staggered slide-up + fade animation.
/// Each successive [index] delays the animation slightly for a cascade effect.
class AnimatedConversationEntry extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedConversationEntry({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<AnimatedConversationEntry> createState() =>
      _AnimatedConversationEntryState();
}

class _AnimatedConversationEntryState extends State<AnimatedConversationEntry>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
            .animate(curve);
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(curve);

    // Stagger: cap at 8 so far-off items don't wait too long.
    final delay = Duration(milliseconds: 50 * widget.index.clamp(0, 8));
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}
