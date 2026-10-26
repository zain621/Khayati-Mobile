import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';

/// Premium full-screen overlay shown while logout is in progress.
/// Logo + spinner + "Logging out…" with soft fade/scale transitions.
class LoggingOutOverlay extends StatefulWidget {
  const LoggingOutOverlay({super.key});

  @override
  State<LoggingOutOverlay> createState() => _LoggingOutOverlayState();
}

class _LoggingOutOverlayState extends State<LoggingOutOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _enterController;
  late final AnimationController _pulseController;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
    );
    _fade = CurvedAnimation(parent: _enterController, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _enterController, curve: Curves.easeOutBack),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _enterController.forward();
  }

  @override
  void dispose() {
    _enterController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_enterController, _pulseController]),
      builder: (context, _) {
        return FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.black.withOpacity(0.45),
            child: SizedBox.expand(
              child: Center(
                child: ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: ManagerWidth.w280,
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w24,
                      vertical: ManagerHeight.h28,
                    ),
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 28,
                          offset: const Offset(0, 12),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ScaleTransition(
                          scale: _pulse,
                          child: CustomSvgImage(
                            path: ManagerImages.logo,
                            height: ManagerHeight.h72,
                            width: ManagerWidth.w120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h20),
                        SizedBox(
                          width: ManagerWidth.w28,
                          height: ManagerHeight.h28,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        Text(
                          ManagerStrings.loggingOutTitle,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: ManagerHeight.h6),
                        Text(
                          ManagerStrings.loggingOutSubtitle,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
