import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/provider_register_repository.dart';
import '../../data/request/provider_register_request.dart';
import '../model/provider_register_model.dart';

class ProviderRegisterUseCase
    implements BaseUseCase<ProviderRegisterRequest, ProviderRegisterModel> {
  final ProviderRegisterRepository _repository;

  ProviderRegisterUseCase(this._repository);

  @override
  Future<Either<Failure, ProviderRegisterModel>> execute(
      ProviderRegisterRequest request) async {
    return await _repository.providerRegister(request);
  }
}
