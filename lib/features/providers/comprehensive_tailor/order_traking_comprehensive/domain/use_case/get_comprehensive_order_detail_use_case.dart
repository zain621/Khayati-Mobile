import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';
import '../model/comprehensive_order_tracking_model.dart';

class GetComprehensiveOrderDetailUseCase
    implements BaseUseCase<String, ComprehensiveOrderDetailModel> {
  final ComprehensiveOrderTrackingRepository _repository;

  GetComprehensiveOrderDetailUseCase(this._repository);

  @override
  Future<Either<Failure, ComprehensiveOrderDetailModel>> execute(
      String orderId) {
    return _repository.getOrderDetail(orderId);
  }
}
