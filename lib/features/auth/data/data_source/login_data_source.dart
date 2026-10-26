import 'package:app_mobile/core/network/app_api.dart';
import '../request/login_request.dart';
import '../response/login_response.dart';

abstract class LoginDataSource {
  Future<LoginResponse> login(LoginRequest request);
}

class LoginDataSourceImplement implements LoginDataSource {
  final AppService _appService;

  LoginDataSourceImplement(this._appService);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    return await _appService.login(
      request.phoneNumber,
    );
  }
}
