import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/logout_repository.dart';

class LogoutUseCase extends BaseGetUseCase<bool> {
  final LogoutRepository _repository;

  LogoutUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> execute() => _repository.logout();
}
