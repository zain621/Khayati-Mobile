import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/user_profile_repository.dart';
import '../model/user_profile_model.dart';

class UserProfileUseCase implements BaseGetUseCase<UserProfileModel> {
  final UserProfileRepository _repository;

  UserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UserProfileModel>> execute() async {
    return await _repository.fetchProfile();
  }
}
