import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';
import '../model/comprehensive_order_tracking_model.dart';

class GetZoqakMyOfferByOrderUseCase {
  final ComprehensiveOrderTrackingRepository _repository;

  GetZoqakMyOfferByOrderUseCase(this._repository);

  Future<Either<Failure, ZoqakOfferDetailModel>> execute(String orderId) {
    return _repository.getZoqakMyOfferByOrderId(orderId);
  }
}
