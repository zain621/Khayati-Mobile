import 'package:dio/dio.dart';
import 'package:app_mobile/constants/request_constants/request_constants_endpoints.dart';
import '../response/delete_account_response.dart';

abstract class DeleteAccountDataSource {
  Future<DeleteAccountResponse> deleteAccount();
}

class DeleteAccountDataSourceImpl implements DeleteAccountDataSource {
  final Dio _dio;

  DeleteAccountDataSourceImpl(this._dio);

  @override
  Future<DeleteAccountResponse> deleteAccount() async {
    final response =
        await _dio.post(RequestConstantsEndpoints.deleteAccountRequest);
    return DeleteAccountResponse.fromJson(
        response.data as Map<String, dynamic>);
  }
}
