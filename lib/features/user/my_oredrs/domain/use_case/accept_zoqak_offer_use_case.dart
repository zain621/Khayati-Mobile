import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../cart/domain/model/checkout_model.dart';
import '../../data/repository/my_orders_repository.dart';

class AcceptZoqakOfferUseCase {
  final MyOrdersRepository _repository;

  AcceptZoqakOfferUseCase(this._repository);

  Future<Either<Failure, CheckoutPaymentModel?>> execute(
          {required String orderId, required String offerId}) =>
      _repository.acceptZoqakOffer(orderId, offerId);
}
