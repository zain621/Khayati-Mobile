import 'package:dartz/dartz.dart';
import '../../../../../../core/error_handler/error_handler.dart';
import '../../../../../../core/error_handler/failure.dart';
import '../data_source/comprehensive_order_tracking_data_source.dart';
import '../mapper/comprehensive_order_tracking_mapper.dart';
import '../request/update_comprehensive_order_stage_request.dart';
import '../../domain/model/comprehensive_order_tracking_model.dart';

abstract class ComprehensiveOrderTrackingRepository {
  Future<Either<Failure, ComprehensiveOrdersModel>> getOrders();
  Future<Either<Failure, ComprehensiveOrderDetailModel>> getOrderDetail(
      String orderId);
  Future<Either<Failure, bool>> updateOrderStage(
      UpdateComprehensiveOrderStageRequest request);
  Future<Either<Failure, bool>> updateZoqakOrderStatus(
      String orderId, String status);
  Future<Either<Failure, ZoqakOfferDetailModel>> getZoqakMyOfferByOrderId(
      String orderId);
}

class ComprehensiveOrderTrackingRepositoryImpl
    implements ComprehensiveOrderTrackingRepository {
  final ComprehensiveOrderTrackingDataSource _dataSource;

  ComprehensiveOrderTrackingRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, ComprehensiveOrdersModel>> getOrders() async {
    try {
      final response = await _dataSource.getOrders();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ComprehensiveOrderDetailModel>> getOrderDetail(
      String orderId) async {
    try {
      final response = await _dataSource.getOrderDetail(orderId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateOrderStage(
      UpdateComprehensiveOrderStageRequest request) async {
    try {
      await _dataSource.updateOrderStage(request);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> updateZoqakOrderStatus(
      String orderId, String status) async {
    try {
      await _dataSource.updateZoqakOrderStatus(orderId, status);
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ZoqakOfferDetailModel>> getZoqakMyOfferByOrderId(
      String orderId) async {
    try {
      final response = await _dataSource.getZoqakMyOfferByOrderId(orderId);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
