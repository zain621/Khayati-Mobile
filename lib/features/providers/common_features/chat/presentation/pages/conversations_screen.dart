import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_app_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/conversation_item.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/widgets/chat_shimmer.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/controller/conversations_controller.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/di/di.dart'
    as chat_di;

/// Conversations list screen — shows all chat threads (Provider side).
class ConversationsScreen extends StatefulWidget {
  const ConversationsScreen({super.key});

  @override
  State<ConversationsScreen> createState() => _ConversationsScreenState();
}

class _ConversationsScreenState extends State<ConversationsScreen> {
  late final ConversationsController controller;

  @override
  void initState() {
    super.initState();
    chat_di.initProviderChat(forceRefresh: true);
    controller = Get.find<ConversationsController>();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: ManagerColors.white,
        body: Column(
          children: [
            /// App bar with embedded search
            Obx(() => ChatAppBar(
                  title: ManagerStrings.chatConversationsTitle,
                  subtitle:
                      '${controller.conversations.length} ${ManagerStrings.chatConversationsCount}',
                  showBackButton: false,
                  showSearchBar: true,
                  searchController: controller.searchController,
                  searchFocusNode: controller.searchFocusNode,
                  onSearchChanged: controller.onSearchChanged,
                )),

            SizedBox(height: ManagerHeight.h8),

            /// Conversations list
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value &&
                    controller.conversations.isEmpty) {
                  return const ConversationShimmer();
                }

                final conversations = controller.filteredConversations;

                return RefreshIndicator(
                  onRefresh: controller.fetchConversations,
                  color: ManagerColors.primaryColor,
                  backgroundColor: ManagerColors.white,
                  displacement: ManagerHeight.h40,
                  child: conversations.isEmpty
                      ? _buildEmptyRefreshable()
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            top: ManagerHeight.h4,
                            bottom: ManagerHeight.h20,
                          ),
                          itemCount: conversations.length,
                          separatorBuilder: (_, __) => Divider(
                            height: 1,
                            color:
                                ManagerColors.greyWhiteColor.withOpacity(0.15),
                            indent: ManagerWidth.w76,
                            endIndent: ManagerWidth.w16,
                          ),
                          itemBuilder: (context, index) {
                            final conversation = conversations[index];
                            return AnimatedConversationEntry(
                              index: index,
                              child: ConversationItem(
                                userName: conversation.otherUserName,
                                lastMessage: conversation.lastMessage ?? '',
                                lastMessageAttachmentType:
                                    conversation.lastMessageAttachmentType,
                                time: conversation.updatedAt,
                                avatarUrl: conversation.otherUserImage,
                                isOnline: false,
                                hasUnreadMessages: conversation.hasUnread,
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.chatDetailScreen,
                                    arguments: {
                                      'conversationId': conversation.id,
                                      'userName': conversation.otherUserName,
                                      'avatarUrl': conversation.otherUserImage,
                                      'isOnline': false,
                                    },
                                  );
                                },
                              ),
                            );
                          },
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  /// Scrollable empty state so RefreshIndicator works
  Widget _buildEmptyRefreshable() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 56,
                    color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                  ),
                  SizedBox(height: ManagerHeight.h16),
                  Text(
                    ManagerStrings.chatNoConversations,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h8),
                  Text(
                    ManagerStrings.chatNoConversationsDesc,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
