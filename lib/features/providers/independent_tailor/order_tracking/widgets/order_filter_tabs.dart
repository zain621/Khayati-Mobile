import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// Horizontal filter tabs for order tracking.
/// Supports two themes: dark (inside green header) and light (white bg).
class OrderFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<OrderFilterItem> filters;

  /// When true, renders white pills on green background.
  final bool isDarkBackground;

  const OrderFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.filters,
    this.isDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: ManagerHeight.h10,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsetsDirectional.only(
          start: ManagerWidth.w16,
        ),
        child: Row(
          children: List.generate(filters.length, (index) {
            final filter = filters[index];
            final isSelected = index == selectedIndex;

            return Padding(
              padding: EdgeInsetsDirectional.only(
                end: ManagerWidth.w8,
              ),
              child: GestureDetector(
                onTap: () => onSelected(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12,
                    vertical: ManagerHeight.h8,
                  ),
                  decoration: BoxDecoration(
                    color: _backgroundColor(isSelected),
                    borderRadius: BorderRadius.circular(ManagerRadius.r24),
                
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: ManagerWidth.w130),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            filter.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: _textColor(isSelected),
                            ),
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w4),
                        Text(
                          '(${filter.count})',
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: _textColor(isSelected),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Color _backgroundColor(bool isSelected) {
    if (isDarkBackground) {
      return isSelected
          ? ManagerColors.white
          : ManagerColors.white.withOpacity(0.12);
    }
    return isSelected ? ManagerColors.primaryColor : ManagerColors.white;
  }

  // ignore: unused_element
  Color _borderColor(bool isSelected) {
    if (isDarkBackground) {
      return isSelected
          ? ManagerColors.white
          : ManagerColors.white.withOpacity(0.3);
    }
    return isSelected
        ? ManagerColors.primaryColor
        : ManagerColors.greyWhiteColor.withOpacity(0.3);
  }

  Color _textColor(bool isSelected) {
    if (isDarkBackground) {
      return isSelected
          ? ManagerColors.primaryColor
          : ManagerColors.white;
    }
    return isSelected ? ManagerColors.white : ManagerColors.greyWhiteColor;
  }
}

/// Data for a single filter tab.
class OrderFilterItem {
  final String label;
  final int count;

  const OrderFilterItem({
    required this.label,
    required this.count,
  });
}
