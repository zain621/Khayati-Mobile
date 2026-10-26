import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/order_tracking_repository.dart';
import '../model/order_tracking_model.dart';

class GetOrderTrackingUseCase implements BaseGetUseCase<OrderTrackingDataModel> {
  final OrderTrackingRepository _repository;

  GetOrderTrackingUseCase(this._repository);

  @override
  Future<Either<Failure, OrderTrackingDataModel>> execute() async {
    return await _repository.fetchMyAcceptedOrders();
  }
}
