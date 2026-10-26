import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/get_independent_reviews_response.dart';
import '../response/get_comprehensive_reviews_response.dart';
import '../response/get_shop_owner_reviews_response.dart';
import '../../domain/model/customer_review_model.dart';

// ── Independent tailor ────────────────────────────────────────────────────────

extension IndependentReviewItemMapper on IndependentReviewItemResponse {
  CustomerReviewModel toDomain() {
    return CustomerReviewModel(
      id: id.onNull(),
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      rating: rating ?? 0,
      comment: comment.onNull(),
      imageUrl: imageUrl,
      createdAt: createdAt.onNull(),
      reviewerName: reviewerName.onNull(),
      reviewerImage: reviewerImage,
    );
  }
}

extension GetIndependentReviewsMapper on GetIndependentReviewsResponse {
  List<CustomerReviewModel> toDomain() {
    return (data ?? [])
        .map((item) => item.toDomain())
        .toList();
  }
}

// ── Comprehensive tailor ──────────────────────────────────────────────────────

extension ReviewProductMapper on ReviewProductResponse {
  ReviewProductModel toDomain() {
    return ReviewProductModel(
      productId: productId.onNull(),
      productName: productName.onNull(),
      quantity: quantity ?? 1,
    );
  }
}

extension ComprehensiveReviewItemMapper on ComprehensiveReviewItemResponse {
  CustomerReviewModel toDomain() {
    return CustomerReviewModel(
      id: reviewId.onNull(),
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      rating: rating ?? 0,
      comment: comment.onNull(),
      imageUrl: imageUrl,
      createdAt: createdAt.onNull(),
      reviewerName: reviewer?.fullName.onNull() ?? '',
      reviewerImage: reviewer?.image,
      type: type,
      products: (products ?? []).map((p) => p.toDomain()).toList(),
    );
  }
}

extension GetComprehensiveReviewsMapper on GetComprehensiveReviewsResponse {
  List<CustomerReviewModel> toDomain() {
    return (data?.items ?? [])
        .map((item) => item.toDomain())
        .toList();
  }
}

// ── Shop Owner ────────────────────────────────────────────────────────────────

extension ShopOwnerReviewItemMapper on ShopOwnerReviewItemResponse {
  CustomerReviewModel toDomain() {
    return CustomerReviewModel(
      id: reviewId.onNull(),
      orderId: orderId.onNull(),
      orderNumber: orderNumber.onNull(),
      rating: rating ?? 0,
      comment: comment.onNull(),
      imageUrl: imageUrl,
      createdAt: createdAt.onNull(),
      reviewerName: reviewer?.fullName.onNull() ?? '',
      reviewerImage: reviewer?.image,
    );
  }
}

extension GetShopOwnerReviewsMapper on GetShopOwnerReviewsResponse {
  CustomerReviewsResult toDomain() {
    final items = (data?.items ?? [])
        .map((item) => item.toDomain())
        .toList();

    final s = data?.summary;
    final rb = s?.ratingBreakdown;
    final summary = s != null
        ? ReviewSummaryModel(
            totalReviews: s.totalReviews ?? 0,
            averageRating: (s.averageRating ?? 0).toDouble(),
            fiveStars: rb?.fiveStars ?? 0,
            fourStars: rb?.fourStars ?? 0,
            threeStars: rb?.threeStars ?? 0,
            twoStars: rb?.twoStars ?? 0,
            oneStar: rb?.oneStar ?? 0,
          )
        : null;

    return CustomerReviewsResult(reviews: items, summary: summary);
  }
}
