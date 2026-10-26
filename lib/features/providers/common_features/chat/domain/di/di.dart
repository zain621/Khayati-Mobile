import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/socket/chat_socket_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/chat_data_source.dart';
import '../../data/repository/chat_repository.dart';
import '../../presentation/controller/conversations_controller.dart';
import '../../presentation/controller/chat_detail_controller.dart';
import '../use_case/get_conversations_use_case.dart';
import '../use_case/get_messages_use_case.dart';
import '../use_case/create_conversation_use_case.dart';
import '../use_case/send_message_use_case.dart';
import '../use_case/create_chat_offer_use_case.dart';
import '../use_case/update_chat_offer_use_case.dart';
import '../use_case/cancel_chat_offer_use_case.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_conversations_controller.dart';
import 'package:app_mobile/features/user/chat/presentation/controller/user_chat_detail_controller.dart';

// ─────────────────────────────────────────────────────
// Shared data-layer dependencies (used by both roles)
// ─────────────────────────────────────────────────────

void _initChatDeps() {
  if (!GetIt.I.isRegistered<ChatDataSource>()) {
    instance.registerLazySingleton<ChatDataSource>(
      () => ChatDataSourceImplement(instance<AppService>(), instance<Dio>()),
    );
  }
  if (!GetIt.I.isRegistered<ChatRepository>()) {
    instance.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplement(
        instance<ChatDataSource>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetConversationsUseCase>()) {
    instance.registerFactory<GetConversationsUseCase>(
      () => GetConversationsUseCase(instance<ChatRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetMessagesUseCase>()) {
    instance.registerFactory<GetMessagesUseCase>(
      () => GetMessagesUseCase(instance<ChatRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CreateConversationUseCase>()) {
    instance.registerFactory<CreateConversationUseCase>(
      () => CreateConversationUseCase(instance<ChatRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<SendMessageUseCase>()) {
    instance.registerFactory<SendMessageUseCase>(
      () => SendMessageUseCase(instance<ChatRepository>()),
    );
  }
}

void _disposeChatDeps() {
  if (GetIt.I.isRegistered<SendMessageUseCase>()) {
    instance.unregister<SendMessageUseCase>();
  }
  if (GetIt.I.isRegistered<CreateConversationUseCase>()) {
    instance.unregister<CreateConversationUseCase>();
  }
  if (GetIt.I.isRegistered<GetMessagesUseCase>()) {
    instance.unregister<GetMessagesUseCase>();
  }
  if (GetIt.I.isRegistered<GetConversationsUseCase>()) {
    instance.unregister<GetConversationsUseCase>();
  }
  if (GetIt.I.isRegistered<ChatRepository>()) {
    instance.unregister<ChatRepository>();
  }
  if (GetIt.I.isRegistered<ChatDataSource>()) {
    instance.unregister<ChatDataSource>();
  }
}

// ─────────────────────────────────────────────────────
// Provider — Conversations list
// ─────────────────────────────────────────────────────

void initProviderChat({bool forceRefresh = false}) {
  _initChatDeps();
  if (forceRefresh && Get.isRegistered<ConversationsController>()) {
    Get.delete<ConversationsController>(force: true);
  }
  if (!Get.isRegistered<ConversationsController>()) {
    Get.put(ConversationsController(
      instance<GetConversationsUseCase>(),
    ));
  }
}

void disposeProviderChat() {
  Get.delete<ConversationsController>();
  _disposeChatDeps();
}

// ─────────────────────────────────────────────────────
// Provider — Chat detail
// ─────────────────────────────────────────────────────

void initProviderChatDetail({
  required String conversationId,
  required String userName,
  String? avatarUrl,
  bool isOnline = false,
}) {
  _initChatDeps();
  // Dispose stale controller from a previous conversation if any
  if (Get.isRegistered<ChatDetailController>()) {
    Get.delete<ChatDetailController>(force: true);
  }
  final repo = instance<ChatRepository>();
  Get.put(ChatDetailController(
    getMessagesUseCase: instance<GetMessagesUseCase>(),
    sendMessageUseCase: instance<SendMessageUseCase>(),
    createChatOfferUseCase: CreateChatOfferUseCase(repo),
    updateChatOfferUseCase: UpdateChatOfferUseCase(repo),
    cancelChatOfferUseCase: CancelChatOfferUseCase(repo),
    chatSocketService: instance<ChatSocketService>(),
    appSettingsPrefs: instance<AppSettingsPrefs>(),
    conversationId: conversationId,
    userName: userName,
    avatarUrl: avatarUrl,
    isOnline: isOnline,
  ));
}

void disposeProviderChatDetail() {
  Get.delete<ChatDetailController>();
}

// ─────────────────────────────────────────────────────
// User — Conversations list
// ─────────────────────────────────────────────────────

void initUserChat({bool forceRefresh = false}) {
  _initChatDeps();
  if (forceRefresh && Get.isRegistered<UserConversationsController>()) {
    Get.delete<UserConversationsController>(force: true);
  }
  if (!Get.isRegistered<UserConversationsController>()) {
    Get.put(UserConversationsController(
      instance<GetConversationsUseCase>(),
    ));
  }
}

void disposeUserChat() {
  Get.delete<UserConversationsController>();
  _disposeChatDeps();
}

// ─────────────────────────────────────────────────────
// User — Chat detail
// ─────────────────────────────────────────────────────

void initUserChatDetail({
  required String conversationId,
  required String userName,
  String? avatarUrl,
  bool isOnline = false,
}) {
  _initChatDeps();
  // Dispose stale controller from a previous conversation if any
  if (Get.isRegistered<UserChatDetailController>()) {
    Get.delete<UserChatDetailController>(force: true);
  }
  Get.put(UserChatDetailController(
    getMessagesUseCase: instance<GetMessagesUseCase>(),
    sendMessageUseCase: instance<SendMessageUseCase>(),
    chatSocketService: instance<ChatSocketService>(),
    appSettingsPrefs: instance<AppSettingsPrefs>(),
    conversationId: conversationId,
    userName: userName,
    avatarUrl: avatarUrl,
    isOnline: isOnline,
  ));
}

void disposeUserChatDetail() {
  Get.delete<UserChatDetailController>();
}
