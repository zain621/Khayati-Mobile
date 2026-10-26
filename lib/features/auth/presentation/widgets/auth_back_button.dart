import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

/// Reusable back button for auth screens.
/// Displays a rounded container with an arrow icon.
class AuthBackButton extends StatelessWidget {
  final VoidCallback? onTap;

  const AuthBackButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        width: ManagerWidth.w38,
        height: ManagerHeight.h38,
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: ManagerColors.primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
