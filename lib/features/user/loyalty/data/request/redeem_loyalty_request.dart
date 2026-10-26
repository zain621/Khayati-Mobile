import '../../../../../constants/request_constants/request_constants.dart';

class RedeemLoyaltyRequest {
  final String rewardId;

  const RedeemLoyaltyRequest({required this.rewardId});

  Map<String, dynamic> toJson() => {
        RequestConstants.rewardId: rewardId,
      };
}
