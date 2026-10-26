import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/create_order_data_source.dart';
import '../mapper/create_order_mapper.dart';
import '../request/create_order_request.dart';
import '../../domain/model/create_order_model.dart';

abstract class CreateOrderRepository {
  Future<Either<Failure, CreateOrderModel>> createOrder(
    CreateOrderRequest request,
  );
}

class CreateOrderRepositoryImplement implements CreateOrderRepository {
  final CreateOrderDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  CreateOrderRepositoryImplement(
    this._networkInfo,
    this.remoteDataSource,
  );

  @override
  Future<Either<Failure, CreateOrderModel>> createOrder(
    CreateOrderRequest request,
  ) async {
    try {
      final response = await remoteDataSource.createOrder(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
