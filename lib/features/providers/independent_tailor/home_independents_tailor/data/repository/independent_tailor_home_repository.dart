import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../data_source/independent_tailor_home_data_source.dart';
import '../mapper/independent_tailor_home_mapper.dart';
import '../../domain/model/independent_tailor_home_model.dart';

abstract class IndependentTailorHomeRepository {
  Future<Either<Failure, IndependentTailorHomeModel>> fetchHome();
  Future<Either<Failure, bool>> changeAvailability(bool isAcceptingOrders);
}

class IndependentTailorHomeRepositoryImplement
    implements IndependentTailorHomeRepository {
  final IndependentTailorHomeDataSource _dataSource;
  final AppSettingsPrefs _prefs;

  IndependentTailorHomeRepositoryImplement(this._dataSource, this._prefs);

  @override
  Future<Either<Failure, IndependentTailorHomeModel>> fetchHome() async {
    try {
      final data = await _dataSource.fetchHome();
      final model = data.toDomain(
        fullName: _prefs.getUserFullName(),
        imageUrl: _prefs.getUserImage(),
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
