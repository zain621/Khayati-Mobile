import 'package:dartz/dartz.dart';
import '../../../../../core/error_handler/data_source_extension.dart';
import '../../../../../core/error_handler/error_handler.dart';
import '../../../../../core/error_handler/failure.dart';
import '../../../../../core/error_handler/type_handler_enum.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../data_source/tailor_details_data_source.dart';
import '../mapper/tailor_details_mapper.dart';
import '../../domain/model/tailor_details_model.dart';

abstract class TailorDetailsRepository {
  Future<Either<Failure, TailorDetailsModel>> getTailorDetails(String tailorId);
}

class TailorDetailsRepositoryImplement implements TailorDetailsRepository {
  final TailorDetailsDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  TailorDetailsRepositoryImplement(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, TailorDetailsModel>> getTailorDetails(
      String tailorId) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getTailorDetails(tailorId);
        return Right(response.toDomain());
      } catch (e) {
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(TypeHandlerEnum.noInternetConnection.getFailure());
    }
  }
}
