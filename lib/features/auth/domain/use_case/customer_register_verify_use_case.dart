import 'package:dartz/dartz.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/usecase/base_usecase.dart';
import '../../data/repository/customer_register_repository.dart';
import '../../data/request/customer_register_verify_request.dart';
import '../model/login_model.dart';

class CustomerRegisterVerifyUseCase
    implements BaseUseCase<CustomerRegisterVerifyRequest, LoginModel> {
  final CustomerRegisterRepository _repository;

  CustomerRegisterVerifyUseCase(this._repository);

  @override
  Future<Either<Failure, LoginModel>> execute(
      CustomerRegisterVerifyRequest request) async {
    return await _repository.registerVerify(request);
  }
}
