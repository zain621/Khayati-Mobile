import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/provider_profile_data_source.dart';
import '../../domain/model/provider_profile_model.dart';

abstract class ProviderProfileRepository {
  Future<Either<Failure, ProviderProfileModel>> fetchProfile();
}

class ProviderProfileRepositoryImplement implements ProviderProfileRepository {
  final ProviderProfileDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  ProviderProfileRepositoryImplement(this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, ProviderProfileModel>> fetchProfile() async {
    try {
      final model = await remoteDataSource.fetchProfile();
      return Right(model);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
