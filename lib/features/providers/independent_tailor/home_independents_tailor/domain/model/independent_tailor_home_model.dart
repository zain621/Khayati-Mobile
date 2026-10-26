/// Domain model for a recent review shown on the independent tailor home screen.
class IndependentTailorHomeReviewModel {
  final String id;
  final String orderId;
  final int rating;
  final String comment;
  final String? imageUrl;
  final String buyerName;
  final String createdAt;

  const IndependentTailorHomeReviewModel({
    required this.id,
    required this.orderId,
    required this.rating,
    required this.comment,
    this.imageUrl,
    required this.buyerName,
    required this.createdAt,
  });
}

/// Domain model for the independent-tailor home endpoint.
class IndependentTailorHomeModel {
  final String fullName;
  final String? imageUrl;
  final double withdrawableBalance;
  final String lastLoginAt;
  final double averageRating;
  final int reviewsCount;
  final String rankLabel;
  final bool isAcceptingOrders;
  final bool isAvailable;
  final int zoqakOrdersCount;
  final int zoqakAvailableForOffersCount;
  final List<IndependentTailorHomeReviewModel> reviews;

  const IndependentTailorHomeModel({
    required this.fullName,
    this.imageUrl,
    required this.withdrawableBalance,
    required this.lastLoginAt,
    required this.averageRating,
    required this.reviewsCount,
    required this.rankLabel,
    required this.isAcceptingOrders,
    required this.isAvailable,
    required this.zoqakOrdersCount,
    required this.zoqakAvailableForOffersCount,
    required this.reviews,
  });
}
