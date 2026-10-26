import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

/// Reusable action card with icon, optional badge, title, and subtitle.
class ActionCardWidget extends StatelessWidget {
  final IconData? icon;
  final String? svgIconPath;
  final Color iconBackgroundColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? badge;
  final VoidCallback? onTap;

  const ActionCardWidget({
    super.key,
    this.icon,
    this.svgIconPath,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.badge,
    this.onTap,
  }) : assert(icon != null || svgIconPath != null,
            'Either icon or svgIconPath must be provided');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ManagerHeight.h156,
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r6),
            // border: Border.all(
            //   color: ManagerColors.greyWhiteColor.withOpacity(0.15),
            // ),
            boxShadow: [
              BoxShadow(
                color: ManagerColors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  ManagerImages.backgroundHomeItems,
                  // width: ManagerWidth.w120,
                  // height: ManagerHeight.h77,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h20,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Icon with optional badge
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: ManagerWidth.w50,
                            height: ManagerWidth.w50,
                            decoration: BoxDecoration(
                              color: iconBackgroundColor,
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r14),
                            ),
                            child: svgIconPath != null
                                ? Padding(
                                    padding: EdgeInsets.all(ManagerWidth.w12),
                                    child: CustomSvgImage(
                                      path: svgIconPath!,
                                      color: iconColor,
                                    ),
                                  )
                                : Icon(
                                    icon,
                                    color: iconColor,
                                    size: 24,
                                  ),
                          ),
                  
                          /// Badge
                          if (badge != null)
                            Positioned(
                              top: -6,
                              right: -6,
                              child: Container(
                                padding: EdgeInsets.all(ManagerWidth.w4),
                                constraints: BoxConstraints(
                                  minWidth: ManagerWidth.w20,
                                  minHeight: ManagerWidth.w20,
                                ),
                                decoration: const BoxDecoration(
                                  color: ManagerColors.redNew,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    badge!,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s9,
                                      color: ManagerColors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                  
                      SizedBox(height: ManagerHeight.h12),
                  
                      /// Title
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.black,
                        ),
                      ),
                  
                      SizedBox(height: ManagerHeight.h4),
                  
                      /// Subtitle
                      Text(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
