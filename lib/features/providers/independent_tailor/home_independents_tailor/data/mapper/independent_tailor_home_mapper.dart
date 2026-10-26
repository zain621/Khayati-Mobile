import '../response/independent_tailor_home_response.dart';
import '../../domain/model/independent_tailor_home_model.dart';

extension IndependentTailorHomeReviewMapper
    on IndependentTailorHomeReviewResponse {
  IndependentTailorHomeReviewModel toDomain() =>
      IndependentTailorHomeReviewModel(
        id: id ?? '',
        orderId: orderId ?? '',
        rating: rating ?? 0,
        comment: comment ?? '',
        imageUrl: imageUrl,
        buyerName: buyerName ?? '',
        createdAt: createdAt ?? '',
      );
}

extension IndependentTailorHomeDataMapper on IndependentTailorHomeDataResponse {
  IndependentTailorHomeModel toDomain({
    required String fullName,
    String? imageUrl,
  }) =>
      IndependentTailorHomeModel(
        fullName: fullName,
        imageUrl: imageUrl,
        withdrawableBalance: withdrawableBalance ?? 0,
        lastLoginAt: lastLoginAt ?? '',
        averageRating: averageRating ?? 0.0,
        reviewsCount: reviewsCount ?? 0,
        rankLabel: rankLabel ?? '',
        isAcceptingOrders: isAcceptingOrders ?? true,
        isAvailable: isAvailable ?? true,
        zoqakOrdersCount: zoqakOrdersCount ?? 0,
        zoqakAvailableForOffersCount: zoqakAvailableForOffersCount ?? 0,
        reviews: reviews?.map((r) => r.toDomain()).toList() ?? [],
      );
}
