import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/chat_repository.dart';

class CreateChatOfferParams {
  final String conversationId;
  final Map<String, dynamic> body;

  const CreateChatOfferParams({
    required this.conversationId,
    required this.body,
  });
}

class CreateChatOfferUseCase {
  final ChatRepository _repository;

  CreateChatOfferUseCase(this._repository);

  Future<Either<Failure, void>> execute(CreateChatOfferParams params) {
    return _repository.createChatOffer(params.conversationId, params.body);
  }
}
