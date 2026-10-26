import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/chat_repository.dart';

class CancelChatOfferParams {
  final String conversationId;
  final String offerId;

  const CancelChatOfferParams({
    required this.conversationId,
    required this.offerId,
  });
}

class CancelChatOfferUseCase {
  final ChatRepository _repository;

  CancelChatOfferUseCase(this._repository);

  Future<Either<Failure, void>> execute(CancelChatOfferParams params) {
    return _repository.cancelChatOffer(params.conversationId, params.offerId);
  }
}
