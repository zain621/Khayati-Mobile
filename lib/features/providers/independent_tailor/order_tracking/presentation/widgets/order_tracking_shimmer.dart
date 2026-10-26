import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class OrderTrackingShimmer extends StatelessWidget {
  const OrderTrackingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.25),
      highlightColor: ManagerColors.white,
      child: Column(
        children: [
          _headerShimmer(),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(height: ManagerHeight.h8),
              itemBuilder: (_, __) => _cardShimmer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerShimmer() {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(top: ManagerHeight.h16, bottom: ManagerHeight.h12),
      child: Column(
        children: [
          Container(
            width: ManagerWidth.w150,
            height: ManagerHeight.h20,
            decoration: BoxDecoration(
              color: ManagerColors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
          ),
          SizedBox(height: ManagerHeight.h12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.only(start: ManagerWidth.w16),
            child: Row(
              children: List.generate(6, (index) {
                return Padding(
                  padding: EdgeInsetsDirectional.only(end: ManagerWidth.w8),
                  child: Container(
                    width: ManagerWidth.w85,
                    height: ManagerHeight.h30,
                    decoration: BoxDecoration(
                      color: ManagerColors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(ManagerRadius.r24),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        children: [
          Container(
            height: ManagerHeight.h50,
            decoration: BoxDecoration(
              color: ManagerColors.backgroundTabBar,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ManagerRadius.r16),
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
            child: Row(
              children: [
                _box(ManagerWidth.w90, ManagerHeight.h14),
                const Spacer(),
                _box(ManagerWidth.w70, ManagerHeight.h14),
                SizedBox(width: ManagerWidth.w8),
                _box(ManagerWidth.w55, ManagerHeight.h24),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w14,
              vertical: ManagerHeight.h10,
            ),
            child: Row(
              children: [
                Container(
                  width: ManagerWidth.w48,
                  height: ManagerHeight.h48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ManagerColors.backgroundTabBar,
                  ),
                ),
                SizedBox(width: ManagerWidth.w8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _box(ManagerWidth.w110, ManagerHeight.h12),
                    SizedBox(height: ManagerHeight.h6),
                    _box(ManagerWidth.w80, ManagerHeight.h10),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _box(ManagerWidth.w70, ManagerHeight.h16),
                    SizedBox(height: ManagerHeight.h6),
                    _box(ManagerWidth.w90, ManagerHeight.h10),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
            child: Container(
              height: ManagerHeight.h54,
              decoration: BoxDecoration(
                color: ManagerColors.backgroundTabBar,
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
            ),
          ),
          SizedBox(height: ManagerHeight.h10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
            child: Row(
              children: [
                Expanded(child: _box(double.infinity, ManagerHeight.h40)),
                SizedBox(width: ManagerWidth.w10),
                Expanded(child: _box(double.infinity, ManagerHeight.h40)),
              ],
            ),
          ),
          SizedBox(height: ManagerHeight.h12),
        ],
      ),
    );
  }

  Widget _box(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ManagerColors.backgroundTabBar,
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
    );
  }
}
