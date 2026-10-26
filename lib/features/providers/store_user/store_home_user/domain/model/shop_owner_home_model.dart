/// Domain model for the shop-owner home endpoint response.
class ShopOwnerHomeModel {
  final String shopStatus;
  final bool isAcceptingOrders;
  final double withdrawableBalance;
  final String lastLoginAt;
  final double averageRating;
  final int reviewsCount;

  ShopOwnerHomeModel({
    required this.shopStatus,
    required this.isAcceptingOrders,
    required this.withdrawableBalance,
    required this.lastLoginAt,
    required this.averageRating,
    required this.reviewsCount,
  });

  /// True when the store is open and accepting orders.
  bool get isOpen => isAcceptingOrders;
}
