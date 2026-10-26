class CartItemModel {
  final String cartItemId;
  final String productId;
  final String variantId;
  final String name;
  final String imageUrl;
  final double price;
  final double? priceBeforeDiscount;
  final String? color;
  final String? size;
  final int quantity;
  final int maxQuantity;
  final double lineTotal;

  const CartItemModel({
    required this.cartItemId,
    required this.productId,
    required this.variantId,
    required this.name,
    required this.imageUrl,
    required this.price,
    this.priceBeforeDiscount,
    this.color,
    this.size,
    required this.quantity,
    required this.maxQuantity,
    required this.lineTotal,
  });
}

class CartShopModel {
  final String shopId;
  final String name;
  final List<CartItemModel> items;
  final double subtotal;

  const CartShopModel({
    required this.shopId,
    required this.name,
    required this.items,
    required this.subtotal,
  });
}

class CartModel {
  final List<CartShopModel> shops;
  final double grandTotal;
  final String? couponCode;
  final double discountAmount;
  final double grandTotalAfterDiscount;

  const CartModel({
    required this.shops,
    required this.grandTotal,
    this.couponCode,
    required this.discountAmount,
    required this.grandTotalAfterDiscount,
  });

  int get totalItemCount =>
      shops.fold(0, (sum, s) => sum + s.items.length);

  bool get hasCoupon => couponCode != null && couponCode!.isNotEmpty;
}
