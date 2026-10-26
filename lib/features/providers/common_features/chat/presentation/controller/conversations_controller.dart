import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/conversation_model.dart';
import '../../domain/use_case/get_conversations_use_case.dart';

/// Controls the provider conversations list screen.
class ConversationsController extends GetxController {
  final GetConversationsUseCase _getConversationsUseCase;

  ConversationsController(this._getConversationsUseCase);

  // State
  final RxList<ConversationModel> conversations = <ConversationModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  /// Returns conversations filtered by search query.
  List<ConversationModel> get filteredConversations {
    final query = searchQuery.value.trim();
    if (query.isEmpty) return conversations;
    return conversations
        .where((c) =>
            c.otherUserName.contains(query) ||
            (c.lastMessage?.contains(query) ?? false))
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
  }

  Future<void> fetchConversations() async {
    isLoading.value = true;

    final result = await _getConversationsUseCase.execute();

    result.fold(
      (failure) {
        AppSnackbar.error(failure.message);
      },
      (data) {
        conversations.assignAll(data);
      },
    );

    isLoading.value = false;
  }

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
