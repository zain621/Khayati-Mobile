import 'dart:ui';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';

class CustomConfirmDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String confirmText;
  final String cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final bool showLogo;

  const CustomConfirmDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.confirmText,
    required this.cancelText,
    required this.onConfirm,
    this.onCancel,
    this.showLogo = false,
  });

  /// Show confirm dialog
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String confirmText,
    required String cancelText,
    bool showLogo = false,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return CustomConfirmDialog(
          title: title,
          subtitle: subtitle,
          confirmText: confirmText,
          cancelText: cancelText,
          showLogo: showLogo,
          onConfirm: () => Navigator.of(context).pop(true),
          onCancel: () => Navigator.of(context).pop(false),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: showLogo ? ManagerHeight.h210 : ManagerHeight.h180,
          ),
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r8),
          ),
          padding: EdgeInsets.all(ManagerWidth.w20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// Optional Khayati logo (e.g. logout confirm)
              if (showLogo) ...[
                CustomSvgImage(
                  path: ManagerImages.logo,
                  height: ManagerHeight.h36,
                  width: ManagerWidth.w72,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: ManagerHeight.h12),
              ],

              /// Title and Subtitle Section
              Text(
                title,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ManagerHeight.h8),
              Text(
                subtitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
                maxLines: 8,
                overflow: TextOverflow.ellipsis,
              ),

              SizedBox(height: ManagerHeight.h20),

              /// Action Buttons
              Row(
                children: [
                  /// Confirm Button
                  Expanded(
                    child: GestureDetector(
                      onTap: onConfirm,
                      child: Container(
                        height: ManagerHeight.h42,
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor,
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Center(
                          child: Text(
                            confirmText,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: ManagerWidth.w8),

                  /// Cancel Button
                  Expanded(
                    child: GestureDetector(
                      onTap:
                          onCancel ?? () => Navigator.of(context).pop(false),
                      child: Container(
                        height: ManagerHeight.h42,
                        decoration: BoxDecoration(
                          color: ManagerColors.redNew.withOpacity(0.04),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Center(
                          child: Text(
                            cancelText,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.redNew,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
