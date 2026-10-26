import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';
import '../../data/request/update_comprehensive_order_stage_request.dart';

class UpdateComprehensiveOrderStageUseCase
    implements BaseUseCase<UpdateComprehensiveOrderStageRequest, bool> {
  final ComprehensiveOrderTrackingRepository _repository;

  UpdateComprehensiveOrderStageUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(
      UpdateComprehensiveOrderStageRequest request) {
    return _repository.updateOrderStage(request);
  }
}
