import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/provider_register_data_source.dart';
import '../mapper/get_categories_mapper.dart';
import '../mapper/provider_register_mapper.dart';
import '../request/provider_register_request.dart';
import '../../domain/model/category_model.dart';
import '../../domain/model/provider_register_model.dart';

abstract class ProviderRegisterRepository {
  Future<Either<Failure, ProviderRegisterModel>> providerRegister(
      ProviderRegisterRequest request);
  Future<Either<Failure, GetCategoriesModel>> getCategories();
}

class ProviderRegisterRepositoryImplement
    implements ProviderRegisterRepository {
  final ProviderRegisterDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  ProviderRegisterRepositoryImplement(
      this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, ProviderRegisterModel>> providerRegister(
      ProviderRegisterRequest request) async {
    try {
      final response = await remoteDataSource.providerRegister(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, GetCategoriesModel>> getCategories() async {
    try {
      final response = await remoteDataSource.getCategories();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
