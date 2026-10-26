import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

/// Reusable role selection card for provider registration step 1.
/// Icon-only badge (no photos).
class ProviderRoleCard extends StatelessWidget {
  final String svgIconPath;
  final String title;
  final String subtitle;
  final List<String> tags;
  final bool isSelected;
  final VoidCallback onTap;

  const ProviderRoleCard({
    super.key,
    required this.svgIconPath,
    required this.title,
    required this.subtitle,
    required this.tags,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(ManagerWidth.w12),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(
            color: isSelected
                ? ManagerColors.primaryColor.withOpacity(0.55)
                : ManagerColors.greyWhiteColor.withOpacity(0.18),
            width: isSelected ? 1.4 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: ManagerColors.primaryColor.withOpacity(0.1),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Icon badge only
            Container(
              width: ManagerWidth.w44,
              height: ManagerHeight.h44,
              decoration: BoxDecoration(
                color: isSelected
                    ? ManagerColors.primaryColor.withOpacity(0.12)
                    : ManagerColors.backgroundTabBar,
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              alignment: Alignment.center,
              child: CustomSvgImage(
                path: svgIconPath,
                width: ManagerWidth.w22,
                height: ManagerHeight.h22,
                color: isSelected
                    ? ManagerColors.primaryColor
                    : ManagerColors.greyWhiteColor,
              ),
            ),
            SizedBox(width: ManagerWidth.w12),

            /// Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  Text(
                    subtitle,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ManagerHeight.h8),
                  Wrap(
                    spacing: ManagerWidth.w6,
                    runSpacing: ManagerHeight.h4,
                    children: tags.map((tag) => _buildTag(tag)).toList(),
                  ),
                ],
              ),
            ),

            /// Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? ManagerColors.primaryColor
                      : ManagerColors.greyWhiteColor.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? ManagerColors.primaryColor.withOpacity(0.08)
            : ManagerColors.backgroundTabBar,
        borderRadius: BorderRadius.circular(ManagerRadius.r5),
      ),
      child: Text(
        tag,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s10,
          color: isSelected
              ? ManagerColors.primaryColor
              : ManagerColors.greyWhiteColor,
        ),
      ),
    );
  }
}
