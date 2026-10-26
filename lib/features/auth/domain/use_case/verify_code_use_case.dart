import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/forgot_password_repository.dart';

class VerifyCodeUseCaseInput {
  final String userId;
  final String code;

  const VerifyCodeUseCaseInput({required this.userId, required this.code});
}

class VerifyCodeUseCase implements BaseUseCase<VerifyCodeUseCaseInput, Unit> {
  final ForgotPasswordRepository _repository;

  VerifyCodeUseCase(this._repository);

  @override
  Future<Either<Failure, Unit>> execute(VerifyCodeUseCaseInput request) async {
    return await _repository.verifyCode(request.userId, request.code);
  }
}
