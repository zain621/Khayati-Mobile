import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/comprehensive_home_data_source.dart';
import '../mapper/comprehensive_home_mapper.dart';
import '../../domain/model/comprehensive_home_model.dart';

abstract class ComprehensiveHomeRepository {
  Future<Either<Failure, ComprehensiveHomeModel>> fetchHome();
  Future<Either<Failure, bool>> changeAvailability(bool isAcceptingOrders);
}

class ComprehensiveHomeRepositoryImplement implements ComprehensiveHomeRepository {
  final ComprehensiveHomeDataSource _dataSource;

  ComprehensiveHomeRepositoryImplement(this._dataSource);

  @override
  Future<Either<Failure, ComprehensiveHomeModel>> fetchHome() async {
    try {
      final data = await _dataSource.fetchHome();
      final model = data.dashboard!.toDomain(
        fullName: data.profile?.fullName,
        imageUrl: data.profile?.image,
      );
      return Right(model);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, bool>> changeAvailability(
      bool isAcceptingOrders) async {
    try {
      final data = await _dataSource.changeAvailability(isAcceptingOrders);
      return Right(data.isAcceptingOrders ?? isAcceptingOrders);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
