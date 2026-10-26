import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double paddingWidth;
  final bool isLoading;
  final bool isDisabled;

  const ButtonApp({
    super.key,
    required this.title,
    required this.onPressed,
    required this.paddingWidth,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = isDisabled || isLoading;

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingWidth),
        child: Container(
          height: ManagerHeight.h46,
          width: double.infinity,
          decoration: BoxDecoration(
            color: disabled
                ? ManagerColors.primaryColor.withValues(alpha: 0.65)
                : ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(ManagerRadius.r5),
          ),
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: isLoading
                ? SizedBox(
                    key: const ValueKey('button_loading'),
                    width: ManagerHeight.h20,
                    height: ManagerHeight.h20,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ManagerColors.white,
                      ),
                    ),
                  )
                : Text(
                    title,
                    key: const ValueKey('button_title'),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
