import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/shop_owner_home_data_source.dart';
import '../mapper/shop_owner_home_mapper.dart';
import '../../domain/model/shop_owner_home_model.dart';

abstract class ShopOwnerHomeRepository {
  Future<Either<Failure, ShopOwnerHomeModel>> fetchHome();
  Future<Either<Failure, bool>> changeAvailability(bool isOpen);
}

class ShopOwnerHomeRepositoryImplement implements ShopOwnerHomeRepository {
  final ShopOwnerHomeDataSource remoteDataSource;

  ShopOwnerHomeRepositoryImplement(this.remoteDataSource);

  @override
  Future<Either<Failure, ShopOwnerHomeModel>> fetchHome() async {
    try {
      final response = await remoteDataSource.fetchHome();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> changeAvailability(bool isOpen) async {
    try {
      final data = await remoteDataSource.changeAvailability(isOpen);
      return Right(data.isOpen ?? isOpen);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
