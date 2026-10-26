import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Full-screen shimmer placeholder that mirrors the exact provider-profile
/// scrollable layout:
///   • Section header  +  3-item menu card  (Account)
///   • Section header  +  2-item menu card  (Work settings)
///   • Section header  +  4-item menu card  (App info)
///   • Logout button placeholder
class ProviderProfileShimmerWidget extends StatelessWidget {
  const ProviderProfileShimmerWidget({super.key});

  static const Color _base      = Color(0xFFE0E0E0);
  static const Color _highlight = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _base,
      highlightColor: _highlight,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section: Account (الحساب) ── 3 items ────────────────────
            _sectionHeader(lineWidth: ManagerWidth.w100),
            SizedBox(height: ManagerHeight.h8),
            _menuCard(itemCount: 3),

            SizedBox(height: ManagerHeight.h20),

            // ── Section: Work Settings (إعدادات العمل) ── 2 items ────────
            _sectionHeader(lineWidth: ManagerWidth.w120),
            SizedBox(height: ManagerHeight.h8),
            _menuCard(itemCount: 2),

            SizedBox(height: ManagerHeight.h20),

            // ── Section: App Info (معلومات التطبيق) ── 4 items ───────────
            _sectionHeader(lineWidth: ManagerWidth.w100),
            SizedBox(height: ManagerHeight.h8),
            _menuCard(itemCount: 4),

            SizedBox(height: ManagerHeight.h24),

            // ── Logout button ─────────────────────────────────────────────
            _box(
              width: double.infinity,
              height: ManagerHeight.h44,
              radius: ManagerRadius.r16,
            ),

            SizedBox(height: ManagerHeight.h16),
          ],
        ),
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  /// Rounded rectangle placeholder.
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

  /// Mirrors `_SectionHeader`: small icon box + text line.
  Widget _sectionHeader({required double lineWidth}) {
    return Row(
      children: [
        _box(
          width: ManagerHeight.h16,
          height: ManagerHeight.h16,
          radius: ManagerRadius.r4,
        ),
        SizedBox(width: ManagerWidth.w6),
        _box(
          width: lineWidth,
          height: ManagerHeight.h14,
          radius: ManagerRadius.r4,
        ),
      ],
    );
  }

  /// Mirrors `_ProfileMenuCard` with [itemCount] rows, each row being a
  /// `_MenuItem` (icon box + two text lines + arrow placeholder), separated
  /// by thin dividers.
  Widget _menuCard({required int itemCount}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        children: List.generate(itemCount, (i) {
          final isLast = i == itemCount - 1;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w14,
                  vertical: ManagerHeight.h14,
                ),
                child: Row(
                  children: [
                    // Icon box placeholder
                    _box(
                      width: ManagerWidth.w42,
                      height: ManagerHeight.h42,
                      radius: ManagerRadius.r8,
                    ),
                    SizedBox(width: ManagerWidth.w12),
                    // Title + subtitle placeholder
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _box(
                            width: double.infinity,
                            height: ManagerHeight.h14,
                            radius: ManagerRadius.r4,
                          ),
                          SizedBox(height: ManagerHeight.h8),
                          _box(
                            width: ManagerWidth.w120,
                            height: ManagerHeight.h12,
                            radius: ManagerRadius.r4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    // Arrow placeholder
                    _box(
                      width: ManagerHeight.h14,
                      height: ManagerHeight.h14,
                      radius: ManagerRadius.r4,
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 1,
                  margin: EdgeInsets.only(left: ManagerWidth.w68),
                  color: const Color(0xFFE0E0E0),
                ),
            ],
          );
        }),
      ),
    );
  }
}
