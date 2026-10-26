import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/chat_repository.dart';
import '../model/conversation_model.dart';

/// Fetches all conversations for the current user.
class GetConversationsUseCase
    implements BaseGetUseCase<List<ConversationModel>> {
  final ChatRepository _repository;

  GetConversationsUseCase(this._repository);

  @override
  Future<Either<Failure, List<ConversationModel>>> execute() {
    return _repository.getConversations();
  }
}
