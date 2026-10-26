import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsSectionHeader
// Rounded icon box + bold title used above each content section
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const OrderDetailsSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(ManagerRadius.r8),
          ),
          child: Icon(
            icon,
            size: ManagerFontSize.s16,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(width: ManagerWidth.w10),
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}
