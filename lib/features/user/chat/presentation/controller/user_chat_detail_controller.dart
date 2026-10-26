import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/socket/chat_socket_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/model/message_model.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/get_messages_use_case.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/send_message_use_case.dart';

/// Controls the user chat detail screen (single conversation).
/// Reuses the same socket service and use cases.
class UserChatDetailController extends GetxController {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final ChatSocketService chatSocketService;
  final AppSettingsPrefs appSettingsPrefs;
  final String conversationId;
  final String userName;
  final String? avatarUrl;
  final bool isOnline;

  UserChatDetailController({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.chatSocketService,
    required this.appSettingsPrefs,
    required this.conversationId,
    required this.userName,
    this.avatarUrl,
    this.isOnline = false,
  });

  // State
  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isUserOnline = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxList<XFile> selectedFiles = <XFile>[].obs;
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final messageFocusNode = FocusNode();

  StreamSubscription<Map<String, dynamic>>? _messageSubscription;
  StreamSubscription<Map<String, dynamic>>? _statusSubscription;

  @override
  void onInit() {
    super.onInit();
    _connectSocket();
    fetchMessages();
  }

  void _connectSocket() {
    if (!chatSocketService.isConnected) {
      chatSocketService.connect();
    }

    chatSocketService.joinConversation(conversationId);

    _messageSubscription = chatSocketService.onMessageReceived.listen(
      _handleIncomingMessage,
    );

    // Listen for user status changes
    _statusSubscription = chatSocketService.onUserStatusChanged.listen(
      (data) {
        final userId = data['userId']?.toString() ?? '';
        final online = data['isOnline'] == true;
        if (userId.isNotEmpty) {
          isUserOnline.value = online;
        }
      },
    );

    // Check the other user's current status
    chatSocketService.checkUserStatus(conversationId);
  }

  Future<void> fetchMessages() async {
    isLoading.value = true;

    final result = await getMessagesUseCase.execute(conversationId);
    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        messages.assignAll(data.reversed.toList());
        _scrollToBottom();
      },
    );

    isLoading.value = false;
  }

  void sendMessage() {
    final text = messageController.text.trim();
    final files = List<XFile>.from(selectedFiles);

    if (text.isEmpty && files.isEmpty) return;

    if (files.isNotEmpty) {
      _sendViaRest(text, files);
    } else {
      _sendViaSocket(text);
    }
  }

  void _sendViaSocket(String text) {
    final currentUserId = appSettingsPrefs.getUserId();

    // Optimistic local insert
    messages.add(MessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: conversationId,
      senderId: currentUserId,
      senderType: 'user',
      content: text,
      createdAt: DateTime.now().toIso8601String(),
      isMe: true,
    ));

    chatSocketService.sendMessage(
      conversationId: conversationId,
      content: text,
    );

    messageController.clear();
    _scrollToBottom();
  }

  Future<void> _sendViaRest(String text, List<XFile> files) async {
    isSendingMessage.value = true;
    final filePaths = files.map((f) => f.path).toList();
    final result = await sendMessageUseCase.execute(SendMessageParams(
      conversationId: conversationId,
      content: text,
      filePaths: filePaths,
    ));
    isSendingMessage.value = false;
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (message) {
        messages.add(message);
        messageController.clear();
        selectedFiles.clear();
        _scrollToBottom();
      },
    );
  }

  void addFiles(List<XFile> files) {
    selectedFiles.addAll(files);
  }

  void removeFile(XFile file) {
    selectedFiles.removeWhere((f) => f.path == file.path);
  }

  /// Updates a chat-offer message status after accept / decline / paid.
  void updateOfferStatus(String offerId, String status) {
    final index = messages.indexWhere((m) => m.offerId == offerId);
    if (index < 0) return;
    messages[index] = messages[index].copyWith(offerStatus: status);
    messages.refresh();
  }

  void _handleIncomingMessage(Map<String, dynamic> data) {
    final currentUserId = appSettingsPrefs.getUserId();
    final senderId = data['senderId']?.toString() ?? '';

    if (senderId == currentUserId) return;

    messages.add(MessageModel(
      id: data['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      conversationId: data['conversationId']?.toString() ?? conversationId,
      senderId: senderId,
      senderType: data['senderType']?.toString() ?? '',
      content: data['content']?.toString() ?? '',
      createdAt: data['createdAt']?.toString() ??
          DateTime.now().toIso8601String(),
      isMe: false,
    ));

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String getCurrentTime() {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final period = now.period == DayPeriod.am ? 'AM' : 'PM';
    return '$period ${hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _messageSubscription?.cancel();
    _statusSubscription?.cancel();
    messageController.dispose();
    scrollController.dispose();
    messageFocusNode.dispose();
    super.onClose();
  }
}
