import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Full-screen shimmer placeholder that mirrors the exact profile layout.
class ProfileShimmerWidget extends StatelessWidget {
  const ProfileShimmerWidget({super.key});

  // Standard shimmer palette — clearly visible on a white background
  static const Color _base = Color(0xFFE0E0E0);
  static const Color _highlight = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _base,
      highlightColor: _highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Stats row — 3 equal cards ───────────────────────────────
              Row(
                children: [
                  Expanded(child: _box(height: ManagerHeight.h80, radius: ManagerRadius.r8)),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(child: _box(height: ManagerHeight.h80, radius: ManagerRadius.r8)),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(child: _box(height: ManagerHeight.h80, radius: ManagerRadius.r8)),
                ],
              ),

              SizedBox(height: ManagerHeight.h20),

              // ── Section header: small icon circle + label line ──────────
              _sectionHeader(lineWidth: ManagerWidth.w100),
              SizedBox(height: ManagerHeight.h8),

              // ── Account card — 3 items × h70 + 2 dividers ≈ h212 ───────
              _box(
                width: double.infinity,
                height: ManagerHeight.h212,
                radius: ManagerRadius.r16,
              ),

              SizedBox(height: ManagerHeight.h20),

              // ── Section header ──────────────────────────────────────────
              _sectionHeader(lineWidth: ManagerWidth.w120),
              SizedBox(height: ManagerHeight.h8),

              // ── App-info card — 4 items × h70 + 3 dividers ≈ h283 ──────
              _box(
                width: double.infinity,
                height: ManagerHeight.h283,
                radius: ManagerRadius.r16,
              ),

              SizedBox(height: ManagerHeight.h24),

              // ── Logout button ───────────────────────────────────────────
              _box(
                width: double.infinity,
                height: ManagerHeight.h44,
                radius: ManagerRadius.r16,
              ),

              SizedBox(height: ManagerHeight.h24),
            ],
          ),
        ),
      ),
    );
  }

  /// One shimmer box.
  Widget _box({
    double width = double.infinity,
    required double height,
    double? radius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius ?? ManagerRadius.r8),
      ),
    );
  }

  /// Mimics the Row(icon + label) of [_SectionHeader].
  Widget _sectionHeader({required double lineWidth}) {
    return Row(
      children: [
        // icon placeholder
        _box(width: ManagerHeight.h16, height: ManagerHeight.h16, radius: ManagerRadius.r4),
        SizedBox(width: ManagerWidth.w6),
        // text placeholder
        _box(width: lineWidth, height: ManagerHeight.h14, radius: ManagerRadius.r4),
      ],
    );
  }
}
