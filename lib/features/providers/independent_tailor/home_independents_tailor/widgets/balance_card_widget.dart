import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// Dark gradient balance card showing available withdrawal amount.
class BalanceCardWidget extends StatelessWidget {
  /// Optionally supply real balance from API; falls back to the hardcoded string.
  final double? withdrawableBalance;

  /// Optionally supply a formatted date string (DD-MM-YYYY) from the controller.
  final String? lastLoginFormatted;

  const BalanceCardWidget({
    super.key,
    this.withdrawableBalance,
    this.lastLoginFormatted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h147,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ManagerRadius.r5),
        color: ManagerColors.primaryColor,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(
              ManagerImages.homeBalanceBackground1,
              width: ManagerWidth.w76,
              height: ManagerHeight.h88,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              ManagerImages.homeBalanceBackground2,
              width: ManagerWidth.w80,
              height: ManagerHeight.h65,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ManagerHeight.h12),
                Text(
                  ManagerStrings.homeBalanceTitle,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.white,
                  ),
                ),
                SizedBox(height: ManagerHeight.h12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      withdrawableBalance != null
                          ? withdrawableBalance!.toStringAsFixed(0)
                          : ManagerStrings.homeBalanceAmount,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s48,
                        color: ManagerColors.white,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w6),
                    Padding(
                      padding: EdgeInsets.only(bottom: ManagerHeight.h10),
                      child: Text(
                        ManagerStrings.homeBalanceCurrency,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ManagerHeight.h12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      ManagerStrings.homeLastLogin,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s10,
                        color: ManagerColors.white,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w4),
                    Text(
                      lastLoginFormatted ?? "14-08-2025",
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s10,
                        color: ManagerColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
