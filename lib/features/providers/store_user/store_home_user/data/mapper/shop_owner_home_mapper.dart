import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/shop_owner_home_response.dart';
import '../../domain/model/shop_owner_home_model.dart';

extension ShopOwnerHomeMapper on ShopOwnerHomeDataResponse {
  ShopOwnerHomeModel toDomain() => ShopOwnerHomeModel(
        shopStatus: shopStatus.onNull(),
        isAcceptingOrders: isAcceptingOrders ?? false,
        withdrawableBalance: withdrawableBalance ?? 0,
        lastLoginAt: lastLoginAt.onNull(),
        averageRating: averageRating ?? 0,
        reviewsCount: reviewsCount ?? 0,
      );
}
