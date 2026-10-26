import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WalletItemShimmer extends StatelessWidget {
  const WalletItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Shimmer.fromColors(
        baseColor: ManagerColors.greyWhiteColor.withOpacity(0.3),
        highlightColor: ManagerColors.greyWhiteColor.withOpacity(0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ManagerWidth.w120,
                  height: ManagerHeight.h16,
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
                Container(
                  width: ManagerWidth.w80,
                  height: ManagerHeight.h20,
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h8),
            Container(
              width: ManagerWidth.w160,
              height: ManagerHeight.h14,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
