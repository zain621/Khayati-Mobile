import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/user_profile_repository.dart';
import '../../data/request/update_user_profile_request.dart';
import '../model/update_user_profile_model.dart';

class UpdateUserProfileUseCase
    implements BaseUseCase<UpdateUserProfileRequest, UpdateUserProfileModel> {
  final UserProfileRepository _repository;

  UpdateUserProfileUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateUserProfileModel>> execute(
    UpdateUserProfileRequest input,
  ) async {
    return await _repository.updateProfile(input);
  }
}
