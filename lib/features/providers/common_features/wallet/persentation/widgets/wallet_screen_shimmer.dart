import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WalletBalanceCardShimmer extends StatelessWidget {
  const WalletBalanceCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _WalletShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
          decoration: _cardDecoration(radius: ManagerRadius.r8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ManagerHeight.h14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          width: ManagerWidth.w120,
                          height: ManagerHeight.h12,
                        ),
                        SizedBox(height: ManagerHeight.h10),
                        _ShimmerBox(
                          width: ManagerWidth.w150,
                          height: ManagerHeight.h36,
                          radius: ManagerRadius.r8,
                        ),
                      ],
                    ),
                  ),
                  _ShimmerBox(
                    width: ManagerWidth.w42,
                    height: ManagerHeight.h42,
                    radius: ManagerRadius.r12,
                  ),
                ],
              ),
              SizedBox(height: ManagerHeight.h18),
              _ShimmerBox(height: 1, radius: ManagerRadius.r1),
              SizedBox(height: ManagerHeight.h18),
              _balanceRow(),
              SizedBox(height: ManagerHeight.h16),
              _balanceRow(),
              SizedBox(height: ManagerHeight.h14),
            ],
          ),
        ),
      ),
    );
  }

  Widget _balanceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _ShimmerBox(width: ManagerWidth.w130, height: ManagerHeight.h12),
        _ShimmerBox(width: ManagerWidth.w72, height: ManagerHeight.h14),
      ],
    );
  }
}

class WalletActionButtonShimmer extends StatelessWidget {
  const WalletActionButtonShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return _WalletShimmer(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        child: _ShimmerBox(
          height: ManagerHeight.h46,
          radius: ManagerRadius.r5,
        ),
      ),
    );
  }
}

class WalletTransactionsListShimmer extends StatelessWidget {
  final int itemCount;

  const WalletTransactionsListShimmer({
    super.key,
    this.itemCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    return _WalletShimmer(
      child: Column(
        children: List.generate(
          itemCount,
          (index) => Padding(
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w16,
              index == 0 ? 0 : ManagerHeight.h12,
              ManagerWidth.w16,
              0,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h16,
              ),
              decoration: _cardDecoration(radius: ManagerRadius.r12),
              child: Row(
                children: [
                  _ShimmerBox(
                    width: ManagerWidth.w34,
                    height: ManagerHeight.h34,
                    radius: ManagerRadius.r12,
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShimmerBox(
                          width: ManagerWidth.w130,
                          height: ManagerHeight.h12,
                        ),
                        SizedBox(height: ManagerHeight.h8),
                        _ShimmerBox(
                          width: ManagerWidth.w90,
                          height: ManagerHeight.h10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  _ShimmerBox(
                    width: ManagerWidth.w64,
                    height: ManagerHeight.h16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WalletShimmer extends StatelessWidget {
  final Widget child;

  const _WalletShimmer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE8E8E8),
      highlightColor: const Color(0xFFF6F6F6),
      child: child,
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final double? width;
  final double height;
  final double? radius;

  const _ShimmerBox({
    this.width,
    required this.height,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(radius ?? ManagerRadius.r6),
      ),
    );
  }
}

BoxDecoration _cardDecoration({required double radius}) {
  return BoxDecoration(
    color: ManagerColors.white,
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: ManagerColors.black.withValues(alpha: 0.05),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );
}
