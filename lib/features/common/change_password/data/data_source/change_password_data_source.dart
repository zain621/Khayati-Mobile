import 'package:app_mobile/constants/request_constants/request_constants.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../request/change_password_request.dart';
import '../response/change_password_response.dart';

abstract class ChangePasswordDataSource {
  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}

class ChangePasswordDataSourceImplement implements ChangePasswordDataSource {
  final AppService _appService;
  ChangePasswordDataSourceImplement(this._appService);

  @override
  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    return await _appService.changePassword({
      RequestConstants.currentPassword: request.currentPassword,
      RequestConstants.newPassword: request.newPassword,
    });
  }
}
