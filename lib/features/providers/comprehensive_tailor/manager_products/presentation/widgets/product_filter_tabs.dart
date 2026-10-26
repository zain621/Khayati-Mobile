import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:flutter/material.dart';

/// Data class for product filter items.
class ProductFilterItem {
  final String label;
  final int count;

  const ProductFilterItem({
    required this.label,
    required this.count,
  });
}

/// Clean filter tabs for the manager products screen.
class ProductFilterTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<ProductFilterItem> filters;
  final bool isDarkBackground;

  const ProductFilterTabs({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    required this.filters,
    this.isDarkBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h44,
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.all(ManagerWidth.w4),
      decoration: BoxDecoration(
        color: isDarkBackground
            ? ManagerColors.white.withOpacity(0.1)
            : ManagerColors.greyWhiteColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
      ),
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = index == selectedIndex;
          final filter = filters[index];

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: isSelected
                      ? ManagerColors.white
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: ManagerColors.black.withOpacity(0.08),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          filter.label,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: isSelected
                                ? ManagerColors.primaryColor
                                : (isDarkBackground
                                    ? ManagerColors.white.withOpacity(0.8)
                                    : ManagerColors.greyWhiteColor),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w4),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w6,
                          vertical: ManagerHeight.h2,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ManagerColors.primaryColor
                              : (isDarkBackground
                                  ? ManagerColors.white.withOpacity(0.2)
                                  : ManagerColors.greyWhiteColor.withOpacity(0.15)),
                          borderRadius: BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Text(
                          '${filter.count}',
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s10,
                            color: isSelected
                                ? ManagerColors.white
                                : (isDarkBackground
                                    ? ManagerColors.white.withOpacity(0.8)
                                    : ManagerColors.greyWhiteColor),
                          ),
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
    );
  }
}
