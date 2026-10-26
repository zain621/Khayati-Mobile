import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

const Color _kBase      = Color(0xFFE8E8E8);
const Color _kHighlight = Color(0xFFF5F5F5);

/// Full-screen shimmer skeleton that mirrors the comprehensive-tailor home layout.
class ComprehensiveHomeShimmer extends StatelessWidget {
  const ComprehensiveHomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: Column(
        children: [
          // Header skeleton
          Container(
            width: double.infinity,
            height: ManagerHeight.h148,
            color: ManagerColors.primaryColor.withOpacity(0.5),
          ),

          SizedBox(height: ManagerHeight.h16),

          // Balance card skeleton
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: _box(height: ManagerHeight.h147),
          ),

          SizedBox(height: ManagerHeight.h20),

          // Action cards skeleton — 2 rows of 2
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(child: _box(height: ManagerHeight.h156)),
                    SizedBox(width: ManagerWidth.w12),
                    Expanded(child: _box(height: ManagerHeight.h156)),
                  ],
                ),
                SizedBox(height: ManagerHeight.h12),
                Row(
                  children: [
                    Expanded(child: _box(height: ManagerHeight.h156)),
                    SizedBox(width: ManagerWidth.w12),
                    Expanded(child: _box(height: ManagerHeight.h156)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _box({required double height}) => Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r6),
        ),
      );
}
