import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/my_offer_model.dart';
import 'package:flutter/material.dart';

/// Action buttons for offer cards — varies by OfferStatus.
/// - accepted  → green "متابعة الطلبات ←"
/// - underReview → "تعديل العرض ✏" + "سحب العرض ✕"
/// - rejected → grey "حذف 🗑"
class OfferActionButtons extends StatelessWidget {
  final OfferStatus status;
  final VoidCallback? onTrackOrders;
  final VoidCallback? onEditOffer;
  final VoidCallback? onWithdrawOffer;
  final VoidCallback? onDelete;

  const OfferActionButtons({
    super.key,
    required this.status,
    this.onTrackOrders,
    this.onEditOffer,
    this.onWithdrawOffer,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
      ),
      child: _buildByStatus(),
    );
  }

  Widget _buildByStatus() {
    switch (status) {
      case OfferStatus.accepted:
        return _TrackOrdersButton(onTap: onTrackOrders);
      case OfferStatus.underReview:
        return Row(
          children: [
            Expanded(
              child: _EditOfferButton(onTap: onEditOffer),
            ),
            SizedBox(width: ManagerWidth.w8),
            Expanded(
              child: _WithdrawOfferButton(onTap: onWithdrawOffer),
            ),
          ],
        );
      case OfferStatus.rejected:
        return _DeleteButton(onTap: onDelete);
    }
  }
}

// ──────────────────────────────────────────────────────────
// Button Sub‑Widgets
// ──────────────────────────────────────────────────────────

/// Full-width green filled button — "متابعة الطلبات ←"
class _TrackOrdersButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _TrackOrdersButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManagerColors.primaryColor,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: InkWell(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.track_changes_rounded,
                size: ManagerFontSize.s16,
                color: ManagerColors.white,
              ),
              SizedBox(width: ManagerWidth.w8),
              Text(
                ManagerStrings.myOffersTrackOrders,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.white,
                ),
              ),
              SizedBox(width: ManagerWidth.w6),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: ManagerFontSize.s12,
                color: ManagerColors.white.withOpacity(0.8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Green outlined button — "✏ تعديل العرض"
class _EditOfferButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _EditOfferButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: InkWell(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h11),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.edit_rounded,
                size: ManagerFontSize.s14,
                color: ManagerColors.white,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.myOffersEditOffer,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Red tinted button — "✖ سحب العرض"
class _WithdrawOfferButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _WithdrawOfferButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: InkWell(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h11),
          decoration: BoxDecoration(
            color: ManagerColors.redNew.withOpacity(0.08),
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            border: Border.all(
              color: ManagerColors.redNew.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.undo_rounded,
                size: ManagerFontSize.s14,
                color: ManagerColors.redNew,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.myOffersWithdrawOffer,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.redNew,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Grey neutral button — "🗑 حذف"
class _DeleteButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _DeleteButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: InkWell(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h11),
          decoration: BoxDecoration(
            color: ManagerColors.backgroundTabBar,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            border: Border.all(
              color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline_rounded,
                size: ManagerFontSize.s16,
                color: ManagerColors.greyWhiteColor,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.myOffersDelete,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
