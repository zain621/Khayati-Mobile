import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/product_details_data_source.dart';
import '../mapper/product_details_mapper.dart';
import '../../domain/model/product_details_model.dart';

abstract class ProductDetailsRepository {
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String productId);
}

class ProductDetailsRepositoryImplement implements ProductDetailsRepository {
  final ProductDetailsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  ProductDetailsRepositoryImplement(
      this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
      String productId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getProductDetails(productId);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
