import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

class ProfileDataWidgetContainer extends StatelessWidget
    implements PreferredSizeWidget {
  /// Asset path (SVG or PNG). Used when [icon] is null.
  final String? iconPath;

  /// Optional custom icon widget.
  final Widget? icon;

  final String title;
  final String? subtitle;

  const ProfileDataWidgetContainer({
    super.key,
    this.iconPath,
    this.icon,
    required this.title,
    this.subtitle,
  }) : assert(
          icon != null || iconPath != null,
          'Provide either icon or iconPath',
        );

  @override
  Size get preferredSize => Size.fromHeight(
        subtitle != null ? ManagerHeight.h120 : ManagerHeight.h80,
      );

  Widget _buildIcon() {
    if (icon != null) return icon!;
    final path = iconPath!;
    final isRaster = path.endsWith('.png') ||
        path.endsWith('.jpg') ||
        path.endsWith('.jpeg') ||
        path.endsWith('.webp');
    if (isRaster) {
      // Match sibling SVG icons (~18px) on the stats row.
      return Image.asset(
        path,
        width: 18,
        height: 18,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      );
    }
    return CustomSvgImage(path: path);
  }

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
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
          child: Column(
            children: [
              _buildIcon(),
              SizedBox(height: ManagerHeight.h4),
              Text(
                title,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h2),
              Text(
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
