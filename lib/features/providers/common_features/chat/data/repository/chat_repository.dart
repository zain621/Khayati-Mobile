import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../data_source/chat_data_source.dart';
import '../mapper/conversations_mapper.dart';
import '../mapper/create_conversation_mapper.dart';
import '../mapper/messages_mapper.dart';
import '../request/create_conversation_request.dart';
import '../../domain/model/conversation_model.dart';
import '../../domain/model/message_model.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ConversationModel>>> getConversations();
  Future<Either<Failure, ConversationModel>> createOrGetConversation(
      CreateConversationRequest request);
  Future<Either<Failure, List<MessageModel>>> getMessages(String conversationId);
  Future<Either<Failure, MessageModel>> sendMessage(
      String conversationId, String content, List<String> filePaths);
  Future<Either<Failure, void>> createChatOffer(
      String conversationId, Map<String, dynamic> body);
  Future<Either<Failure, void>> updateChatOffer(
      String conversationId, String offerId, Map<String, dynamic> body);
  Future<Either<Failure, void>> cancelChatOffer(
      String conversationId, String offerId);
}

class ChatRepositoryImplement implements ChatRepository {
  final ChatDataSource _remoteDataSource;
  final AppSettingsPrefs _appSettingsPrefs;

  ChatRepositoryImplement(this._remoteDataSource, this._appSettingsPrefs);

  @override
  Future<Either<Failure, List<ConversationModel>>> getConversations() async {
    try {
      final response = await _remoteDataSource.getConversations();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ConversationModel>> createOrGetConversation(
      CreateConversationRequest request) async {
    try {
      final response =
          await _remoteDataSource.createOrGetConversation(request);
      final currentUserId = _appSettingsPrefs.getUserId();
      return Right(response.toDomain(currentUserId));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessages(
      String conversationId) async {
    try {
      final response = await _remoteDataSource.getMessages(conversationId);
      final currentUserId = _appSettingsPrefs.getUserId();
      return Right(response.toDomain(currentUserId));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, MessageModel>> sendMessage(
      String conversationId, String content, List<String> filePaths) async {
    try {
      final response = await _remoteDataSource.sendMessage(
          conversationId, content, filePaths);
      final data = response.data;
      final currentUserId = _appSettingsPrefs.getUserId();
      return Right(MessageModel(
        id: data?.id ?? '',
        conversationId: data?.conversationId ?? '',
        senderId: data?.senderId ?? '',
        senderType: 'message',
        content: data?.content ?? '',
        createdAt: data?.createdAt ?? DateTime.now().toIso8601String(),
        isMe: data?.senderId == currentUserId,
        attachments: (data?.attachments ?? [])
            .map((a) => MessageAttachmentModel(
                  id: a.id ?? '',
                  url: a.url ?? '',
                  kind: a.kind ?? 'image',
                  mimeType: a.mimeType,
                  originalName: a.originalName,
                  sizeBytes: a.sizeBytes,
                ))
            .toList(),
      ));
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> createChatOffer(
      String conversationId, Map<String, dynamic> body) async {
    try {
      await _remoteDataSource.createChatOffer(conversationId, body);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateChatOffer(
      String conversationId, String offerId, Map<String, dynamic> body) async {
    try {
      await _remoteDataSource.updateChatOffer(conversationId, offerId, body);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> cancelChatOffer(
      String conversationId, String offerId) async {
    try {
      await _remoteDataSource.cancelChatOffer(conversationId, offerId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
