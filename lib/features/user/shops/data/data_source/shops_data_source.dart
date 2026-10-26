import 'package:app_mobile/core/network/app_api.dart';
import '../response/get_shops_response.dart';
import '../response/get_top_shops_response.dart';

abstract class ShopsDataSource {
  Future<GetShopsResponse> getShops();
  Future<GetTopShopsResponse> getTopShops();
}

class ShopsDataSourceImplement implements ShopsDataSource {
  final AppService _appService;

  ShopsDataSourceImplement(this._appService);

  @override
  Future<GetShopsResponse> getShops() => _appService.getShops();

  @override
  Future<GetTopShopsResponse> getTopShops() =>
      _appService.getTopShops(null, 1, 10);
}
