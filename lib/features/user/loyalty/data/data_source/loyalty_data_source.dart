import 'package:app_mobile/core/network/app_api.dart';
import '../request/redeem_loyalty_request.dart';
import '../response/loyalty_points_response.dart';
import '../response/loyalty_rewards_response.dart';
import '../response/redeem_loyalty_response.dart';
import '../response/unused_loyalty_codes_response.dart';

abstract class LoyaltyDataSource {
  Future<LoyaltyPointsResponse> getLoyaltyPoints();
  Future<LoyaltyRewardsResponse> getLoyaltyRewards();
  Future<RedeemLoyaltyResponse> redeemLoyalty(RedeemLoyaltyRequest request);
  Future<UnusedLoyaltyCodesResponse> getUnusedCodes();
}

class LoyaltyDataSourceImplement implements LoyaltyDataSource {
  final AppService _appService;

  LoyaltyDataSourceImplement(this._appService);

  @override
  Future<LoyaltyPointsResponse> getLoyaltyPoints() =>
      _appService.getLoyaltyPoints();

  @override
  Future<LoyaltyRewardsResponse> getLoyaltyRewards() =>
      _appService.getLoyaltyRewards();

  @override
  Future<RedeemLoyaltyResponse> redeemLoyalty(RedeemLoyaltyRequest request) =>
      _appService.redeemLoyalty(request.rewardId);

  @override
  Future<UnusedLoyaltyCodesResponse> getUnusedCodes() =>
      _appService.getLoyaltyUnusedCodes();
}
