import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/widgets/custom_bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

/// Home Bottom Navigation Widget
/// Uses CustomBottomNavigationBar with full customization
/// Displays 4 items: Home, Sales, Purchases, More + FAB in center
class HomeBottomNav extends StatelessWidget {
  // Required Parameters
  final int currentIndex;
  final Function(int) onItemTapped;

  // FAB Configuration
  final VoidCallback? onFabTapped;
  final Color? fabColor;

  // Colors
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? inactiveColor;

  // Sizes
  final double? height;
  final double? iconSize;
  final double? fontSize;
  final double? elevation;

  // Spacing
  final EdgeInsets? padding;

  // Typography
  final FontWeight? selectedFontWeight;
  final FontWeight? unselectedFontWeight;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onItemTapped,
    this.onFabTapped,
    this.fabColor,
    this.backgroundColor,
    this.activeColor,
    this.inactiveColor,
    this.height,
    this.iconSize,
    this.fontSize,
    this.elevation,
    this.padding,
    this.selectedFontWeight,
    this.unselectedFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBottomNavigationBar(
      currentIndex: currentIndex,
      items: [
        CustomBottomNavItem(
          icon: ManagerIcons.homeIcon,
          label: ManagerStrings.userHomeNavHome,
          onTap: () => onItemTapped(0),
        ),
        CustomBottomNavItem(
          icon: ManagerIcons.ordersBottomIcon,
          label: ManagerStrings.userHomeNavOrders,
          onTap: () => onItemTapped(1),
        ),
        CustomBottomNavItem(
          icon: ManagerIcons.shopIcon,
          label: ManagerStrings.userHomeNavStore,
          onTap: () => onItemTapped(2),
        ),
        CustomBottomNavItem(
          icon: ManagerIcons.messagesBottomIcon,
          label: ManagerStrings.userHomeNavMessages,
          onTap: () => onItemTapped(3),
        ),
      ],
      // FAB Configuration
      showFab: true,
      fabSize: 64,
      fabIcon: const Icon(Icons.add, color: Colors.white, size: 32),
      onFabTap: onFabTapped,
      fabColor: fabColor ?? ManagerColors.primaryColor,
      fabIconColor: Colors.white,
      fabElevation: 8,
      // Colors
      backgroundColor: backgroundColor,
      activeColor: activeColor,
      inactiveColor: inactiveColor,
      // Sizes
      height: height ?? 80,
      iconSize: iconSize,
      fontSize: fontSize,
      elevation: elevation,
      notchMargin: 8,
      // Spacing
      padding: padding,
      itemSpacing: 0,
      iconLabelSpacing: 4,
      // Typography
      activeFontWeight: selectedFontWeight,
      inactiveFontWeight: unselectedFontWeight,
      // Animation
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
    );
  }
}
