import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/features/user/shops/data/response/get_shops_response.dart';

abstract class AllShopsDataSource {
  Future<GetShopsResponse> getShops({
    required int page,
    required int perPage,
    String? search,
    String? orderBy,
  });
}

class AllShopsDataSourceImplement implements AllShopsDataSource {
  final AppService _appService;

  AllShopsDataSourceImplement(this._appService);

  @override
  Future<GetShopsResponse> getShops({
    required int page,
    required int perPage,
    String? search,
    String? orderBy,
  }) =>
      _appService.getShopsPaginated(page, perPage, search, orderBy);
}
