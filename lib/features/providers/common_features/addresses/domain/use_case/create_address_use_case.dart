import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/address_repository.dart';
import '../../data/request/address_request.dart';
import '../model/address_model.dart';

class CreateAddressUseCase implements BaseUseCase<AddressRequest, AddressModel> {
  final AddressRepository _repository;
  CreateAddressUseCase(this._repository);

  @override
  Future<Either<Failure, AddressModel>> execute(AddressRequest request) =>
      _repository.createAddress(request);
}
