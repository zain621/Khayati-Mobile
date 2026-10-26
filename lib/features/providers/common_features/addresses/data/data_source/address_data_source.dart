import 'package:app_mobile/core/network/app_api.dart';
import '../request/address_request.dart';
import '../response/address_response.dart';

abstract class AddressDataSource {
  Future<AddressResponse> getAddress();
  Future<AddressResponse> createAddress(AddressRequest request);
  Future<AddressResponse> updateAddress(AddressRequest request);
}

class AddressDataSourceImplement implements AddressDataSource {
  final AppService _appService;
  AddressDataSourceImplement(this._appService);

  @override
  Future<AddressResponse> getAddress() async =>
      await _appService.getAddress();

  @override
  Future<AddressResponse> createAddress(AddressRequest request) async =>
      await _appService.createAddress(
        request.fullName,
        request.latitude,
        request.longitude,
        request.detailedDescription,
      );

  @override
  Future<AddressResponse> updateAddress(AddressRequest request) async =>
      await _appService.updateAddress(
        request.fullName,
        request.latitude,
        request.longitude,
        request.detailedDescription,
      );
}
