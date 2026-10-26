import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/my_offers_repository.dart';

class DeleteMyOfferUseCase implements BaseUseCase<String, bool> {
  final MyOffersRepository _repository;

  DeleteMyOfferUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(String offerId) async {
    return await _repository.deleteMyOffer(offerId);
  }
}
