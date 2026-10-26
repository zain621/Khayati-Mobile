import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/delete_account_data_source.dart';

abstract class DeleteAccountRepository {
  Future<Either<Failure, bool>> deleteAccount();
}

class DeleteAccountRepositoryImpl implements DeleteAccountRepository {
  final DeleteAccountDataSource _dataSource;

  DeleteAccountRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, bool>> deleteAccount() async {
    try {
      await _dataSource.deleteAccount();
      return const Right(true);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
