import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../../../../../../core/usecase/base_usecase.dart';
import '../../data/repository/shop_owner_orders_repository.dart';
import '../model/shop_owner_order_model.dart';

class GetShopOwnerOrdersUseCase
    implements BaseGetUseCase<List<ShopOwnerOrderModel>> {
  final ShopOwnerOrdersRepository _repository;

  GetShopOwnerOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, List<ShopOwnerOrderModel>>> execute() {
    return _repository.getOrders();
  }
}
