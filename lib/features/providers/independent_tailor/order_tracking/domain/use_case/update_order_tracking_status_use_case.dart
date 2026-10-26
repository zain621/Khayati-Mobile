import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/order_tracking_repository.dart';
import '../../data/request/update_order_status_request.dart';

class UpdateOrderTrackingStatusUseCase
    implements BaseUseCase<UpdateOrderStatusRequest, bool> {
  final OrderTrackingRepository _repository;

  UpdateOrderTrackingStatusUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute(UpdateOrderStatusRequest request) async {
    return await _repository.updateOrderStatus(request);
  }
}
