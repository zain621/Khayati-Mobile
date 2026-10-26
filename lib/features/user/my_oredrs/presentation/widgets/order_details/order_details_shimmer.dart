import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsShimmer
//
// Full-page placeholder shown while the order detail is loading.
// Mirrors the real layout: summary card → tab bar → detail cards.
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsShimmer extends StatelessWidget {
  const OrderDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8E8E8),
      highlightColor: const Color(0xFFF5F5F5),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Summary card ────────────────────────────────────────────
            _ShimmerBox(height: 180, radius: ManagerRadius.r16),
            SizedBox(height: ManagerHeight.h16),

            // ── Tab bar ─────────────────────────────────────────────────
            _ShimmerBox(height: 50, radius: ManagerRadius.r30),
            SizedBox(height: ManagerHeight.h20),

            // ── Detail card 1 (product / zoqak) ─────────────────────────
            _ShimmerBox(height: 200, radius: ManagerRadius.r16),
            SizedBox(height: ManagerHeight.h16),

            // ── Detail card 2 (items / tailor) ───────────────────────────
            _ShimmerBox(height: 140, radius: ManagerRadius.r16),
            SizedBox(height: ManagerHeight.h16),

            // ── Price footer ─────────────────────────────────────────────
            _ShimmerBox(height: 56, radius: ManagerRadius.r12),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helper
// ─────────────────────────────────────────────────────────────────────────────

class _ShimmerBox extends StatelessWidget {
  final double height;
  final double radius;

  const _ShimmerBox({required this.height, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
