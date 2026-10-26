import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/cart_response.dart';
import '../response/checkout_response.dart';
import '../../domain/model/cart_model.dart';
import '../../domain/model/checkout_model.dart';

extension CartResponseMapper on CartResponse {
  CartModel toDomain() => CartModel(
        shops: data?.shops?.map((s) => s.toDomain()).toList() ?? [],
        grandTotal: data?.grandTotal ?? 0.0,
        couponCode: data?.couponCode,
        discountAmount: data?.discountAmount ?? 0.0,
        grandTotalAfterDiscount: data?.grandTotalAfterDiscount ?? 0.0,
      );
}

extension CartShopResponseMapper on CartShopResponse {
  CartShopModel toDomain() => CartShopModel(
        shopId: shopId.onNull(),
        name: name.onNull(),
        items: products?.map((p) => p.toDomain()).toList() ?? [],
        subtotal: subtotal ?? 0.0,
      );
}

extension CartItemResponseMapper on CartItemResponse {
  CartItemModel toDomain() => CartItemModel(
        cartItemId: cartItemId.onNull(),
        productId: productId.onNull(),
        variantId: variantId.onNull(),
        name: name.onNull(),
        imageUrl: imageUrl.onNull(),
        price: price ?? 0.0,
        priceBeforeDiscount: priceBeforeDiscount,
        color: color,
        size: size,
        quantity: quantity ?? 1,
        maxQuantity: maxQuantity ?? 99,
        lineTotal: lineTotal ?? 0.0,
      );
}

extension CheckoutResponseMapper on CheckoutResponse {
  CheckoutModel toDomain() => CheckoutModel(
        orders: data?.orders?.map((o) => o.toDomain()).toList() ?? [],
        payment: data?.payment?.toDomain(),
        userLoyaltyPoints: data?.userLoyaltyPoints ?? 0,
      );
}

extension CheckoutOrderResponseMapper on CheckoutOrderResponse {
  CheckoutOrderModel toDomain() => CheckoutOrderModel(
        id: id.onNull(),
        orderNumber: orderNumber.onNull(),
        shopId: shopId.onNull(),
        shopName: shopName.onNull(),
        status: status.onNull(),
        paymentStatus: paymentStatus,
        totalAmount: totalAmount ?? 0.0,
        itemsCount: itemsCount ?? 0,
        createdAt: createdAt.onNull(),
      );
}

extension CheckoutPaymentResponseMapper on CheckoutPaymentResponse {
  CheckoutPaymentModel toDomain() => CheckoutPaymentModel(
        paymentSessionId: paymentSessionId.onNull(),
        provider: provider.onNull(),
        status: status.onNull(),
        paymentUrl: paymentUrl.onNull(),
        invoiceUrl: invoiceUrl,
      );
}
