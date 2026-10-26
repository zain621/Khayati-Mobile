import 'package:app_mobile/core/network/app_api.dart';
import '../request/customer_register_request.dart';
import '../request/customer_register_verify_request.dart';
import '../response/customer_register_response.dart';
import '../response/login_response.dart';

abstract class CustomerRegisterDataSource {
  Future<CustomerRegisterResponse> registerStep1(
      CustomerRegisterRequest request);

  Future<LoginResponse> registerVerify(CustomerRegisterVerifyRequest request);
}

class CustomerRegisterDataSourceImplement
    implements CustomerRegisterDataSource {
  final AppService _appService;

  CustomerRegisterDataSourceImplement(this._appService);

  @override
  Future<CustomerRegisterResponse> registerStep1(
      CustomerRegisterRequest request) async {
    return await _appService.customerRegisterStep1(
      request.fullName,
      request.phoneNumber,
    );
  }

  @override
  Future<LoginResponse> registerVerify(
      CustomerRegisterVerifyRequest request) async {
    return await _appService.customerRegisterVerify(
      request.phoneNumber,
      request.code,
    );
  }
}
