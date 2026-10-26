import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../data/repository/my_orders_repository.dart';
import '../model/user_order_domain_model.dart';

/// Fetches full order details for a single order.
/// Endpoint: GET /user/orders/:orderId
class GetOrderDetailUseCase {
  final MyOrdersRepository _repository;

  GetOrderDetailUseCase(this._repository);

  Future<Either<Failure, UserOrderDomainModel>> execute(String orderId) =>
      _repository.getOrderDetail(orderId);
}
