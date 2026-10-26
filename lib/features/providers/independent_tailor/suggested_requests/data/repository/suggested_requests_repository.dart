import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/suggested_requests_data_source.dart';
import '../mapper/get_orders_mapper.dart';
import '../../domain/model/suggested_order_model.dart';

abstract class SuggestedRequestsRepository {
  Future<Either<Failure, List<SuggestedOrderModel>>> fetchOrders();
  Future<Either<Failure, Unit>> submitOffer({
    required String orderId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  });
}

class SuggestedRequestsRepositoryImplement
    implements SuggestedRequestsRepository {
  final SuggestedRequestsDataSource _remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  SuggestedRequestsRepositoryImplement(
      this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, List<SuggestedOrderModel>>> fetchOrders() async {
    try {
      final response = await _remoteDataSource.fetchOrders();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> submitOffer({
    required String orderId,
    required double proposedPrice,
    required int executionDays,
    required String details,
  }) async {
    try {
      await _remoteDataSource.submitOffer(
        orderId: orderId,
        proposedPrice: proposedPrice,
        executionDays: executionDays,
        details: details,
      );
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
