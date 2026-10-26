import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../../data/repository/update_provider_profile_repository.dart';

class UpdateShopProfileUseCase {
  final UpdateProviderProfileRepository _repository;

  UpdateShopProfileUseCase(this._repository);

  Future<Either<Failure, void>> execute({
    required String nameAr,
    required String nameEn,
    String? bio,
    File? image,
    File? coverImage,
  }) async {
    return await _repository.updateShopProfile(
      nameAr: nameAr,
      nameEn: nameEn,
      bio: bio,
      image: image,
      coverImage: coverImage,
    );
  }
}
