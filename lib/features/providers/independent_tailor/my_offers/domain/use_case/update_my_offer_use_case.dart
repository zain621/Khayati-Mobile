import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/my_offers_repository.dart';
import '../../data/request/update_my_offer_request.dart';
import '../model/my_offer_model.dart';

class UpdateMyOfferUseCase implements BaseUseCase<UpdateMyOfferRequest, MyOfferModel> {
  final MyOffersRepository _repository;

  UpdateMyOfferUseCase(this._repository);

  @override
  Future<Either<Failure, MyOfferModel>> execute(UpdateMyOfferRequest request) async {
    return await _repository.updateMyOffer(request);
  }
}
