import '../response/comprehensive_home_response.dart';
import '../../domain/model/comprehensive_home_model.dart';

extension ComprehensiveHomeDashboardMapper on ComprehensiveHomeDashboardResponse {
  ComprehensiveHomeModel toDomain({
    String? fullName,
    String? imageUrl,
  }) =>
      ComprehensiveHomeModel(
        fullName: fullName ?? '',
        imageUrl: imageUrl,
        withdrawableBalance: withdrawableBalance ?? 0,
        lastLoginAt: lastLoginAt ?? '',
        averageRating: averageRating ?? 0,
        reviewsCount: reviewsCount ?? 0,
        rankLabel: rankLabel ?? '',
        isAcceptingOrders: isAcceptingOrders ?? true,
        zoqakOrdersCount: zoqakOrdersCount ?? 0,
      );
}
