import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/order_tracking_repository.dart';
import '../model/order_tracking_model.dart';

class GetOrderTrackingDetailUseCase
    implements BaseUseCase<String, OrderTrackingDetailModel> {
  final OrderTrackingRepository _repository;

  GetOrderTrackingDetailUseCase(this._repository);

  @override
  Future<Either<Failure, OrderTrackingDetailModel>> execute(String request) async {
    return await _repository.fetchOrderDetail(request);
  }
}
