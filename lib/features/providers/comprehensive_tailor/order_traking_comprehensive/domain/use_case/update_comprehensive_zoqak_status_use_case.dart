import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';

class UpdateComprehensiveZoqakStatusUseCase {
  final ComprehensiveOrderTrackingRepository _repository;

  UpdateComprehensiveZoqakStatusUseCase(this._repository);

  Future<Either<Failure, bool>> execute(String orderId, String status) {
    return _repository.updateZoqakOrderStatus(orderId, status);
  }
}
