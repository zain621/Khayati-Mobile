import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/change_password_data_source.dart';
import '../request/change_password_request.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, String>> changePassword(
      ChangePasswordRequest request);
}

class ChangePasswordRepositoryImplement implements ChangePasswordRepository {
  final ChangePasswordDataSource _dataSource;
  ChangePasswordRepositoryImplement(this._dataSource);

  @override
  Future<Either<Failure, String>> changePassword(
      ChangePasswordRequest request) async {
    try {
      final response = await _dataSource.changePassword(request);
      return Right(response.message ?? '');
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
