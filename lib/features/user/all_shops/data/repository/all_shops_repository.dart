import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/features/user/shops/data/mapper/shops_mapper.dart';
import 'package:app_mobile/features/user/shops/domain/model/shop_model.dart';
import '../data_source/all_shops_data_source.dart';

abstract class AllShopsRepository {
  Future<Either<Failure, ShopsListModel>> getShops({
    required int page,
    required int perPage,
    String? search,
    String? orderBy,
  });
}

class AllShopsRepositoryImplement implements AllShopsRepository {
  final AllShopsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  AllShopsRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ShopsListModel>> getShops({
    required int page,
    required int perPage,
    String? search,
    String? orderBy,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getShops(
          page: page,
          perPage: perPage,
          search: search,
          orderBy: orderBy,
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
