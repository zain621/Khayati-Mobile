import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Conversation List Shimmer — staggered fade-in for a polished feel
// ═══════════════════════════════════════════════════════════════════════════

class ConversationShimmer extends StatefulWidget {
  const ConversationShimmer({super.key});

  @override
  State<ConversationShimmer> createState() => _ConversationShimmerState();
}

class _ConversationShimmerState extends State<ConversationShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Vary the name/message widths per row for a realistic look.
  static const _nameWidths = [0.35, 0.50, 0.28, 0.42, 0.38, 0.55, 0.30, 0.45];
  static const _msgWidths = [0.55, 0.40, 0.65, 0.48, 0.58, 0.35, 0.60, 0.50];

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
        itemCount: 8,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => Divider(
          height: 1,
          color: Colors.grey.shade100,
          indent: ManagerWidth.w76,
          endIndent: ManagerWidth.w16,
        ),
        itemBuilder: (_, index) {
          // Stagger opacity per item
          final delay = index * 0.08;
          final end = (delay + 0.4).clamp(0.0, 1.0);
          final anim = CurvedAnimation(
            parent: _controller,
            curve: Interval(delay, end, curve: Curves.easeOut),
          );
          return FadeTransition(
            opacity: anim,
            child: _ConversationShimmerItem(
              nameWidth: screenW * _nameWidths[index],
              messageWidth: screenW * _msgWidths[index],
            ),
          );
        },
      ),
    );
  }
}

class _ConversationShimmerItem extends StatelessWidget {
  final double nameWidth;
  final double messageWidth;

  const _ConversationShimmerItem({
    required this.nameWidth,
    required this.messageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h12,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: ManagerWidth.w48,
            height: ManagerHeight.h48,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade100,
                width: 1.5,
              ),
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Container(
                  width: nameWidth,
                  height: ManagerHeight.h12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r6),
                  ),
                ),
                SizedBox(height: ManagerHeight.h8),
                // Last message
                Container(
                  width: messageWidth,
                  height: ManagerHeight.h10,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          // Time + badge placeholder
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: ManagerWidth.w36,
                height: ManagerHeight.h10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ManagerRadius.r4),
                ),
              ),
              SizedBox(height: ManagerHeight.h6),
              Container(
                width: ManagerWidth.w8,
                height: ManagerHeight.h8,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// Chat Messages Shimmer
// ═══════════════════════════════════════════════════════════════════════════

class ChatMessagesShimmer extends StatelessWidget {
  const ChatMessagesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.grey.shade50,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h16,
        ),
        child: Column(
          children: [
            _bubble(Alignment.centerLeft, screenWidth * 0.55, ManagerHeight.h40),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerRight, screenWidth * 0.45, ManagerHeight.h40),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerLeft, screenWidth * 0.65, ManagerHeight.h56),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerRight, screenWidth * 0.40, ManagerHeight.h40),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerLeft, screenWidth * 0.50, ManagerHeight.h40),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerRight, screenWidth * 0.60, ManagerHeight.h48),
            SizedBox(height: ManagerHeight.h14),
            _bubble(Alignment.centerLeft, screenWidth * 0.40, ManagerHeight.h40),
          ],
        ),
      ),
    );
  }

  Widget _bubble(Alignment align, double width, double height) {
    final isMe = align == Alignment.centerRight;
    return Align(
      alignment: align,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
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
        ),
      ),
    );
  }
}
