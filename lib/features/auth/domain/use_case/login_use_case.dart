import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/login_repository.dart';
import '../../data/request/login_request.dart';
import '../model/login_model.dart';

class LoginUseCase implements BaseUseCase<LoginRequest, LoginModel> {
  final LoginRepository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(LoginRequest request) async {
    return await _repository.login(request);
  }
}
