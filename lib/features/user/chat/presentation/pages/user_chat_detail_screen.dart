import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_shimmer.dart';
import 'package:app_mobile/features/user/chat/presentation/widgets/user_chat_input_bar.dart';
import 'package:app_mobile/features/user/chat/presentation/widgets/user_chat_offer_card.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_chat_detail_controller.dart';

/// User chat detail screen — shows a single conversation thread.
class UserChatDetailScreen extends StatelessWidget {
  final String conversationId;
  final String userName;
  final String? avatarUrl;
  final bool isOnline;

  const UserChatDetailScreen({
    super.key,
    required this.conversationId,
    required this.userName,
    this.avatarUrl,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserChatDetailController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        body: Column(
          children: [
            /// App bar with user info
            Obx(() => ChatAppBar(
              title: userName,
              subtitle: controller.isUserOnline.value
                  ? ManagerStrings.chatActiveNow
                  : ManagerStrings.chatOfflineNow,
              avatarUrl: avatarUrl,
              isOnline: controller.isUserOnline.value,
              showBackButton: true,
            )),

            /// Messages list
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.messages.isEmpty) {
                  return const ChatMessagesShimmer();
                }

                return ListView.separated(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(
                    vertical: ManagerHeight.h12,
                  ),
                  itemCount: controller.messages.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: ManagerHeight.h4),
                  itemBuilder: (context, index) {
                    final msg = controller.messages[index];
                    if (msg.isOffer) {
                      return UserChatOfferCard(
                        title: msg.offerTitle ?? '',
                        description: msg.offerDescription ?? '',
                        price: msg.offerAmount ?? 0,
                        durationDays: 0,
                        addition: msg.offerAdditions?.join('، '),
                        time: msg.createdAt,
                        status: _mapOfferStatus(msg.offerStatus),
                        conversationId: msg.conversationId.isNotEmpty
                            ? msg.conversationId
                            : conversationId,
                        offerId: msg.offerId,
                        onStatusChanged: (status) {
                          final apiStatus = status == UserOfferStatus.accepted
                              ? 'accepted'
                              : status == UserOfferStatus.declined
                                  ? 'rejected'
                                  : 'active';
                          controller.updateOfferStatus(
                            msg.offerId ?? '',
                            apiStatus,
                          );
                          if (status == UserOfferStatus.accepted) {
                            controller.fetchMessages();
                          }
                        },
                      );
                    }
                    return ChatMessageBubble(
                      message: msg.content,
                      time: msg.createdAt,
                      isMe: msg.isMe,
                      attachments: msg.attachments,
                    );
                  },
                );
              }),
            ),

            /// Input bar (no custom offer button)
            Obx(() => UserChatInputBar(
              messageController: controller.messageController,
              focusNode: controller.messageFocusNode,
              onSend: controller.sendMessage,
              selectedFiles: controller.selectedFiles.toList(),
              onFilesAdded: controller.addFiles,
              onRemoveFile: controller.removeFile,
            )),
          ],
        ),
      ),
    );
  }

  UserOfferStatus _mapOfferStatus(String? status) {
    switch ((status ?? '').toLowerCase()) {
      case 'accepted':
        return UserOfferStatus.accepted;
      case 'rejected':
      case 'cancelled':
        return UserOfferStatus.declined;
      default:
        return UserOfferStatus.pending;
    }
  }
}
