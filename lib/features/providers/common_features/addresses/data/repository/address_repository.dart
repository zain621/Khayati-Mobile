import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/error_handler.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import '../data_source/address_data_source.dart';
import '../mapper/address_mapper.dart';
import '../request/address_request.dart';
import '../../domain/model/address_model.dart';

abstract class AddressRepository {
  Future<Either<Failure, AddressModel?>> getAddress();
  Future<Either<Failure, AddressModel>> createAddress(AddressRequest request);
  Future<Either<Failure, AddressModel>> updateAddress(AddressRequest request);
}

class AddressRepositoryImplement implements AddressRepository {
  final AddressDataSource _dataSource;
  AddressRepositoryImplement(this._dataSource);

  @override
  Future<Either<Failure, AddressModel?>> getAddress() async {
    try {
      final response = await _dataSource.getAddress();
      return Right(response.toDomain());
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, AddressModel>> createAddress(AddressRequest request) async {
    try {
      final response = await _dataSource.createAddress(request);
      return Right(response.toDomain()!);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }

  @override
  Future<Either<Failure, AddressModel>> updateAddress(AddressRequest request) async {
    try {
      final response = await _dataSource.updateAddress(request);
      return Right(response.toDomain()!);
    } catch (e) {
      return Left(ErrorHandler.handle(e).failure);
    }
  }
}
