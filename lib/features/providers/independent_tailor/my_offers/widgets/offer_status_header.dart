import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/my_offer_model.dart';
import 'package:flutter/material.dart';

/// Status header with solid accent left-border + tinted background.
class OfferStatusHeader extends StatelessWidget {
  final OfferStatus status;
  final String timeAgo;

  const OfferStatusHeader({
    super.key,
    required this.status,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    final cfg = _getConfig();

    return Container(
      decoration: BoxDecoration(
        color: cfg.bgColor,
        border: Border(
          bottom: BorderSide(
            color: cfg.accentColor.withOpacity(0.18),
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h10,
      ),
      child: Row(
        children: [
          /// Status badge (pill)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w10,
              vertical: ManagerHeight.h5,
            ),
            decoration: BoxDecoration(
              color: cfg.accentColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
              border: Border.all(
                color: cfg.accentColor.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  cfg.icon,
                  size: ManagerFontSize.s13,
                  color: cfg.accentColor,
                ),
                SizedBox(width: ManagerWidth.w5),
                Text(
                  cfg.label,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: cfg.accentColor,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          /// Date chip
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
              SizedBox(width: ManagerWidth.w4),
              Text(
                timeAgo,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _OfferStatusConfig _getConfig() {
    switch (status) {
      case OfferStatus.accepted:
        return _OfferStatusConfig(
          bgColor: const Color(0xFFF0FBF4),
          accentColor: const Color(0xFF1A7A4A),
          icon: Icons.check_circle_rounded,
          label: ManagerStrings.myOffersStatusAccepted,
        );
      case OfferStatus.underReview:
        return _OfferStatusConfig(
          bgColor: const Color(0xFFFFFAF0),
          accentColor: const Color(0xFFD48A0C),
          icon: Icons.hourglass_top_rounded,
          label: ManagerStrings.myOffersStatusUnderReview,
        );
      case OfferStatus.rejected:
        return _OfferStatusConfig(
          bgColor: const Color(0xFFFFF5F5),
          accentColor: const Color(0xFFCC3333),
          icon: Icons.highlight_off_rounded,
          label: ManagerStrings.myOffersStatusRejected,
        );
    }
  }
}

class _OfferStatusConfig {
  final Color bgColor;
  final Color accentColor;
  final IconData icon;
  final String label;

  const _OfferStatusConfig({
    required this.bgColor,
    required this.accentColor,
    required this.icon,
    required this.label,
  });
}
