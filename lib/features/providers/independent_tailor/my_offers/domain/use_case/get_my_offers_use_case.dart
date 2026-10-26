import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/my_offers_repository.dart';
import '../model/my_offer_model.dart';

class GetMyOffersUseCase implements BaseGetUseCase<List<MyOfferModel>> {
  final MyOffersRepository _repository;

  GetMyOffersUseCase(this._repository);

  @override
  Future<Either<Failure, List<MyOfferModel>>> execute() async {
    return await _repository.fetchMyOffers();
  }
}
