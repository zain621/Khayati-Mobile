class CheckoutOrderModel {
  final String id;
  final String orderNumber;
  final String shopId;
  final String shopName;
  final String status;
  final String? paymentStatus;
  final double totalAmount;
  final int itemsCount;
  final String createdAt;

  const CheckoutOrderModel({
    required this.id,
    required this.orderNumber,
    required this.shopId,
    required this.shopName,
    required this.status,
    this.paymentStatus,
    required this.totalAmount,
    required this.itemsCount,
    required this.createdAt,
  });
}

class CheckoutModel {
  final List<CheckoutOrderModel> orders;
  final CheckoutPaymentModel? payment;
  final int userLoyaltyPoints;

  const CheckoutModel({
    required this.orders,
    this.payment,
    required this.userLoyaltyPoints,
  });
}

class CheckoutPaymentModel {
  final String paymentSessionId;
  final String provider;
  final String status;
  final String paymentUrl;
  final String? invoiceUrl;

  const CheckoutPaymentModel({
    required this.paymentSessionId,
    required this.provider,
    required this.status,
    required this.paymentUrl,
    this.invoiceUrl,
  });
}
