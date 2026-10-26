import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/constants/request_constants/request_constants.dart';
import '../response/shop_owner_home_response.dart';
import '../response/update_shop_owner_availability_response.dart';

abstract class ShopOwnerHomeDataSource {
  Future<ShopOwnerHomeDataResponse> fetchHome();
  Future<UpdateShopOwnerAvailabilityDataResponse> changeAvailability(bool isOpen);
}

class ShopOwnerHomeDataSourceImplement implements ShopOwnerHomeDataSource {
  final AppService _appService;

  ShopOwnerHomeDataSourceImplement(this._appService);

  @override
  Future<ShopOwnerHomeDataResponse> fetchHome() async {
    final response = await _appService.getShopOwnerHome();
    return response.data!;
  }

  @override
  Future<UpdateShopOwnerAvailabilityDataResponse> changeAvailability(
      bool isOpen) async {
    final response = await _appService.updateShopOwnerAvailability(
      {RequestConstants.isOpen: isOpen},
    );
    return response.data!;
  }
}
