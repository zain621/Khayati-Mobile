import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

class ProfileDataWidgetContainer extends StatelessWidget
    implements PreferredSizeWidget {
  final String iconPath;
  final String title;
  final String? subtitle;

  const ProfileDataWidgetContainer({
    super.key,
    required this.iconPath,
    required this.title,
    this.subtitle,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        subtitle != null ? ManagerHeight.h120 : ManagerHeight.h80,
      );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
          child: Column(
            children: [
              CustomSvgImage(path: iconPath),
              SizedBox(height: ManagerHeight.h4),
              Text(
                title,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
                            SizedBox(height: ManagerHeight.h2),               Text(
                subtitle ?? '',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
