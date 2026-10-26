import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/address_repository.dart';
import '../model/address_model.dart';

class GetAddressUseCase implements BaseGetUseCase<AddressModel?> {
  final AddressRepository _repository;
  GetAddressUseCase(this._repository);

  @override
  Future<Either<Failure, AddressModel?>> execute() => _repository.getAddress();
}
