import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_width.dart';
import 'splash_progress_bar.dart';

/// Center brand stack after curtains close: logo + dashed progress bar.
class LogoInSplashWidget extends StatelessWidget {
  final bool showProgress;

  const LogoInSplashWidget({
    super.key,
    this.showProgress = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomSvgImage(
          path: ManagerImages.logo,
          height: ManagerHeight.h153,
          width: ManagerWidth.w171,
          fit: BoxFit.contain,
        ),
        if (showProgress) ...[
          SizedBox(height: ManagerHeight.h48),
          const SplashProgressBar(),
        ],
      ],
    );
  }
}
