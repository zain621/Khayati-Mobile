import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_custom_offer_card.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_input_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_message_bubble.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_shimmer.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/controller/chat_detail_controller.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/model/message_model.dart';

/// Chat detail screen — shows a single conversation thread (Provider side).
class ChatDetailScreen extends StatelessWidget {
  final String conversationId;
  final String userName;
  final String? avatarUrl;
  final bool isOnline;

  const ChatDetailScreen({
    super.key,
    required this.conversationId,
    required this.userName,
    this.avatarUrl,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChatDetailController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FE),
        body: Stack(
          children: [
            Column(
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
                          return ChatCustomOfferCard(
                            title: msg.offerTitle ?? '',
                            description: msg.offerDescription ?? '',
                            price: msg.offerAmount ?? 0,
                            addition: msg.offerAdditions?.join('، '),
                            time: msg.createdAt,
                            onEdit: msg.isMe
                                ? () => _handleEditOffer(context, controller, msg)
                                : null,
                            onCancel: msg.isMe
                                ? () => _handleCancelOffer(context, controller, msg)
                                : null,
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

                /// Input bar
                Obx(() => ChatInputBar(
                  messageController: controller.messageController,
                  focusNode: controller.messageFocusNode,
                  onSend: controller.sendMessage,
                  showOfferButton: controller.canSendOffer,
                  onCustomOffer: () => _handleCustomOffer(context, controller),
                  selectedFiles: controller.selectedFiles.toList(),
                  onFilesAdded: controller.addFiles,
                  onRemoveFile: controller.removeFile,
                )),
              ],
            ),

            /// Loading overlay while sending offer or message with attachments
            Obx(() => (controller.isSendingOffer.value ||
                    controller.isSendingMessage.value)
                ? const Positioned.fill(
                    child: ColoredBox(
                      color: Color(0x55000000),
                      child: Center(child: LoadingWidget()),
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  void _handleCustomOffer(
      BuildContext context, ChatDetailController controller) {
    Navigator.pushNamed(
      context,
      Routes.addCustomOfferScreen,
      arguments: {
        'conversationId': conversationId,
        'userName': userName,
      },
    );
  }

  void _handleEditOffer(BuildContext context, ChatDetailController controller,
      MessageModel msg) {
    Navigator.pushNamed(
      context,
      Routes.addCustomOfferScreen,
      arguments: {
        'conversationId': conversationId,
        'userName': userName,
        'isEdit': true,
        'offerId': msg.offerId,
        'existingTitle': msg.offerTitle,
        'existingDescription': msg.offerDescription,
        'existingPrice': msg.offerAmount,
        'existingAdditions': msg.offerAdditions,
      },
    );
  }

  void _handleCancelOffer(BuildContext context, ChatDetailController controller,
      MessageModel msg) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(ManagerStrings.chatOfferCancelConfirmTitle),
        content: Text(ManagerStrings.chatOfferCancelConfirmSubtitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(ManagerStrings.addCustomOfferCancelButton),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(ManagerStrings.chatOfferCancel),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      controller.cancelOffer(msg.offerId!);
    }
  }
}

