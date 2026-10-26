import 'package:app_mobile/core/network/app_api.dart';
import '../request/complete_login_with_code_request.dart';
import '../response/login_response.dart';

abstract class CompleteLoginWithCodeDataSource {
  Future<LoginResponse> completeLoginWithCode(
      CompleteLoginWithCodeRequest request);
}

class CompleteLoginWithCodeDataSourceImplement
    implements CompleteLoginWithCodeDataSource {
  final AppService _appService;

  CompleteLoginWithCodeDataSourceImplement(this._appService);

  @override
  Future<LoginResponse> completeLoginWithCode(
      CompleteLoginWithCodeRequest request) async {
    return await _appService.completeLoginWithCode(
      request.phoneNumber,
      request.code,
    );
  }
}
