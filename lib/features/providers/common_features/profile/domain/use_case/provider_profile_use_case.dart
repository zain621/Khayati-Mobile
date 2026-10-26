import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/provider_profile_repository.dart';
import '../model/provider_profile_model.dart';

class ProviderProfileUseCase implements BaseGetUseCase<ProviderProfileModel> {
  final ProviderProfileRepository _repository;

  ProviderProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ProviderProfileModel>> execute() async {
    return await _repository.fetchProfile();
  }
}
