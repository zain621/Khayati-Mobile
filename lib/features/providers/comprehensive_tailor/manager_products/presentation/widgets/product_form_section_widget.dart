import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// Reusable expandable section card for the add/edit product form.
class ProductFormSectionWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  /// Optional badge text shown when section is collapsed (e.g. "3 ألوان").
  final String? badge;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget content;

  const ProductFormSectionWidget({
    super.key,
    required this.icon,
    required this.title,
    this.badge,
    required this.isExpanded,
    required this.onToggle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: isExpanded
              ? ManagerColors.primaryColor.withOpacity(0.35)
              : const Color(0xFFEEEEEE),
          width: isExpanded ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isExpanded
                ? ManagerColors.primaryColor.withOpacity(0.06)
                : Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header — always visible
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w16),
              child: Row(
                children: [
                  // Icon container
                  Container(
                    width: ManagerWidth.w40,
                    height: ManagerWidth.w40,
                    decoration: BoxDecoration(
                      color: isExpanded
                          ? ManagerColors.primaryColor
                          : const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(ManagerRadius.r10),
                    ),
                    child: Icon(
                      icon,
                      color: isExpanded
                          ? ManagerColors.white
                          : ManagerColors.greyWhiteColor,
                      size: ManagerFontSize.s18,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  // Title
                  Expanded(
                    child: Text(
                      title,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: isExpanded
                            ? ManagerColors.primaryColor
                            : ManagerColors.black,
                      ),
                    ),
                  ),
                  // Badge shown when collapsed
                  if (badge != null && !isExpanded) ...[
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w8,
                        vertical: ManagerHeight.h3,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(ManagerRadius.r12),
                      ),
                      child: Text(
                        badge!,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w8),
                  ],
                  // Expand / collapse arrow
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: isExpanded
                        ? ManagerColors.primaryColor
                        : ManagerColors.greyWhiteColor,
                    size: ManagerFontSize.s22,
                  ),
                ],
              ),
            ),
          ),
          // Animated content
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.only(
                left: ManagerWidth.w16,
                right: ManagerWidth.w16,
                bottom: ManagerHeight.h16,
              ),
              child: content,
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
            sizeCurve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}
