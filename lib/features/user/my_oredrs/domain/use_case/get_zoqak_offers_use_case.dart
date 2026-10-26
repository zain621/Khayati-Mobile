import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../data/repository/my_orders_repository.dart';
import '../model/zoqak_offer_domain_model.dart';

class GetZoqakOffersUseCase {
  final MyOrdersRepository _repository;

  GetZoqakOffersUseCase(this._repository);

  Future<Either<Failure, List<ZoqakOfferDomainModel>>> execute(String orderId) =>
      _repository.getZoqakOffers(orderId);
}
