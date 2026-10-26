import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/shops_data_source.dart';
import '../mapper/shops_mapper.dart';
import '../../domain/model/shop_model.dart';

abstract class ShopsRepository {
  Future<Either<Failure, ShopsListModel>> getShops();
  Future<Either<Failure, TopShopsListModel>> getTopShops();
}

class ShopsRepositoryImplement implements ShopsRepository {
  final ShopsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ShopsRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ShopsListModel>> getShops() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getShops();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, TopShopsListModel>> getTopShops() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getTopShops();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
