import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../data_source/portfolio_data_source.dart';

abstract class PortfolioRepository {
  Future<Either<Failure, void>> addImages(List<File> images);
  Future<Either<Failure, void>> deleteImage(String imageId);
  Future<Either<Failure, void>> addSpecialization(String name);
  Future<Either<Failure, void>> deleteSpecialization(String specializationId);
}

class PortfolioRepositoryImplement implements PortfolioRepository {
  final PortfolioDataSource _dataSource;
  // ignore: unused_field
  final NetworkInfo _networkInfo;

  PortfolioRepositoryImplement(this._networkInfo, this._dataSource);

  @override
  Future<Either<Failure, void>> addImages(List<File> images) async {
    try {
      await _dataSource.addImages(images);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteImage(String imageId) async {
    try {
      await _dataSource.deleteImage(imageId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> addSpecialization(String name) async {
    try {
      await _dataSource.addSpecialization(name);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, void>> deleteSpecialization(String specializationId) async {
    try {
      await _dataSource.deleteSpecialization(specializationId);
      return const Right(null);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
