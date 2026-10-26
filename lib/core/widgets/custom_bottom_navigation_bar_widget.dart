import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_fonts.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

/// Custom Bottom Navigation Bar Item Model
/// Represents a single navigation item with icon and label
class CustomBottomNavItem {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const CustomBottomNavItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

/// Custom Bottom Navigation Bar Widget
/// Professional and fully customizable bottom navigation with FAB support
///
/// Features:
/// - Smooth animations and transitions
/// - FAB button with notch support
/// - Fully customizable colors, sizes, and spacing
/// - RTL support
/// - Professional shadow and elevation
/// - Responsive sizing using Manager* classes
///
/// Example:
/// ```dart
/// CustomBottomNavigationBar(
///   currentIndex: 0,
///   items: [
///     CustomBottomNavItem(icon: 'path/to/icon.svg', label: 'Home', onTap: () {}),
///     CustomBottomNavItem(icon: 'path/to/icon.svg', label: 'Sales', onTap: () {}),
///   ],
///   fabIcon: Icons.add,
///   onFabTap: () {},
/// )
/// ```
class CustomBottomNavigationBar extends StatelessWidget {
  // Required Parameters
  final int currentIndex;
  final List<CustomBottomNavItem> items;

  // FAB Configuration
  final Widget? fabIcon;
  final VoidCallback? onFabTap;
  final bool showFab;
  final double fabSize;
  final Color? fabColor;
  final Color? fabIconColor;
  final double fabElevation;

  // Colors
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? shadowColor;

  // Sizes
  final double? height;
  final double? iconSize;
  final double? fontSize;
  final double? notchMargin;
  final double? elevation;

  // Spacing
  final EdgeInsets? padding;
  final double itemSpacing;
  final double iconLabelSpacing;

  // Typography
  final FontWeight? activeFontWeight;
  final FontWeight? inactiveFontWeight;

  // Animation
  final Duration animationDuration;
  final Curve animationCurve;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.items,
    this.fabIcon,
    this.onFabTap,
    this.showFab = true,
    this.fabSize = 64,
    this.fabColor,
    this.fabIconColor,
    this.fabElevation = 8,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.shadowColor,
    this.height,
    this.iconSize,
    this.fontSize,
    this.notchMargin = 8,
    this.elevation = 8,
    this.padding,
    this.itemSpacing = 0,
    this.iconLabelSpacing = 4,
    this.activeFontWeight,
    this.inactiveFontWeight,
    this.animationDuration = const Duration(milliseconds: 300),
    this.animationCurve = Curves.easeInOut,
  }) : assert(
         items.length >= 2 && items.length <= 5,
         'Items count must be between 2 and 5',
       ),
       assert(
         items.length % 2 == 0 || !showFab,
         'Items count must be even when showFab is true',
       );

  @override
  Widget build(BuildContext context) {
    // Effective values with defaults
    final effectiveBackgroundColor = ManagerColors.white;
    final effectiveActiveColor = activeColor ?? ManagerColors.primaryColor;
    final effectiveInactiveColor = inactiveColor ?? const Color(0xFF64748B);
    final effectiveShadowColor =
        shadowColor ?? const Color(0xFF94A3B8).withOpacity(0.15);
    final effectiveHeight = height ?? 80.0;
    final effectiveIconSize = iconSize ?? ManagerHeight.h24;
    final effectiveFontSize = fontSize ?? ManagerFontSize.s10;
    final effectiveActiveFontWeight = activeFontWeight ?? FontWeight.w700;
    final effectiveInactiveFontWeight = inactiveFontWeight ?? FontWeight.w500;
    final effectivePadding =
        padding ??
        EdgeInsets.symmetric(
          horizontal: ManagerWidth.w12,
          vertical: ManagerHeight.h8,
        );
    final effectiveFabColor = fabColor ?? ManagerColors.primaryColor;
    final effectiveFabIconColor = fabIconColor ?? Colors.white;
    final effectiveElevation = elevation ?? 8.0;
    final effectiveNotchMargin = notchMargin ?? 8.0;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          top: BorderSide(
            color: const Color(0xFFE2E8F0),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: effectiveShadowColor,
            blurRadius: effectiveElevation * 2.5,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // Custom Shape with Notch (if FAB is shown)
          if (showFab)
            Positioned.fill(
              child: CustomPaint(
                painter: _BottomNavPainter(
                  backgroundColor: effectiveBackgroundColor,
                  notchRadius: fabSize / 2 + effectiveNotchMargin,
                  elevation: effectiveElevation,
                  shadowColor: effectiveShadowColor,
                ),
              ),
            ),

          // Navigation Items
          SafeArea(
            top: false,
            child: Padding(
              padding: effectivePadding,
              child: Row(
                mainAxisAlignment: showFab
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.spaceEvenly,
                children: _buildNavItems(
                  context: context,
                  activeColor: effectiveActiveColor,
                  inactiveColor: effectiveInactiveColor,
                  iconSize: effectiveIconSize,
                  fontSize: effectiveFontSize,
                  activeFontWeight: effectiveActiveFontWeight,
                  inactiveFontWeight: effectiveInactiveFontWeight,
                ),
              ),
            ),
          ),

          // FAB Button
          if (showFab)
            Positioned(
              top: -(fabSize / 2),
              child: _buildFab(
                context: context,
                size: fabSize,
                color: effectiveFabColor,
                iconColor: effectiveFabIconColor,
                elevation: fabElevation,
              ),
            ),
        ],
      ),
    );
  }

  /// Build navigation items with proper spacing for FAB
  List<Widget> _buildNavItems({
    required BuildContext context,
    required Color activeColor,
    required Color inactiveColor,
    required double iconSize,
    required double fontSize,
    required FontWeight activeFontWeight,
    required FontWeight inactiveFontWeight,
  }) {
    final List<Widget> navItems = [];
    final int midPoint = items.length ~/ 2;

    for (int i = 0; i < items.length; i++) {
      // Add spacer in the middle for FAB
      if (showFab && i == midPoint) {
        navItems.add(SizedBox(width: fabSize + itemSpacing));
      }

      navItems.add(
        Expanded(
          child: _NavItemWidget(
            item: items[i],
            isActive: currentIndex == i,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            iconSize: iconSize,
            fontSize: fontSize,
            activeFontWeight: activeFontWeight,
            inactiveFontWeight: inactiveFontWeight,
            iconLabelSpacing: iconLabelSpacing,
            animationDuration: animationDuration,
            animationCurve: animationCurve,
          ),
        ),
      );
    }

    return navItems;
  }

  /// Build FAB button with press-scale animation
  Widget _buildFab({
    required BuildContext context,
    required double size,
    required Color color,
    required Color iconColor,
    required double elevation,
  }) {
    return _AnimatedFab(
      size: size,
      color: color,
      iconColor: iconColor,
      elevation: elevation,
      onTap: onFabTap,
      child: fabIcon ?? Icon(Icons.add, color: iconColor, size: size * 0.5),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// FAB with press-scale animation
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedFab extends StatefulWidget {
  final double size;
  final Color color;
  final Color iconColor;
  final double elevation;
  final VoidCallback? onTap;
  final Widget child;

  const _AnimatedFab({
    required this.size,
    required this.color,
    required this.iconColor,
    required this.elevation,
    required this.child,
    this.onTap,
  });

  @override
  State<_AnimatedFab> createState() => _AnimatedFabState();
}

class _AnimatedFabState extends State<_AnimatedFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1.0,
    );
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await _ctrl.reverse();
    widget.onTap?.call();
    _ctrl.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color,
                widget.color.withOpacity(0.82),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.40),
                blurRadius: widget.elevation * 2,
                spreadRadius: 1,
                offset: Offset(0, widget.elevation * 0.6),
              ),
            ],
          ),
          child: Center(child: widget.child),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Internal Navigation Item Widget
/// Active item: animated pill + scale-up icon + label
/// Inactive item: icon only with fade
class _NavItemWidget extends StatefulWidget {
  final CustomBottomNavItem item;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double iconSize;
  final double fontSize;
  final FontWeight activeFontWeight;
  final FontWeight inactiveFontWeight;
  final double iconLabelSpacing;
  final Duration animationDuration;
  final Curve animationCurve;

  const _NavItemWidget({
    required this.item,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.iconSize,
    required this.fontSize,
    required this.activeFontWeight,
    required this.inactiveFontWeight,
    required this.iconLabelSpacing,
    required this.animationDuration,
    required this.animationCurve,
  });

  @override
  State<_NavItemWidget> createState() => _NavItemWidgetState();
}

class _NavItemWidgetState extends State<_NavItemWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = Tween<double>(begin: 0.80, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    await _scaleController.reverse();
    widget.item.onTap();
    _scaleController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final bool active = widget.isActive;

    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ── Animated pill indicator ────────────────────────────────
              AnimatedContainer(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                height: widget.iconSize + ManagerHeight.h10,
                width: active
                    ? widget.iconSize * 2.8  // expanded pill
                    : widget.iconSize + ManagerHeight.h10,
                decoration: BoxDecoration(
                  color: active
                      ? widget.activeColor.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(ManagerRadius.r20),
                ),
                child: Center(
                  child: AnimatedScale(
                    scale: active ? 1.15 : 1.0,
                    duration: widget.animationDuration,
                    curve: widget.animationCurve,
                    child: CustomSvgImage(
                      path: widget.item.icon,
                      width: widget.iconSize,
                      height: widget.iconSize,
                      color: active ? widget.activeColor : widget.inactiveColor,
                    ),
                  ),
                ),
              ),

              SizedBox(height: widget.iconLabelSpacing),

              // ── Animated label ─────────────────────────────────────────
              AnimatedDefaultTextStyle(
                duration: widget.animationDuration,
                curve: widget.animationCurve,
                style: TextStyle(
                  fontFamily: ManagerFontFamily.fontFamily,
                  fontSize: widget.fontSize,
                  fontWeight: active
                      ? widget.activeFontWeight
                      : widget.inactiveFontWeight,
                  color: active
                      ? widget.activeColor
                      : widget.inactiveColor,
                ),
                child: AnimatedOpacity(
                  opacity: active ? 1.0 : 0.55,
                  duration: widget.animationDuration,
                  curve: widget.animationCurve,
                  child: Text(
                    widget.item.label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Custom Painter for Bottom Navigation with Notch
/// Draws the bottom bar with circular notch for FAB
class _BottomNavPainter extends CustomPainter {
  final Color backgroundColor;
  final double notchRadius;
  final double elevation;
  final Color shadowColor;

  _BottomNavPainter({
    required this.backgroundColor,
    required this.notchRadius,
    required this.elevation,
    required this.shadowColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // final shadowPaint = Paint()
      // ..color = shadowColor
      // ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation);

    final path = Path();

    // Notch configuration
    final notchCenterX = size.width / 2;
    final notchStartX = notchCenterX - notchRadius;
    final notchEndX = notchCenterX + notchRadius;

    // Start from left
    path.moveTo(0, 0);

    // Top edge to notch start
    path.lineTo(notchStartX, 0);

    // Semi-circular notch (stays at top level)
    path.arcToPoint(
      Offset(notchEndX, 0),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    // Top edge from notch end to right
    path.lineTo(size.width, 0);

    // Right edge
    path.lineTo(size.width, size.height);

    // Bottom edge
    path.lineTo(0, size.height);

    // Close path
    path.close();

    // Draw shadow
    // canvas.drawPath(path, shadowPaint);

    // Draw bar
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _BottomNavPainter oldDelegate) {
    return oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.notchRadius != notchRadius ||
        oldDelegate.elevation != elevation ||
        oldDelegate.shadowColor != shadowColor;
  }
}
