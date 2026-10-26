import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/forgot_password_repository.dart';

class ResetPasswordUseCaseInput {
  final String userId;
  final String newPassword;

  const ResetPasswordUseCaseInput({
    required this.userId,
    required this.newPassword,
  });
}

class ResetPasswordUseCase
    implements BaseUseCase<ResetPasswordUseCaseInput, Unit> {
  final ForgotPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(
      ResetPasswordUseCaseInput request) async {
    return await _repository.resetPassword(request.userId, request.newPassword);
  }
}
