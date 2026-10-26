import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/customer_register_repository.dart';
import '../../data/request/customer_register_request.dart';
import '../model/customer_register_model.dart';

class CustomerRegisterUseCase
    implements BaseUseCase<CustomerRegisterRequest, CustomerRegisterModel> {
  final CustomerRegisterRepository _repository;

  CustomerRegisterUseCase(this._repository);

  @override
  Future<Either<Failure, CustomerRegisterModel>> execute(
      CustomerRegisterRequest request) async {
    return await _repository.registerStep1(request);
  }
}
