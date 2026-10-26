import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/error_handler.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../data_source/shop_owner_orders_data_source.dart';
import '../mapper/shop_owner_orders_mapper.dart';
import '../request/update_order_stage_request.dart';
import '../../domain/model/shop_owner_order_model.dart';

abstract class ShopOwnerOrdersRepository {
  Future<Either<Failure, List<ShopOwnerOrderModel>>> getOrders();
  Future<Either<Failure, bool>> updateOrderStage(
      UpdateOrderStageRequest request);
}

class ShopOwnerOrdersRepositoryImpl implements ShopOwnerOrdersRepository {
  final ShopOwnerOrdersDataSource _dataSource;

  ShopOwnerOrdersRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ShopOwnerOrderModel>>> getOrders() async {
    try {
      final response = await _dataSource.getOrders();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrderStage(
      UpdateOrderStageRequest request) async {
    try {
      await _dataSource.updateOrderStage(request);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
