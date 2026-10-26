import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/suggested_requests_repository.dart';
import '../model/suggested_order_model.dart';

class GetOrdersUseCase implements BaseGetUseCase<List<SuggestedOrderModel>> {
  final SuggestedRequestsRepository _repository;

  GetOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, List<SuggestedOrderModel>>> execute() async {
    return await _repository.fetchOrders();
  }
}
