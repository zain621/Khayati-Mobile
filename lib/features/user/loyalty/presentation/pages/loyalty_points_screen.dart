import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/user/loyalty/domain/di/di.dart';
import 'package:app_mobile/features/user/loyalty/domain/model/loyalty_reward_model.dart';
import 'package:app_mobile/features/user/loyalty/domain/model/unused_loyalty_code_model.dart';
import 'package:app_mobile/features/user/loyalty/presentation/controller/loyalty_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LoyaltyPointsScreen extends StatefulWidget {
  const LoyaltyPointsScreen({super.key});

  @override
  State<LoyaltyPointsScreen> createState() => _LoyaltyPointsScreenState();
}

class _LoyaltyPointsScreenState extends State<LoyaltyPointsScreen> {
  late final LoyaltyController controller;

  @override
  void initState() {
    super.initState();
    initLoyalty();
    controller = Get.find<LoyaltyController>();

    // React to successful redeem — show celebration dialog
    ever(controller.lastRedeemCode, (String? code) {
      if (code != null && code.isNotEmpty && mounted) {
        HapticFeedback.heavyImpact();
        Future.delayed(const Duration(milliseconds: 120), () {
          HapticFeedback.mediumImpact();
        });
        _showRedeemSuccessDialog(code);
      }
    });
  }

  void _showRedeemSuccessDialog(String code) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black54,
      builder: (_) => _RedeemSuccessDialog(code: code),
    ).then((_) {
      // Reset so ever() fires again next redeem
      controller.lastRedeemCode.value = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseAppScaffold(
          title: ManagerStrings.loyaltyScreenTitle,
          subtitle: ManagerStrings.loyaltyScreenSubtitle,
          onRefresh: controller.refreshLoyalty,
          child: Obx(() {
        // â”€â”€ Initial load OR pull-to-refresh: show full-screen shimmer â”€â”€â”€â”€â”€â”€â”€â”€
        final bool isInitialLoad =
            (controller.isLoadingPoints.value ||
                controller.isLoadingRewards.value ||
                controller.isLoadingUnusedCodes.value) &&
            controller.loyaltyPoints.value.points == 0 &&
            controller.rewards.isEmpty &&
            controller.unusedCodes.isEmpty;

        if (isInitialLoad || controller.isRefreshing.value) return const _LoyaltyShimmer();

        // â”€â”€ Data loaded: show real content â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
        return Column(
          children: [
            // â”€â”€ Header: image + points balance card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            SizedBox(
              height: ManagerHeight.h232,
              child: Stack(
                children: [
                  // Background loyalty image
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                      child: Image.asset(
                        ManagerImages.loyaltyPointsImage,
                        height: ManagerHeight.h193,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Points balance card
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w24),
                      child: Container(
                        height: ManagerHeight.h79,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r34),
                          color: ManagerColors.white,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  const Color(0xFF1C1E45).withOpacity(0.1),
                              blurRadius: 35,
                              offset: const Offset(10, 0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w16),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              // Left: label + date
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ManagerStrings.loyaltyBalanceLabel,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s20,
                                      color: ManagerColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(height: ManagerHeight.h6),
                                  Text(
                                    DateFormat('d/M/yyyy')
                                        .format(DateTime.now()),
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s12,
                                      color: ManagerColors.greyWhiteColor,
                                    ),
                                  ),
                                ],
                              ),

                              // Right: points count
                              Row(
                                crossAxisAlignment:
                                    CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${controller.loyaltyPoints.value.points}',
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s30,
                                      color:
                                          ManagerColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: ManagerWidth.w4),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: ManagerHeight.h4),
                                    child: Text(
                                      ManagerStrings.loyaltyPointUnit,
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s16,
                                        color:
                                            ManagerColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: ManagerHeight.h14),

            // â”€â”€ Available rewards header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: Container(
                height: ManagerHeight.h70,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius:
                      BorderRadius.circular(ManagerRadius.r12),
                  boxShadow: [
                    BoxShadow(
                      color: ManagerColors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
                  child: Row(
                    children: [
                      Container(
                        height: ManagerHeight.h48,
                        width: ManagerWidth.w48,
                        decoration: BoxDecoration(
                          color:
                              ManagerColors.primaryColor.withOpacity(0.04),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Icon(
                          Icons.card_giftcard_rounded,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ManagerStrings.loyaltyAvailableRewards,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h4),
                          Text(
                            ManagerStrings.loyaltyAvailableRewardsSub,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h14),

            // â”€â”€ Rewards list â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
            if (controller.rewards.isEmpty && !controller.isLoadingRewards.value)
              const _EmptyRewardsWidget()
            else
              ...controller.rewards.map(
                (reward) => Padding(
                  padding: EdgeInsets.only(
                    left: ManagerWidth.w16,
                    right: ManagerWidth.w16,
                    bottom: ManagerHeight.h12,
                  ),
                  child: _RewardCard(
                    reward: reward,
                    userPoints:
                        controller.loyaltyPoints.value.points,
                    isRedeeming: controller.isRedeeming.value,
                    onRedeem: () =>
                        controller.redeemReward(reward.id),
                  ),
                ),
              ),

            SizedBox(height: ManagerHeight.h14),

            // ── Unused codes header ──────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  boxShadow: [
                    BoxShadow(
                      color: ManagerColors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12,
                    vertical: ManagerHeight.h11,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ManagerWidth.w48,
                        height: ManagerHeight.h48,
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: const Icon(
                          Icons.confirmation_number_outlined,
                          color: ManagerColors.primaryColor,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ManagerStrings.loyaltyUnusedCodesTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h2),
                          Text(
                            ManagerStrings.loyaltyUnusedCodesSubtitle,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h14),

            // ── Unused codes list ────────────────────────────────────────
            if (controller.unusedCodes.isEmpty &&
                !controller.isLoadingUnusedCodes.value)
              const _EmptyUnusedCodesWidget()
            else
              ...controller.unusedCodes.map(
                (item) => Padding(
                  padding: EdgeInsets.only(
                    left: ManagerWidth.w16,
                    right: ManagerWidth.w16,
                    bottom: ManagerHeight.h12,
                  ),
                  child: _UnusedCodeCard(item: item),
                ),
              ),

            SizedBox(height: ManagerHeight.h24),
          ],
        );
      }),
        ),
        // ── Loading overlay while redeeming ─────────────────────────────
        Obx(() => controller.isRedeeming.value
            ? const LoadingWidget()
            : const SizedBox.shrink()),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Redeem Success Dialog — code display + celebration
// ══════════════════════════════════════════════════════════════════════════════

class _RedeemSuccessDialog extends StatefulWidget {
  final String code;
  const _RedeemSuccessDialog({required this.code});

  @override
  State<_RedeemSuccessDialog> createState() => _RedeemSuccessDialogState();
}

class _RedeemSuccessDialogState extends State<_RedeemSuccessDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _scale = CurvedAnimation(parent: _anim, curve: Curves.easeOutBack);
    _fade  = CurvedAnimation(parent: _anim, curve: Curves.easeOut);
    _anim.forward();
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: widget.code));
    HapticFeedback.selectionClick();
    AppSnackbar.success(ManagerStrings.loyaltyCodeCopied);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
      child: FadeTransition(
        opacity: _fade,
        child: ScaleTransition(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
              boxShadow: [
                BoxShadow(
                  color: ManagerColors.primaryColor.withOpacity(0.15),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: EdgeInsets.all(ManagerWidth.w24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Celebration icon ─────────────────────────────────────
                Container(
                  width: ManagerWidth.w72,
                  height: ManagerHeight.h72,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.celebration_rounded,
                    color: ManagerColors.primaryColor,
                    size: 36,
                  ),
                ),

                SizedBox(height: ManagerHeight.h16),

                // ── Title ────────────────────────────────────────────────
                Text(
                  ManagerStrings.loyaltyRedeemSuccess,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: ManagerHeight.h6),

                Text(
                  ManagerStrings.loyaltyRedeemDialogSubtitle,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: ManagerHeight.h20),

                // ── Code box ─────────────────────────────────────────────
                GestureDetector(
                  onTap: _copyCode,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w16,
                      vertical: ManagerHeight.h14,
                    ),
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(ManagerRadius.r10),
                      border: Border.all(
                        color: ManagerColors.primaryColor.withOpacity(0.25),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.code,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        const Icon(
                          Icons.copy_rounded,
                          color: ManagerColors.primaryColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: ManagerHeight.h8),

                Text(
                  ManagerStrings.loyaltyCodeTapToCopy,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: ManagerHeight.h20),

                // ── Close button ─────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ManagerColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ManagerRadius.r10),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: ManagerHeight.h12),
                      elevation: 0,
                    ),
                    child: Text(
                      ManagerStrings.close,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Reward Card Widget
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _RewardCard extends StatelessWidget {
  final LoyaltyRewardModel reward;
  final int userPoints;
  final bool isRedeeming;
  final VoidCallback onRedeem;

  const _RewardCard({
    required this.reward,
    required this.userPoints,
    required this.isRedeeming,
    required this.onRedeem,
  });

  @override
  Widget build(BuildContext context) {
    final bool canRedeem =
        reward.isActive && userPoints >= reward.pointsRequired;

    final String discountLabel = reward.discountType == 'percentage'
        ? '${ManagerStrings.loyaltyDiscountPercent} ${reward.discountValue.toStringAsFixed(0)}'
        : '${ManagerStrings.loyaltyDiscountFixed} ${reward.discountValue.toStringAsFixed(0)}';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h14,
        ),
        child: Row(
          children: [
            // Icon
            CustomSvgImage(
              path: ManagerIcons.giftIcon,
              height: ManagerHeight.h28,
              width: ManagerWidth.w28,
              color: canRedeem
                  ? ManagerColors.primaryColor
                  : ManagerColors.greyWhiteColor,
            ),
            SizedBox(width: ManagerWidth.w10),

            // Title + points required
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text(
                        discountLabel,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.black,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w4),
                      Image.asset(
                        ManagerIcons.dirhamIcon,
                        width: 14,
                        height: 14,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  Text(
                    '${reward.pointsRequired} ${ManagerStrings.loyaltyPointsRequired}',
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: canRedeem
                          ? ManagerColors.primaryColor
                          : ManagerColors.greyWhiteColor,
                    ),
                  ),
                ],
              ),
            ),

            // Redeem button
            GestureDetector(
              onTap: canRedeem && !isRedeeming ? onRedeem : null,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12,
                  vertical: ManagerHeight.h4,
                ),
                height: ManagerHeight.h27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ManagerRadius.r6),
                  border: Border.all(
                    color: canRedeem
                        ? ManagerColors.primaryColor
                        : ManagerColors.greyWhiteColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: isRedeeming
                      ? SizedBox(
                          width: ManagerWidth.w14,
                          height: ManagerHeight.h14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ManagerColors.primaryColor,
                          ),
                        )
                      : Text(
                          ManagerStrings.loyaltyRedeemButton,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: canRedeem
                                ? ManagerColors.primaryColor
                                : ManagerColors.greyWhiteColor,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// Empty rewards state
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _EmptyRewardsWidget extends StatelessWidget {
  const _EmptyRewardsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h40,
        horizontal: ManagerWidth.w24,
      ),
      child: Column(
        children: [
          Icon(
            Icons.card_giftcard_rounded,
            size: ManagerHeight.h60,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(height: ManagerHeight.h12),
          Text(
            ManagerStrings.loyaltyEmptyRewards,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ManagerHeight.h6),
          Text(
            ManagerStrings.loyaltyEmptyRewardsSub,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}


// ─────────────────────────────────────────────────────────────────────────────
// Unused Code Card
// ─────────────────────────────────────────────────────────────────────────────
class _UnusedCodeCard extends StatelessWidget {
  final UnusedLoyaltyCodeModel item;

  const _UnusedCodeCard({required this.item});

  void _copyCode(BuildContext context) {
    Clipboard.setData(ClipboardData(text: item.code));
    HapticFeedback.selectionClick();
    AppSnackbar.success(
      ManagerStrings.loyaltyUnusedCodeCopied,
      englishMessage: ManagerStrings.loyaltyUnusedCodeCopiedEn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final String discountLabel = item.discountType == 'percentage'
        ? ManagerStrings.loyaltyDiscountPercent + ' ' + item.discountValue.toStringAsFixed(0)
        : ManagerStrings.loyaltyDiscountFixed + ' ' + item.discountValue.toStringAsFixed(0) + ' ' + ManagerStrings.loyaltyUnusedCodesCurrency;

    String formattedDate = item.createdAt;
    try {
      formattedDate = DateFormat('yyyy/MM/dd').format(DateTime.parse(item.createdAt).toLocal());
    } catch (_) {}

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.rewardTitleAr,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.black,
                    ),
                  ),
                ),
                SizedBox(width: ManagerWidth.w8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w8,
                    vertical: ManagerHeight.h3,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(ManagerRadius.r6),
                  ),
                  child: Text(
                    discountLabel,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h8),
            GestureDetector(
              onTap: () => _copyCode(context),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12,
                  vertical: ManagerHeight.h10,
                ),
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  border: Border.all(
                    color: ManagerColors.primaryColor.withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.code,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    const Icon(
                      Icons.copy_rounded,
                      color: ManagerColors.primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h6),
            Text(
              formattedDate,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty unused codes state
// ─────────────────────────────────────────────────────────────────────────────
class _EmptyUnusedCodesWidget extends StatelessWidget {
  const _EmptyUnusedCodesWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h32,
        horizontal: ManagerWidth.w24,
      ),
      child: Column(
        children: [
          Icon(
            Icons.confirmation_number_outlined,
            size: ManagerHeight.h48,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(height: ManagerHeight.h10),
          Text(
            ManagerStrings.loyaltyUnusedCodesEmpty,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            ManagerStrings.loyaltyUnusedCodesEmptySub,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// Shimmer colours â€” same palette as home_shimmer_widget.dart
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
const Color _kShimmerBase      = Color(0xFFE8E8E8);
const Color _kShimmerHighlight = Color(0xFFF5F5F5);

// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
// _LoyaltyShimmer
//
// Layout mirrors the real screen section-by-section (no Stack overlap):
//   1. Image banner  (h155, r16)
//   2. Balance card  (h79, r34)
//   3. Rewards header (h70, r12)
//   4. 3 Ã— Reward card skeleton
// â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•â•
class _LoyaltyShimmer extends StatelessWidget {
  const _LoyaltyShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kShimmerBase,
      highlightColor: _kShimmerHighlight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // â”€â”€ 1. Image banner â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          // Sequential (NOT overlapping) so the card below reads as its own
          // element.  ClipRRect mirrors the rounded image in the real screen.
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ManagerRadius.r16),
              child: Container(
                height: ManagerHeight.h155,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h10),

          // â”€â”€ 2. Balance card â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          // Matches: Container(h79, r34, shadow) padded symmetric w24.
          // Inner Row mirrors exactly the real Row(spaceBetween) content.
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
            child: Container(
              height: ManagerHeight.h79,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r34),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1C1E45).withOpacity(0.10),
                    blurRadius: 35,
                    offset: const Offset(10, 0),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    // Left â€” label (bold s20 â‰ˆ h22) + date (regular s12 â‰ˆ h14)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                            width: ManagerWidth.w155,
                            height: ManagerHeight.h22),
                        SizedBox(height: ManagerHeight.h6),
                        _ShimmerBox(
                            width: ManagerWidth.w80,
                            height: ManagerHeight.h14),
                      ],
                    ),
                    // Right â€” points (bold s30 â‰ˆ h34) + "Ù†Ù‚Ø·Ø©" (bold s16 â‰ˆ h18)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _ShimmerBox(
                            width: ManagerWidth.w55,
                            height: ManagerHeight.h34),
                        SizedBox(width: ManagerWidth.w4),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ManagerHeight.h4),
                          child: _ShimmerBox(
                              width: ManagerWidth.w36,
                              height: ManagerHeight.h18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // â”€â”€ 3. Available-rewards header â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          // Matches: Container(h70, r12, shadow) padded symmetric w16.
          // Inner Row mirrors: icon-box (h48Ã—w48, r4) + Column(title + sub).
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Container(
              height: ManagerHeight.h70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12),
                child: Row(
                  children: [
                    // Icon container â€” h48/w48, r4
                    _ShimmerBox(
                      width: ManagerWidth.w48,
                      height: ManagerHeight.h48,
                      radius: ManagerRadius.r4,
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    // Title (bold s14 â‰ˆ h16) + subtitle (regular s12 â‰ˆ h14)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                            width: ManagerWidth.w110,
                            height: ManagerHeight.h16),
                        SizedBox(height: ManagerHeight.h4),
                        _ShimmerBox(
                            width: ManagerWidth.w145,
                            height: ManagerHeight.h14),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // â”€â”€ 4. Reward card skeletons (3 cards) â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
          ...List.generate(
            3,
            (_) => Padding(
              padding: EdgeInsets.only(
                left: ManagerWidth.w16,
                right: ManagerWidth.w16,
                bottom: ManagerHeight.h12,
              ),
              child: const _RewardCardSkeleton(),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),
        ],
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// _RewardCardSkeleton
//
// Mirrors _RewardCard exactly:
//   Container(r12, shadow)
//   â””â”€ Padding(h14, w16)
//      â””â”€ Row:
//           gift icon (h28Ã—w28)
//           SizedBox(w10)
//           Expanded Column:
//             Row [ discount label (bold s14) + SizedBox(w4) + raylIcon (w14) ]
//             SizedBox(h4)
//             points text (regular s12)
//           button Container(h27, r6, border 2px, padding h4/w12)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _RewardCardSkeleton extends StatelessWidget {
  const _RewardCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h14,
        ),
        child: Row(
          children: [
            // Gift icon â€” CustomSvgImage h28/w28
            _ShimmerBox(
              width: ManagerWidth.w28,
              height: ManagerHeight.h28,
              radius: ManagerRadius.r6,
            ),
            SizedBox(width: ManagerWidth.w10),

            // Expanded Column (crossAxis: start, mainAxis: center)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Row: discount label bold s14 + SizedBox(w4) + raylIcon ~w14
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ShimmerBox(
                          width: ManagerWidth.w85,
                          height: ManagerHeight.h16),
                      SizedBox(width: ManagerWidth.w4),
                      _ShimmerBox(
                        width: ManagerWidth.w14,
                        height: ManagerHeight.h14,
                        radius: ManagerRadius.r4,
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  // Points required â€” regular s12
                  _ShimmerBox(
                      width: ManagerWidth.w105,
                      height: ManagerHeight.h13),
                ],
              ),
            ),

            // Redeem button â€” matches Container(h27, r6, border 2px,
            //   padding: symmetric(horizontal: w12, vertical: h4))
            Container(
              height: ManagerHeight.h27,
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w12,
                vertical: ManagerHeight.h4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r6),
                border: Border.all(color: _kShimmerBase, width: 2),
              ),
              child: Center(
                child: _ShimmerBox(
                    width: ManagerWidth.w55,
                    height: ManagerHeight.h13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
// _ShimmerBox â€” reusable filled rectangle (colour masked by Shimmer gradient)
// â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

