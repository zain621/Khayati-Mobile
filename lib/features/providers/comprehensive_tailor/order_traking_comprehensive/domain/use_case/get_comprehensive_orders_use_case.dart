import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';
import '../model/comprehensive_order_tracking_model.dart';

class GetComprehensiveOrdersUseCase
    implements BaseGetUseCase<ComprehensiveOrdersModel> {
  final ComprehensiveOrderTrackingRepository _repository;

  GetComprehensiveOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, ComprehensiveOrdersModel>> execute() {
    return _repository.getOrders();
  }
}
