import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/complete_login_with_code_data_source.dart';
import '../mapper/login_mapper.dart';
import '../request/complete_login_with_code_request.dart';
import '../../domain/model/login_model.dart';

abstract class CompleteLoginWithCodeRepository {
  Future<Either<Failure, LoginModel>> completeLoginWithCode(
      CompleteLoginWithCodeRequest request);
}

class CompleteLoginWithCodeRepositoryImplement
    implements CompleteLoginWithCodeRepository {
  final CompleteLoginWithCodeDataSource _remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  CompleteLoginWithCodeRepositoryImplement(
      this._networkInfo, this._remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> completeLoginWithCode(
      CompleteLoginWithCodeRequest request) async {
    try {
      final response = await _remoteDataSource.completeLoginWithCode(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
