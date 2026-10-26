import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/suggested_requests_repository.dart';

class SubmitOfferUseCaseInput {
  final String orderId;
  final double proposedPrice;
  final int executionDays;
  final String details;

  SubmitOfferUseCaseInput({
    required this.orderId,
    required this.proposedPrice,
    required this.executionDays,
    required this.details,
  });
}

class SubmitOfferUseCase implements BaseUseCase<SubmitOfferUseCaseInput, Unit> {
  final SuggestedRequestsRepository _repository;

  SubmitOfferUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(SubmitOfferUseCaseInput request) async {
    return await _repository.submitOffer(
      orderId: request.orderId,
      proposedPrice: request.proposedPrice,
      executionDays: request.executionDays,
      details: request.details,
    );
  }
}
