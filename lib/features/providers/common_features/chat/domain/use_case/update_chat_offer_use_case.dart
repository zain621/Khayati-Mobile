import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/chat_repository.dart';

class UpdateChatOfferParams {
  final String conversationId;
  final String offerId;
  final Map<String, dynamic> body;

  const UpdateChatOfferParams({
    required this.conversationId,
    required this.offerId,
    required this.body,
  });
}

class UpdateChatOfferUseCase {
  final ChatRepository _repository;

  UpdateChatOfferUseCase(this._repository);

  Future<Either<Failure, void>> execute(UpdateChatOfferParams params) {
    return _repository.updateChatOffer(
        params.conversationId, params.offerId, params.body);
  }
}
