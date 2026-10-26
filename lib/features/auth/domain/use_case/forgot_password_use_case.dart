import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/forgot_password_repository.dart';
import '../model/forgot_password_model.dart';

class ForgotPasswordUseCase implements BaseUseCase<String, ForgotPasswordModel> {
  final ForgotPasswordRepository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPasswordModel>> execute(String request) async {
    return await _repository.forgotPassword(request);
  }
}
