import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/customer_register_data_source.dart';
import '../mapper/customer_register_mapper.dart';
import '../mapper/login_mapper.dart';
import '../request/customer_register_request.dart';
import '../request/customer_register_verify_request.dart';
import '../../domain/model/customer_register_model.dart';
import '../../domain/model/login_model.dart';

abstract class CustomerRegisterRepository {
  Future<Either<Failure, CustomerRegisterModel>> registerStep1(
      CustomerRegisterRequest request);

  Future<Either<Failure, LoginModel>> registerVerify(
      CustomerRegisterVerifyRequest request);
}

class CustomerRegisterRepositoryImplement
    implements CustomerRegisterRepository {
  final CustomerRegisterDataSource remoteDataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  CustomerRegisterRepositoryImplement(
      this._networkInfo, this.remoteDataSource);

  @override
  Future<Either<Failure, CustomerRegisterModel>> registerStep1(
      CustomerRegisterRequest request) async {
    try {
      final response = await remoteDataSource.registerStep1(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, LoginModel>> registerVerify(
      CustomerRegisterVerifyRequest request) async {
    try {
      final response = await remoteDataSource.registerVerify(request);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
