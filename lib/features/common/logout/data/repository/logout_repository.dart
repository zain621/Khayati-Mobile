import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/logout_data_source.dart';

abstract class LogoutRepository {
  Future<Either<Failure, bool>> logout();
}

class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutDataSource _dataSource;

  LogoutRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await _dataSource.logout();
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
