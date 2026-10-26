import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/complete_login_with_code_repository.dart';
import '../../data/request/complete_login_with_code_request.dart';
import '../model/login_model.dart';

class CompleteLoginWithCodeUseCase
    implements BaseUseCase<CompleteLoginWithCodeRequest, LoginModel> {
  final CompleteLoginWithCodeRepository _repository;

  CompleteLoginWithCodeUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(
      CompleteLoginWithCodeRequest request) async {
    return await _repository.completeLoginWithCode(request);
  }
}
