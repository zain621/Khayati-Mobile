import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/request/change_password_request.dart';
import '../../data/repository/change_password_repository.dart';

class ChangePasswordUseCase
    extends BaseUseCase<ChangePasswordRequest, String> {
  final ChangePasswordRepository _repository;
  ChangePasswordUseCase(this._repository);

  @override
  Future<Either<Failure, String>> execute(
      ChangePasswordRequest request) async {
    return await _repository.changePassword(request);
  }
}
