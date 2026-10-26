import 'package:flutter/material.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';

/// Custom step indicator for onboarding pages.
/// Shows progress bars that fill based on the current page index.
class OnBoardingIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalPages;

  const OnBoardingIndicator({
    super.key,
    required this.currentIndex,
    this.totalPages = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w24,
        vertical: ManagerHeight.h16,
      ),
      child: Row(
        children: List.generate(totalPages, (index) {
          final isActive = index <= currentIndex;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              height: ManagerHeight.h4,
              margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w3),
              decoration: BoxDecoration(
                color: isActive
                    ? ManagerColors.primaryColor
                    : ManagerColors.geyBackgroundOnBoarding,
                borderRadius: BorderRadius.circular(ManagerHeight.h4),
              ),
            ),
          );
        }),
      ),
    );
  }
}
