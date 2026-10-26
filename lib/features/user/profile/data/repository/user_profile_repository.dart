import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/user_profile_data_source.dart';
import '../mapper/update_user_profile_mapper.dart';
import '../mapper/user_profile_mapper.dart';
import '../request/update_user_profile_request.dart';
import '../../domain/model/update_user_profile_model.dart';
import '../../domain/model/user_profile_model.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfileModel>> fetchProfile();
  Future<Either<Failure, UpdateUserProfileModel>> updateProfile(
    UpdateUserProfileRequest request,
  );
}

class UserProfileRepositoryImplement implements UserProfileRepository {
  final UserProfileDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  UserProfileRepositoryImplement(this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, UserProfileModel>> fetchProfile() async {
    try {
      final response = await remoteDataSource.fetchProfile();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, UpdateUserProfileModel>> updateProfile(
    UpdateUserProfileRequest request,
  ) async {
    try {
      final response = await remoteDataSource.updateProfile(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
