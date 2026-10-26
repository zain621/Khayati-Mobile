import '../../../../../core/network/app_api.dart';
import '../response/shop_details_response.dart';

abstract class ShopDetailsDataSource {
  Future<ShopDetailsResponse> getShopDetails(String shopId);
}

class ShopDetailsDataSourceImplement implements ShopDetailsDataSource {
  final AppService _appService;

  ShopDetailsDataSourceImplement(this._appService);

  @override
  Future<ShopDetailsResponse> getShopDetails(String shopId) =>
      _appService.getShopDetails(shopId);
}
