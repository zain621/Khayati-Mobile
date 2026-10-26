import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../data/repository/my_orders_repository.dart';
import '../model/user_order_domain_model.dart';

class GetUserOrdersUseCase {
  final MyOrdersRepository _repository;

  GetUserOrdersUseCase(this._repository);

  Future<Either<Failure, List<UserOrderDomainModel>>> execute() =>
      _repository.getUserOrders();
}
