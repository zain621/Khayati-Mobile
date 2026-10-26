import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsTabBar
// Smooth sliding pill driven by TabController.animation
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsTabBar extends StatefulWidget {
  final TabController tabController;

  const OrderDetailsTabBar({
    super.key,
    required this.tabController,
  });

  @override
  State<OrderDetailsTabBar> createState() => _OrderDetailsTabBarState();
}

class _OrderDetailsTabBarState extends State<OrderDetailsTabBar> {
  @override
  void initState() {
    super.initState();
    widget.tabController.animation?.addListener(_onAnimate);
  }

  void _onAnimate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.tabController.animation?.removeListener(_onAnimate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final animVal = widget.tabController.animation?.value ?? 0.0;
    final isFirstSelected = animVal < 0.5;

    return Container(
      height: ManagerHeight.h50,
      decoration: BoxDecoration(
        color: const Color(0xFFEDEDED),
        borderRadius: BorderRadius.circular(ManagerRadius.r30),
      ),
      padding: EdgeInsets.all(ManagerWidth.w4),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pillWidth = constraints.maxWidth / 2;

          // In RTL: child[0] (Details) renders on the RIGHT.
          // animation 0.0 = tab 0 on the right → pillLeft = pillWidth
          // animation 1.0 = tab 1 on the left   → pillLeft = 0
          final pillLeft =
              isRtl ? pillWidth * (1.0 - animVal) : pillWidth * animVal;

          return Stack(
            children: [
              // ── Sliding pill ──────────────────────────────────────────
              Positioned(
                left: pillLeft,
                top: 0,
                bottom: 0,
                width: pillWidth,
                child: Container(
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor,
                    borderRadius: BorderRadius.circular(ManagerRadius.r26),
                    boxShadow: [
                      BoxShadow(
                        color:
                            ManagerColors.primaryColor.withValues(alpha: 0.28),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Tab labels ────────────────────────────────────────────
              Row(
                children: [
                  _TabLabel(
                    label: ManagerStrings.orderDetailsTabDetails,
                    icon: Icons.list_alt_rounded,
                    isSelected: isFirstSelected,
                    onTap: () => widget.tabController.animateTo(0),
                  ),
                  _TabLabel(
                    label: ManagerStrings.orderDetailsTabTracking,
                    icon: Icons.access_time_rounded,
                    isSelected: !isFirstSelected,
                    onTap: () => widget.tabController.animateTo(1),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// ── Private tab label ───────────────────────────────────────────────────────

class _TabLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabLabel({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: ManagerFontSize.s16,
                color: isSelected
                    ? ManagerColors.white
                    : ManagerColors.primaryColor,
              ),
              SizedBox(width: ManagerWidth.w6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 180),
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: isSelected
                      ? ManagerColors.white
                      : ManagerColors.primaryColor,
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
