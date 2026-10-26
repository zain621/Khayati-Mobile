/// Domain model for the comprehensive-tailor home endpoint.
class ComprehensiveHomeModel {
  final String fullName;
  final String? imageUrl;
  final double withdrawableBalance;
  final String lastLoginAt;
  final double averageRating;
  final int reviewsCount;
  final String rankLabel;
  final bool isAcceptingOrders;
  final int zoqakOrdersCount;

  const ComprehensiveHomeModel({
    required this.fullName,
    this.imageUrl,
    required this.withdrawableBalance,
    required this.lastLoginAt,
    required this.averageRating,
    required this.reviewsCount,
    required this.rankLabel,
    required this.isAcceptingOrders,
    required this.zoqakOrdersCount,
  });
}
