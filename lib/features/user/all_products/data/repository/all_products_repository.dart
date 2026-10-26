import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/error_handler/type_handler_enum.dart';
import 'package:app_mobile/core/error_handler/data_source_extension.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/all_products_data_source.dart';
import '../mapper/all_products_mapper.dart';
import '../../domain/model/product_list_item_model.dart';

abstract class AllProductsRepository {
  Future<Either<Failure, ProductsListModel>> getProducts({
    required int page,
    required int perPage,
    String? shopSearch,
  });
}

class AllProductsRepositoryImplement implements AllProductsRepository {
  final AllProductsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  AllProductsRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, ProductsListModel>> getProducts({
    required int page,
    required int perPage,
    String? shopSearch,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getProducts(
          page: page,
          perPage: perPage,
          shopSearch: shopSearch,
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
