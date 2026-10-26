import 'package:app_mobile/core/network/app_api.dart';
import '../response/product_details_response.dart';

abstract class ProductDetailsDataSource {
  Future<ProductDetailsResponse> getProductDetails(String productId);
}

class ProductDetailsDataSourceImplement implements ProductDetailsDataSource {
  final AppService _appService;

  ProductDetailsDataSourceImplement(this._appService);

  @override
  Future<ProductDetailsResponse> getProductDetails(String productId) =>
      _appService.getProductDetails(productId);
}
