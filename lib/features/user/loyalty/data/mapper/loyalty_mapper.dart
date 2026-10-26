import 'package:app_mobile/core/extensions/extensions.dart';
import '../response/loyalty_points_response.dart';
import '../response/loyalty_rewards_response.dart';
import '../response/redeem_loyalty_response.dart';
import '../response/unused_loyalty_codes_response.dart';
import '../../domain/model/loyalty_points_model.dart';
import '../../domain/model/loyalty_reward_model.dart';
import '../../domain/model/redeem_loyalty_model.dart';
import '../../domain/model/unused_loyalty_code_model.dart';

extension LoyaltyPointsMapper on LoyaltyPointsResponse {
  LoyaltyPointsModel toDomain() => LoyaltyPointsModel(
        points: data?.points.onNull() ?? 0,
      );
}

extension LoyaltyRewardsMapper on LoyaltyRewardsResponse {
  List<LoyaltyRewardModel> toDomain() =>
      (data ?? []).map((item) => item.toDomain()).toList();
}

extension LoyaltyRewardItemMapper on LoyaltyRewardItemResponse {
  LoyaltyRewardModel toDomain() => LoyaltyRewardModel(
        id: id.onNull(),
        titleAr: titleAr.onNull(),
        titleEn: titleEn.onNull(),
        pointsRequired: pointsRequired.onNull(),
        discountType: discountType.onNull(),
        discountValue: discountValue.onNull(),
        isActive: isActive ?? false,
      );
}

extension RedeemLoyaltyMapper on RedeemLoyaltyResponse {
  RedeemLoyaltyModel toDomain() => RedeemLoyaltyModel(
        message: message.onNull(),
        redeemCode: data?.code ?? '',
      );
}

extension UnusedLoyaltyCodesMapper on UnusedLoyaltyCodesResponse {
  List<UnusedLoyaltyCodeModel> toDomain() =>
      (data ?? []).map((item) => item.toDomain()).toList();
}

extension UnusedCodeItemMapper on UnusedCodeItemResponse {
  UnusedLoyaltyCodeModel toDomain() => UnusedLoyaltyCodeModel(
        id: id.onNull(),
        code: code.onNull(),
        rewardId: rewardId.onNull(),
        rewardTitleAr: rewardTitleAr.onNull(),
        rewardTitleEn: rewardTitleEn.onNull(),
        discountType: discountType.onNull(),
        discountValue: discountValue.onNull(),
        createdAt: createdAt.onNull(),
      );
}
