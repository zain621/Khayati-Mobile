import 'package:app_mobile/core/network/app_api.dart';
import '../response/cart_response.dart';
import '../response/checkout_response.dart';

abstract class CartDataSource {
  Future<CartResponse> getCart();
  Future<CartResponse> addCartItem(Map<String, dynamic> body);
  Future<CartResponse> updateCartItem(String cartItemId, int quantity);
  Future<CartResponse> removeCartItem(String cartItemId);
  Future<CartResponse> applyCoupon(String code);
  Future<CartResponse> removeCoupon();
  Future<CheckoutResponse> checkout();
}

class CartDataSourceImplement implements CartDataSource {
  final AppService _appService;

  CartDataSourceImplement(this._appService);

  @override
  Future<CartResponse> getCart() => _appService.getCart();

  @override
  Future<CartResponse> addCartItem(Map<String, dynamic> body) =>
      _appService.addCartItem(body);

  @override
  Future<CartResponse> updateCartItem(String cartItemId, int quantity) =>
      _appService.updateCartItem(cartItemId, {'quantity': quantity});

  @override
  Future<CartResponse> removeCartItem(String cartItemId) =>
      _appService.removeCartItem(cartItemId);

  @override
  Future<CartResponse> applyCoupon(String code) =>
      _appService.applyCoupon(code);

  @override
  Future<CartResponse> removeCoupon() => _appService.removeCoupon();

  @override
  Future<CheckoutResponse> checkout() => _appService.checkout();
}
