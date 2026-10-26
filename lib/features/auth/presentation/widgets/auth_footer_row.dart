import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

/// Reusable row with a text label and a styled button.
/// Used for navigation links like "Don't have an account? Register".
class AuthFooterRow extends StatelessWidget {
  final String title;
  final String titleButton;
  final VoidCallback onTap;

  const AuthFooterRow({
    super.key,
    required this.title,
    required this.titleButton,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: ManagerHeight.h37,
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
            alignment: Alignment.center,
            child: Text(
              titleButton,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
