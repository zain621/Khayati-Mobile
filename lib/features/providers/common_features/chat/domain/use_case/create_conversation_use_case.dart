import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/chat_repository.dart';
import '../../data/request/create_conversation_request.dart';
import '../model/conversation_model.dart';

/// Creates or gets an existing conversation between a tailor and a user.
class CreateConversationUseCase
    implements BaseUseCase<CreateConversationRequest, ConversationModel> {
  final ChatRepository _repository;

  CreateConversationUseCase(this._repository);

  @override
  Future<Either<Failure, ConversationModel>> execute(
      CreateConversationRequest request) {
    return _repository.createOrGetConversation(request);
  }
}
