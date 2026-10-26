import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_mobile/core/socket/chat_socket_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/message_model.dart';
import '../../domain/use_case/get_messages_use_case.dart';
import '../../domain/use_case/send_message_use_case.dart';
import '../../domain/use_case/create_chat_offer_use_case.dart';
import '../../domain/use_case/update_chat_offer_use_case.dart';
import '../../domain/use_case/cancel_chat_offer_use_case.dart';

/// Controls the provider chat detail screen (single conversation).
class ChatDetailController extends GetxController {
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final CreateChatOfferUseCase createChatOfferUseCase;
  final UpdateChatOfferUseCase updateChatOfferUseCase;
  final CancelChatOfferUseCase cancelChatOfferUseCase;
  final ChatSocketService chatSocketService;
  final AppSettingsPrefs appSettingsPrefs;
  final String conversationId;
  final String userName;
  final String? avatarUrl;
  final bool isOnline;

  ChatDetailController({
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.createChatOfferUseCase,
    required this.updateChatOfferUseCase,
    required this.cancelChatOfferUseCase,
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
  final RxBool isSendingOffer = false.obs;
  final RxBool isSendingMessage = false.obs;
  final RxList<XFile> selectedFiles = <XFile>[].obs;
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final messageFocusNode = FocusNode();

  bool get canSendOffer {
    final role = appSettingsPrefs.getUserRole();
    return role == 'independent_tailor' || role == 'comprehensive_tailor';
  }

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

    // Join the conversation room
    chatSocketService.joinConversation(conversationId);

    // Listen for incoming messages
    _messageSubscription = chatSocketService.onMessageReceived.listen(
      _handleIncomingMessage,
    );

    // Listen for user status changes
    _statusSubscription = chatSocketService.onUserStatusChanged.listen(
      (data) {
        final userId = data['userId']?.toString() ?? '';
        final online = data['isOnline'] == true;
        // Update if it's the other user in this conversation
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
      senderType: 'tailor',
      content: text,
      createdAt: DateTime.now().toIso8601String(),
      isMe: true,
    ));

    // Emit through socket
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

  void _handleIncomingMessage(Map<String, dynamic> data) {
    final currentUserId = appSettingsPrefs.getUserId();
    final senderId = data['senderId']?.toString() ?? '';

    // Avoid duplicating our own optimistic message
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

  Future<bool> createOffer({
    required String title,
    required String description,
    required double amount,
    List<String>? additions,
  }) async {
    isSendingOffer.value = true;
    final body = <String, dynamic>{
      'title': title,
      'description': description,
      'amount': amount,
      if (additions != null && additions.isNotEmpty) 'additions': additions,
    };
    final result = await createChatOfferUseCase.execute(
      CreateChatOfferParams(conversationId: conversationId, body: body),
    );
    isSendingOffer.value = false;
    return result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (_) {
        fetchMessages();
        return true;
      },
    );
  }

  Future<bool> updateOffer({
    required String offerId,
    required String title,
    required String description,
    required double amount,
    List<String>? additions,
  }) async {
    isSendingOffer.value = true;
    final body = <String, dynamic>{
      'title': title,
      'description': description,
      'amount': amount,
      if (additions != null && additions.isNotEmpty) 'additions': additions,
    };
    final result = await updateChatOfferUseCase.execute(
      UpdateChatOfferParams(
          conversationId: conversationId, offerId: offerId, body: body),
    );
    isSendingOffer.value = false;
    return result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
        return false;
      },
      (_) {
        fetchMessages();
        return true;
      },
    );
  }

  Future<void> cancelOffer(String offerId) async {
    isSendingOffer.value = true;
    final result = await cancelChatOfferUseCase.execute(
      CancelChatOfferParams(conversationId: conversationId, offerId: offerId),
    );
    isSendingOffer.value = false;
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) => fetchMessages(),
    );
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
