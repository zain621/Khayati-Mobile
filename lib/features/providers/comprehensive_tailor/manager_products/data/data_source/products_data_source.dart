import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/constants/env/env_constants.dart';
import 'package:app_mobile/core/service/env_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:dio/dio.dart';
import '../request/add_variant_request.dart';
import '../response/get_products_response.dart';
import '../response/product_action_response.dart';

/// Abstract data source for shop owner products.
abstract class ProductsDataSource {
  Future<GetProductsResponse> getProducts();
  Future<GetProductDetailsResponse> getProductDetails(String productId);
  Future<ProductActionResponse> createProduct(FormData formData);
  Future<ProductActionResponse> updateProduct(String productId, FormData formData);
  Future<ProductActionResponse> deleteProduct(String productId);
  Future<ProductActionResponse> activateProduct(String productId);
  Future<ProductActionResponse> cancelProduct(String productId);
  Future<ProductActionResponse> addVariant(String productId, AddVariantRequest req);
  Future<ProductActionResponse> updateVariant(String productId, String variantId, AddVariantRequest req);
  Future<ProductActionResponse> deleteVariant(String productId, String variantId);
  Future<ProductActionResponse> deleteProductImage(String productId, String imageId);
}

/// Implementation of ProductsDataSource.
class ProductsDataSourceImplement implements ProductsDataSource {
  final AppService _appService;
  final Dio _dio;
  final AppSettingsPrefs _prefs;

  ProductsDataSourceImplement(this._appService, this._dio, this._prefs);

  bool get _isComprehensive => _prefs.getUserRole() == 'comprehensive_tailor';

  String get _baseUrl {
    final url = EnvService.getString(key: EnvConstants.apiUrl);
    return url.endsWith('/') ? url.substring(0, url.length - 1) : url;
  }

  String get _productsBasePath =>
      _isComprehensive ? 'comprehensive-tailor/products' : 'shop-owner/products';

  @override
  Future<GetProductsResponse> getProducts() async {
    return _isComprehensive
        ? await _appService.getComprehensiveTailorProducts()
        : await _appService.getShopOwnerProducts();
  }

  @override
  Future<GetProductDetailsResponse> getProductDetails(String productId) async {
    return _isComprehensive
        ? await _appService.getComprehensiveTailorProductDetails(productId)
        : await _appService.getShopOwnerProductDetails(productId);
  }

  @override
  Future<ProductActionResponse> createProduct(FormData formData) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '$_baseUrl/$_productsBasePath',
      data: formData,
    );
    return ProductActionResponse.fromJson(response.data ?? {});
  }

  @override
  Future<ProductActionResponse> updateProduct(String productId, FormData formData) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '$_baseUrl/$_productsBasePath/$productId',
      data: formData,
    );
    return ProductActionResponse.fromJson(response.data ?? {});
  }

  @override
  Future<ProductActionResponse> deleteProduct(String productId) async {
    return _isComprehensive
        ? await _appService.deleteComprehensiveTailorProduct(productId)
        : await _appService.deleteShopOwnerProduct(productId);
  }

  @override
  Future<ProductActionResponse> activateProduct(String productId) async {
    return _isComprehensive
        ? await _appService.activateComprehensiveTailorProduct(productId)
        : await _appService.activateShopOwnerProduct(productId);
  }

  @override
  Future<ProductActionResponse> cancelProduct(String productId) async {
    return _isComprehensive
        ? await _appService.cancelComprehensiveTailorProduct(productId)
        : await _appService.cancelShopOwnerProduct(productId);
  }

  @override
  Future<ProductActionResponse> addVariant(String productId, AddVariantRequest req) async {
    return _isComprehensive
        ? await _appService.addVariantToComprehensiveTailorProduct(productId, req.toMap())
        : await _appService.addVariantToProduct(productId, req.toMap());
  }

  @override
  Future<ProductActionResponse> updateVariant(String productId, String variantId, AddVariantRequest req) async {
    return _isComprehensive
        ? await _appService.updateVariantInComprehensiveTailorProduct(productId, variantId, req.toMap())
        : await _appService.updateVariantInProduct(productId, variantId, req.toMap());
  }

  @override
  Future<ProductActionResponse> deleteVariant(String productId, String variantId) async {
    return _isComprehensive
        ? await _appService.deleteVariantFromComprehensiveTailorProduct(productId, variantId)
        : await _appService.deleteVariantFromProduct(productId, variantId);
  }

  @override
  Future<ProductActionResponse> deleteProductImage(String productId, String imageId) async {
    return _isComprehensive
        ? await _appService.deleteComprehensiveTailorProductImage(productId, imageId)
        : await _appService.deleteShopOwnerProductImage(productId, imageId);
  }
}

