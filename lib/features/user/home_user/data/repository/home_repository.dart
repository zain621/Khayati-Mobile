import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/home_data_source.dart';
import '../mapper/home_mapper.dart';
import '../../domain/model/home_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeModel>> getHome();
  Future<Either<Failure, NearbyTailorsResultModel>> getNearbyTailors({
    required double latitude,
    required double longitude,
    int limit,
  });
}

class HomeRepositoryImplement implements HomeRepository {
  final HomeDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  HomeRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, HomeModel>> getHome() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getHome();
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, NearbyTailorsResultModel>> getNearbyTailors({
    required double latitude,
    required double longitude,
    int limit = 5,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getNearbyTailors(
          latitude,
          longitude,
          limit,
        );
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
