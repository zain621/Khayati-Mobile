import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/data_source_extension.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/error_handler/type_handler_enum.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../data_source/shop_details_data_source.dart';
import '../mapper/shop_details_mapper.dart';
import '../../domain/model/shop_details_model.dart';

abstract class ShopDetailsRepository {
  Future<Either<Failure, ShopDetailsModel>> getShopDetails(String shopId);
}

class ShopDetailsRepositoryImplement implements ShopDetailsRepository {
  final ShopDetailsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ShopDetailsRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ShopDetailsModel>> getShopDetails(String shopId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getShopDetails(shopId);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
