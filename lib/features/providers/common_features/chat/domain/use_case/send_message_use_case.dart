import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/chat_repository.dart';
import '../model/message_model.dart';

class SendMessageParams {
  final String conversationId;
  final String content;
  final List<String> filePaths;

  SendMessageParams({
    required this.conversationId,
    required this.content,
    required this.filePaths,
  });
}

class SendMessageUseCase {
  final ChatRepository _repository;

  SendMessageUseCase(this._repository);

  Future<Either<Failure, MessageModel>> execute(SendMessageParams params) {
    return _repository.sendMessage(
      params.conversationId,
      params.content,
      params.filePaths,
    );
  }
}
