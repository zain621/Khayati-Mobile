import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/forgot_password_data_source.dart';
import '../mapper/forgot_password_mapper.dart';
import '../../domain/model/forgot_password_model.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(String phoneNumber);
  Future<Either<Failure, Unit>> verifyCode(String userId, String code);
  Future<Either<Failure, ForgotPasswordModel>> resendCode(String phoneNumber);
  Future<Either<Failure, Unit>> resetPassword(String userId, String newPassword);
}

class ForgotPasswordRepositoryImplement implements ForgotPasswordRepository {
  final ForgotPasswordDataSource _remoteDataSource;

  ForgotPasswordRepositoryImplement(this._remoteDataSource);

  @override
  Future<Either<Failure, ForgotPasswordModel>> forgotPassword(
      String phoneNumber) async {
    try {
      final response = await _remoteDataSource.forgotPassword(phoneNumber);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyCode(String userId, String code) async {
    try {
      await _remoteDataSource.verifyCode(userId, code);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordModel>> resendCode(
      String phoneNumber) async {
    try {
      final response = await _remoteDataSource.resendCode(phoneNumber);
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(
      String userId, String newPassword) async {
    try {
      await _remoteDataSource.resetPassword(userId, newPassword);
      return const Right(unit);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
