import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/login_data_source.dart';
import '../mapper/login_mapper.dart';
import '../request/login_request.dart';
import '../../domain/model/login_model.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginModel>> login(LoginRequest request);
}

class LoginRepositoryImplement implements LoginRepository {
  final LoginDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  LoginRepositoryImplement(this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login(LoginRequest request) async {
    try {
      final response = await remoteDataSource.login(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
