import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/update_provider_profile_repository.dart';

class UpdateTailorProfileUseCase {
  final UpdateProviderProfileRepository _repository;

  UpdateTailorProfileUseCase(this._repository);

  Future<Either<Failure, void>> execute({
    required String fullName,
    String? bio,
    File? image,
  }) async {
    return await _repository.updateTailorProfile(
      fullName: fullName,
      bio: bio,
      image: image,
    );
  }
}
