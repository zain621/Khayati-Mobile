import 'package:app_mobile/core/network/app_api.dart';
import '../response/all_products_response.dart';

abstract class AllProductsDataSource {
  Future<AllProductsResponse> getProducts({
    required int page,
    required int perPage,
    String? shopSearch,
  });
}

class AllProductsDataSourceImplement implements AllProductsDataSource {
  final AppService _appService;

  AllProductsDataSourceImplement(this._appService);

  @override
  Future<AllProductsResponse> getProducts({
    required int page,
    required int perPage,
    String? shopSearch,
  }) =>
      _appService.getAllProducts(page, perPage, shopSearch);
}
