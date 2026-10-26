import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/constants/env/env_constants.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/service/env_service.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/add_cart_item_request.dart';
import '../../data/request/apply_coupon_request.dart';
import '../../data/request/update_cart_item_request.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/checkout_model.dart';
import '../../domain/use_case/get_cart_use_case.dart';
import '../../domain/use_case/add_cart_item_use_case.dart';
import '../../domain/use_case/update_cart_item_use_case.dart';
import '../../domain/use_case/remove_cart_item_use_case.dart';
import '../../domain/use_case/apply_coupon_use_case.dart';
import '../../domain/use_case/remove_coupon_use_case.dart';
import '../../domain/use_case/checkout_use_case.dart';

class CartController extends GetxController {
  final GetCartUseCase _getCartUseCase;
  final AddCartItemUseCase _addCartItemUseCase;
  final UpdateCartItemUseCase _updateCartItemUseCase;
  final RemoveCartItemUseCase _removeCartItemUseCase;
  final ApplyCouponUseCase _applyCouponUseCase;
  final RemoveCouponUseCase _removeCouponUseCase;
  final CheckoutUseCase _checkoutUseCase;

  CartController(
    this._getCartUseCase,
    this._addCartItemUseCase,
    this._updateCartItemUseCase,
    this._removeCartItemUseCase,
    this._applyCouponUseCase,
    this._removeCouponUseCase,
    this._checkoutUseCase,
  );

  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxBool isCheckingOut = false.obs;
  final RxBool isRefreshing = false.obs;

  final Rxn<CartModel> cart = Rxn<CartModel>();
  final Rxn<CheckoutModel> lastCheckout = Rxn<CheckoutModel>();

  // Tracks which store IDs are expanded in the UI
  final RxSet<String> expandedShops = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch cart
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> fetchCart() async {
    isLoading.value = true;
    try {
      final result = await _getCartUseCase.execute();
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) {
          cart.value = data;
          // Expand all shops by default on fresh load
          if (expandedShops.isEmpty) {
            expandedShops.addAll(data.shops.map((s) => s.shopId));
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshCart() async {
    isRefreshing.value = true;
    await fetchCart();
    isRefreshing.value = false;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Add item to cart
  // ─────────────────────────────────────────────────────────────────────────
  /// Returns `true` when the item was added so callers can open the cart.
  Future<bool> addToCart({
    required String productId,
    required String variantId,
    int quantity = 1,
  }) async {
    if (isActionLoading.value) return false;
    isActionLoading.value = true;
    var success = false;
    try {
      final result = await _addCartItemUseCase.execute(
        AddCartItemRequest(
          productId: productId,
          variantId: variantId,
          quantity: quantity,
        ),
      );
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) {
          cart.value = data;
          success = true;
        },
      );
    } finally {
      isActionLoading.value = false;
    }
    return success;
  }

  /// Open cart after a successful add (replaces snackbar-only flow).
  void openCartAfterAdd() {
    if (Get.currentRoute == Routes.cartScreen) {
      fetchCart();
      return;
    }
    Get.toNamed(Routes.cartScreen);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Increment / decrement quantity
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> incrementQty(CartItemModel item) async {
    if (item.quantity >= item.maxQuantity) return;
    await _updateQty(item.cartItemId, item.quantity + 1);
  }

  Future<void> decrementQty(CartItemModel item) async {
    if (item.quantity <= 1) {
      await removeItem(item.cartItemId);
    } else {
      await _updateQty(item.cartItemId, item.quantity - 1);
    }
  }

  Future<void> _updateQty(String cartItemId, int newQty) async {
    isActionLoading.value = true;
    try {
      final result = await _updateCartItemUseCase.execute(
        UpdateCartItemRequest(cartItemId: cartItemId, quantity: newQty),
      );
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) => cart.value = data,
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Remove item
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> removeItem(String cartItemId) async {
    isActionLoading.value = true;
    try {
      final result = await _removeCartItemUseCase.execute(cartItemId);
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) {
          cart.value = data;
          AppSnackbar.success(ManagerStrings.cartRemovedFromCart);
        },
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Coupon
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> applyCoupon(String code) async {
    if (code.trim().isEmpty) return;
    isActionLoading.value = true;
    try {
      final result = await _applyCouponUseCase.execute(
        ApplyCouponRequest(code: code.trim()),
      );
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) {
          cart.value = data;
          AppSnackbar.success(ManagerStrings.cartCouponApplied);
        },
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  Future<void> removeCoupon() async {
    isActionLoading.value = true;
    try {
      final result = await _removeCouponUseCase.execute();
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (CartModel data) {
          cart.value = data;
          AppSnackbar.success(ManagerStrings.cartCouponRemoved);
        },
      );
    } finally {
      isActionLoading.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Checkout
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> checkout() async {
    if (isCheckingOut.value) return;
    isCheckingOut.value = true;
    try {
      final result = await _checkoutUseCase.execute();
      await result.fold(
        (Failure failure) async {
          _showCheckoutError(failure.message);
        },
        (CheckoutModel data) async {
          lastCheckout.value = data;
          final rawUrl = data.payment?.paymentUrl.trim() ?? '';
          final paymentUrl = CartController.normalizePaymentUrl(rawUrl);

          if (paymentUrl.isEmpty) {
            _showCheckoutError(ManagerStrings.invalidPaymentLink);
            return;
          }

          // Open Telr hosted payment page (card entry stays on Telr).
          await Get.toNamed(
            Routes.checkoutWebViewScreen,
            arguments: {
              'url': paymentUrl,
              'sessionId': data.payment?.paymentSessionId,
              'provider': data.payment?.provider,
              'source': 'cart',
            },
          );
        },
      );
    } catch (e) {
      _showCheckoutError(e.toString());
    } finally {
      isCheckingOut.value = false;
    }
  }

  void _showCheckoutError(String message) {
    final text = message.trim().isEmpty ? ManagerStrings.unKnown : message.trim();
    AppSnackbar.error(text);
    // Dialog sits above the cart bottom bar so the full error is readable.
    if (Get.context != null) {
      Get.dialog(
        AlertDialog(
          title: Text(ManagerStrings.errorTitle),
          content: SingleChildScrollView(child: Text(text)),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(ManagerStrings.close),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  /// Called by the payment WebView after mock/real gateway finishes.
  Future<void> onPaymentCompleted({required bool paid}) async {
    if (paid) {
      cart.value = CartModel(
        shops: [],
        grandTotal: 0,
        discountAmount: 0,
        grandTotalAfterDiscount: 0,
      );
      AppSnackbar.success(ManagerStrings.cartCheckoutSuccess);
      await fetchCart();
      return;
    }
    AppSnackbar.error(ManagerStrings.paymentNotCompleted);
    await fetchCart();
  }

  /// Rewrite stale hosts (e.g. khayatipro.com) to the app's API host.
  static String normalizePaymentUrl(String url) {
    final trimmed = url.trim();
    if (trimmed.isEmpty) return trimmed;

    final paymentUri = Uri.tryParse(trimmed);
    if (paymentUri == null || !paymentUri.hasScheme) return trimmed;

    final apiBase = EnvService.getString(key: EnvConstants.apiUrl);
    final apiUri = Uri.tryParse(apiBase);
    if (apiUri == null || !apiUri.hasAuthority) return trimmed;

    final host = paymentUri.host.toLowerCase();
    final needsRewrite = host.contains('khayatipro.com') ||
        host.contains('railway.app') ||
        (paymentUri.path.contains('payments/mock') &&
            host != apiUri.host);

    if (!needsRewrite) return trimmed;

    return paymentUri
        .replace(
          scheme: apiUri.scheme,
          host: apiUri.host,
          port: apiUri.hasPort ? apiUri.port : null,
        )
        .toString();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // UI helpers
  // ─────────────────────────────────────────────────────────────────────────
  void toggleShopExpand(String shopId) {
    if (expandedShops.contains(shopId)) {
      expandedShops.remove(shopId);
    } else {
      expandedShops.add(shopId);
    }
  }

  bool isShopExpanded(String shopId) => expandedShops.contains(shopId);
}
