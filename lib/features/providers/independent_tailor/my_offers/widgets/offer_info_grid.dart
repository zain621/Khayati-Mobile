import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// 2×2 info grid for offer cards.
/// Row 1: عرض | مدة التنفيذ
/// Row 2: المنافسون | ميزانية العميلة
class OfferInfoGrid extends StatelessWidget {
  final String formattedPrice;
  final int executionDays;
  final int competingOffers;
  final String budgetRange;

  const OfferInfoGrid({
    super.key,
    required this.formattedPrice,
    required this.executionDays,
    required this.competingOffers,
    required this.budgetRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h4,
      ),
      padding: EdgeInsets.all(ManagerWidth.w12),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundTabBar,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoCell(
                  icon: Icons.sell_rounded,
                  label: ManagerStrings.myOffersOfferPrice,
                  value: '$formattedPrice ${ManagerStrings.myOffersCurrency}',
                  accentColor: ManagerColors.primaryColor,
                ),
              ),
              _Divider(),
              Expanded(
                child: _InfoCell(
                  icon: Icons.schedule_rounded,
                  label: ManagerStrings.myOffersExecutionDuration,
                  value: '$executionDays ${ManagerStrings.myOffersDays}',
                  accentColor: const Color(0xFFD48A0C),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
            child: Divider(
              height: 1,
              thickness: 1,
              color: ManagerColors.greyWhiteColor.withOpacity(0.15),
            ),
          ),

          Row(
            children: [
              Expanded(
                child: _InfoCell(
                  icon: Icons.groups_2_outlined,
                  label: ManagerStrings.myOffersDetails,
                  value:
                      '$competingOffers ${ManagerStrings.myOffersCompetingOffers}',
                  accentColor: const Color(0xFF5B6EBF),
                ),
              ),
              _Divider(),
              Expanded(
                child: _InfoCell(
                  icon: Icons.account_balance_wallet_rounded,
                  label: ManagerStrings.myOffersBudget,
                  value: '$budgetRange ${ManagerStrings.myOffersCurrency}',
                  accentColor: const Color(0xFF2E7D9A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Thin vertical divider between a row's two cells.
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
      color: ManagerColors.greyWhiteColor.withOpacity(0.15),
    );
  }
}

/// Compact info cell — colored icon + label on top, bold value below.
class _InfoCell extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color accentColor;

  const _InfoCell({
    required this.icon,
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: ManagerFontSize.s12,
                  color: accentColor,
                ),
              ),
              SizedBox(width: ManagerWidth.w6),
              Flexible(
                child: Text(
                  label,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h6),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
