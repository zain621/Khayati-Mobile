/// A single product line attached to a shop-type comprehensive review.
class ReviewProductModel {
  final String productId;
  final String productName;
  final int quantity;

  const ReviewProductModel({
    required this.productId,
    required this.productName,
    required this.quantity,
  });
}

/// Unified domain model for a customer review across all 3 provider roles.
class CustomerReviewModel {
  final String id;
  final String orderId;
  final String orderNumber;
  final int rating;
  final String comment;
  final String? imageUrl;
  final String createdAt;
  final String reviewerName;
  final String? reviewerImage;

  /// Only present for comprehensive-tailor reviews: 'shop' or 'zoqak'.
  final String? type;

  /// Only present for comprehensive-tailor shop-type reviews.
  final List<ReviewProductModel> products;

  const CustomerReviewModel({
    required this.id,
    required this.orderId,
    required this.orderNumber,
    required this.rating,
    required this.comment,
    this.imageUrl,
    required this.createdAt,
    required this.reviewerName,
    this.reviewerImage,
    this.type,
    this.products = const [],
  });
}

/// Rating summary available only for shop-owner reviews.
class ReviewSummaryModel {
  final int totalReviews;
  final double averageRating;
  final int fiveStars;
  final int fourStars;
  final int threeStars;
  final int twoStars;
  final int oneStar;

  const ReviewSummaryModel({
    required this.totalReviews,
    required this.averageRating,
    required this.fiveStars,
    required this.fourStars,
    required this.threeStars,
    required this.twoStars,
    required this.oneStar,
  });
}

/// Aggregated result returned from the repository to the controller.
class CustomerReviewsResult {
  final List<CustomerReviewModel> reviews;

  /// Non-null only for shop_owner role.
  final ReviewSummaryModel? summary;

  const CustomerReviewsResult({
    required this.reviews,
    this.summary,
  });
}
