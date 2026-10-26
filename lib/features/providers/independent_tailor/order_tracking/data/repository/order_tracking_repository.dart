import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../domain/model/order_tracking_model.dart';
import '../data_source/order_tracking_data_source.dart';
import '../mapper/order_tracking_mapper.dart';
import '../request/update_order_status_request.dart';

abstract class OrderTrackingRepository {
  Future<Either<Failure, OrderTrackingDataModel>> fetchMyAcceptedOrders();
  Future<Either<Failure, OrderTrackingDetailModel>> fetchOrderDetail(String orderId);
  Future<Either<Failure, bool>> updateOrderStatus(UpdateOrderStatusRequest request);
}

class OrderTrackingRepositoryImplement implements OrderTrackingRepository {
  final OrderTrackingDataSource _remoteDataSource;

  OrderTrackingRepositoryImplement(this._remoteDataSource);

  @override
  Future<Either<Failure, OrderTrackingDataModel>> fetchMyAcceptedOrders() async {
    try {
      final response = await _remoteDataSource.fetchMyAcceptedOrders();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, OrderTrackingDetailModel>> fetchOrderDetail(String orderId) async {
    try {
      final response = await _remoteDataSource.fetchOrderDetail(orderId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrderStatus(UpdateOrderStatusRequest request) async {
    try {
      await _remoteDataSource.updateOrderStatus(request);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
