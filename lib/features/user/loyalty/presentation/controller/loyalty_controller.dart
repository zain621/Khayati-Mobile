import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../data/request/redeem_loyalty_request.dart';
import '../../domain/model/loyalty_points_model.dart';
import '../../domain/model/loyalty_reward_model.dart';
import '../../domain/model/redeem_loyalty_model.dart';
import '../../domain/model/unused_loyalty_code_model.dart';
import '../../domain/use_case/get_loyalty_points_use_case.dart';
import '../../domain/use_case/get_loyalty_rewards_use_case.dart';
import '../../domain/use_case/redeem_loyalty_use_case.dart';
import '../../domain/use_case/get_unused_codes_use_case.dart';

class LoyaltyController extends GetxController {
  final GetLoyaltyPointsUseCase _getLoyaltyPointsUseCase;
  final GetLoyaltyRewardsUseCase _getLoyaltyRewardsUseCase;
  final RedeemLoyaltyUseCase _redeemLoyaltyUseCase;
  final GetUnusedCodesUseCase _getUnusedCodesUseCase;

  LoyaltyController(
    this._getLoyaltyPointsUseCase,
    this._getLoyaltyRewardsUseCase,
    this._redeemLoyaltyUseCase,
    this._getUnusedCodesUseCase,
  );

  final RxBool isLoadingPoints = false.obs;
  final RxBool isLoadingRewards = false.obs;
  final RxBool isLoadingUnusedCodes = false.obs;
  final RxBool isRedeeming = false.obs;
  final RxBool isRefreshing = false.obs;

  /// Set to the redeem code on success; screen observes this to show dialog.
  final Rxn<String> lastRedeemCode = Rxn<String>();

  final Rx<LoyaltyPointsModel> loyaltyPoints =
      LoyaltyPointsModel(points: 0).obs;
  final RxList<LoyaltyRewardModel> rewards = <LoyaltyRewardModel>[].obs;
  final RxList<UnusedLoyaltyCodeModel> unusedCodes =
      <UnusedLoyaltyCodeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      fetchLoyaltyPoints(),
      fetchLoyaltyRewards(),
      fetchUnusedCodes(),
    ]);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch loyalty points
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> fetchLoyaltyPoints() async {
    isLoadingPoints.value = true;
    try {
      final result = await _getLoyaltyPointsUseCase.execute();
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (LoyaltyPointsModel data) => loyaltyPoints.value = data,
      );
    } finally {
      isLoadingPoints.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch loyalty rewards
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> fetchLoyaltyRewards() async {
    isLoadingRewards.value = true;
    try {
      final result = await _getLoyaltyRewardsUseCase.execute();
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (List<LoyaltyRewardModel> data) => rewards.assignAll(data),
      );
    } finally {
      isLoadingRewards.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch unused codes
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> fetchUnusedCodes() async {
    isLoadingUnusedCodes.value = true;
    try {
      final result = await _getUnusedCodesUseCase.execute();
      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (List<UnusedLoyaltyCodeModel> data) => unusedCodes.assignAll(data),
      );
    } finally {
      isLoadingUnusedCodes.value = false;
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Pull-to-refresh
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> refreshLoyalty() async {
    isRefreshing.value = true;
    await Future.wait([
      fetchLoyaltyPoints(),
      fetchLoyaltyRewards(),
      fetchUnusedCodes(),
    ]);
    isRefreshing.value = false;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Redeem a reward
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> redeemReward(String rewardId) async {
    if (isRedeeming.value) return; // guard against double-tap
    isRedeeming.value = true;
    try {
      final result = await _redeemLoyaltyUseCase
          .execute(RedeemLoyaltyRequest(rewardId: rewardId));

      result.fold(
        (Failure failure) => AppSnackbar.error(failure.message),
        (RedeemLoyaltyModel data) {
          // Reset to null first so ever() always fires, even for the same code
          lastRedeemCode.value = null;
          lastRedeemCode.value = data.redeemCode;
          fetchLoyaltyPoints();
          fetchLoyaltyRewards();
          fetchUnusedCodes();
        },
      );
    } finally {
      isRedeeming.value = false;
    }
  }
}
