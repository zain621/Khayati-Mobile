import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/chat_repository.dart';
import '../model/message_model.dart';

/// Fetches messages for a given conversationId.
class GetMessagesUseCase implements BaseUseCase<String, List<MessageModel>> {
  final ChatRepository _repository;

  GetMessagesUseCase(this._repository);

  @override
  Future<Either<Failure, List<MessageModel>>> execute(
      String conversationId) {
    return _repository.getMessages(conversationId);
  }
}
