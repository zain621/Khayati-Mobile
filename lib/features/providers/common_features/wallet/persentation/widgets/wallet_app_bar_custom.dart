import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

class WalletAppBarCustom extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Widget? trailing;

  const WalletAppBarCustom({
    super.key,
    required this.title,
    this.subtitle,
    this.showBackButton = true,
    this.onBackPressed,
    this.trailing,
  });

  @override
  Size get preferredSize => Size.fromHeight(
        subtitle != null ? ManagerHeight.h120 : ManagerHeight.h80,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
        bottom: ManagerHeight.h18,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Back Button and Title Row
              if (showBackButton)
                GestureDetector(
                  onTap: () {
                    if (onBackPressed != null) {
                      onBackPressed!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    height: ManagerHeight.h34,
                    width: ManagerWidth.w34,
                    padding: EdgeInsets.all(ManagerWidth.w4),
                    decoration: BoxDecoration(
                      color: ManagerColors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: ManagerColors.white,
                      size: ManagerHeight.h24,
                    ),
                  ),
                ),
              SizedBox(width: ManagerWidth.w5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ManagerHeight.h12),

                    /// Title
                    Text(
                      title,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.white,
                      ),
                    ),

                    /// Subtitle
                    if (subtitle != null) ...[
                      SizedBox(height: ManagerHeight.h4),
                      Text(
                        subtitle!,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          SizedBox(height: ManagerHeight.h32),
        ],
      ),
    );
  }
}
