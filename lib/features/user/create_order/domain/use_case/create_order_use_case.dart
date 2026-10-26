import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/create_order_repository.dart';
import '../../data/request/create_order_request.dart';
import '../model/create_order_model.dart';

class CreateOrderUseCase
    implements BaseUseCase<CreateOrderRequest, CreateOrderModel> {
  final CreateOrderRepository _repository;

  CreateOrderUseCase(this._repository);

  @override
  Future<Either<Failure, CreateOrderModel>> execute(
    CreateOrderRequest input,
  ) async {
    return await _repository.createOrder(input);
  }
}
