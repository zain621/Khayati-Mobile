import 'package:dio/dio.dart';
import 'package:app_mobile/constants/request_constants/request_constants_endpoints.dart';
import '../response/logout_response.dart';

abstract class LogoutDataSource {
  Future<LogoutResponse> logout();
}

class LogoutDataSourceImpl implements LogoutDataSource {
  final Dio _dio;

  LogoutDataSourceImpl(this._dio);

  @override
  Future<LogoutResponse> logout() async {
    final response = await _dio.post(RequestConstantsEndpoints.logout);
    return LogoutResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
