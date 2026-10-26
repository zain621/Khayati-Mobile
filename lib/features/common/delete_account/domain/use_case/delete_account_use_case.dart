import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/delete_account_repository.dart';

class DeleteAccountUseCase extends BaseGetUseCase<bool> {
  final DeleteAccountRepository _repository;

  DeleteAccountUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute() => _repository.deleteAccount();
}
