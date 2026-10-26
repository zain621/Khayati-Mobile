import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';

/// A centered loading indicator overlay.
class LoadingWidget extends StatelessWidget {
  final double size;

  const LoadingWidget({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.black.withOpacity(0.15),
      child: Center(
        child: Container(
          width: ManagerHeight.h80,
          height: ManagerHeight.h80,
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerHeight.h12),
            boxShadow: [
              BoxShadow(
                color: ManagerColors.black.withOpacity(0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Center(
            child: CircularProgressIndicator(
              color: ManagerColors.primaryColor,
              strokeWidth: 3,
            ),
          ),
        ),
      ),
    );
  }
}
