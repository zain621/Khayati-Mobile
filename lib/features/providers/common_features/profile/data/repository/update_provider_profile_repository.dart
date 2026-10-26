import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/update_provider_profile_data_source.dart';

abstract class UpdateProviderProfileRepository {
  Future<Either<Failure, void>> updateTailorProfile({
    required String fullName,
    String? bio,
    File? image,
  });

  Future<Either<Failure, void>> updateShopProfile({
    required String nameAr,
    required String nameEn,
    String? bio,
    File? image,
    File? coverImage,
  });
}

class UpdateProviderProfileRepositoryImplement
    implements UpdateProviderProfileRepository {
  final UpdateProviderProfileDataSource _dataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  UpdateProviderProfileRepositoryImplement(
      this._networkInfo, this._dataSource);

  @override
  Future<Either<Failure, void>> updateTailorProfile({
    required String fullName,
    String? bio,
    File? image,
  }) async {
    try {
      await _dataSource.updateTailorProfile(
        fullName: fullName,
        bio: bio,
        image: image,
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> updateShopProfile({
    required String nameAr,
    required String nameEn,
    String? bio,
    File? image,
    File? coverImage,
  }) async {
    try {
      await _dataSource.updateShopProfile(
        nameAr: nameAr,
        nameEn: nameEn,
        bio: bio,
        image: image,
        coverImage: coverImage,
      );
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
