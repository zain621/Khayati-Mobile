import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/splash_and_boarding/presentation/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_styles.dart';
import '../widgets/logo_in_splash_widget.dart';

/// Premium splash:
/// 1) Full-screen hero (`splash-bg.jpg`)
/// 2) Two-sided curtains close into solid brand green
/// 3) Logo + dashed progress bar on brand green
/// 4) Navigate onward
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _collageController;
  late final AnimationController _curtainController;
  late final AnimationController _logoController;
  late final AnimationController _textController;

  late final Animation<double> _collageFade;
  late final Animation<double> _collageScale;
  late final Animation<double> _curtainClose;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoFade;
  late final Animation<double> _textSlide;
  late final Animation<double> _textFade;

  late final SplashController _splashController;

  @override
  void initState() {
    super.initState();
    _splashController = Get.put(
      SplashController(instance<AppSettingsPrefs>()),
    );
    _initAnimations();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LocaleController>().changeLanguage(
        instance<AppSettingsPrefs>().getLocale(),
        force: true,
      );
    });
  }

  void _initAnimations() {
    _collageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _collageFade = CurvedAnimation(
      parent: _collageController,
      curve: Curves.easeOut,
    );
    _collageScale = Tween<double>(begin: 1.06, end: 1.0).animate(
      CurvedAnimation(parent: _collageController, curve: Curves.easeOutCubic),
    );

    _curtainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _curtainClose = CurvedAnimation(
      parent: _curtainController,
      curve: Curves.easeInOutCubic,
    );

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoScale = Tween<double>(begin: 0.72, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );
    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textSlide = Tween<double>(begin: 24.0, end: 0.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );
    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _runSequence();
  }

  Future<void> _runSequence() async {
    // Full collage visible first
    await _collageController.forward();
    await Future.delayed(const Duration(milliseconds: 550));
    if (!mounted) return;

    // Curtains close → solid brand screen
    await _curtainController.forward();
    if (!mounted) return;

    await _logoController.forward();
    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    await _textController.forward();

    // Let the dashed progress bar play through once before leaving.
    await Future.delayed(const Duration(milliseconds: 1600));
    if (mounted) _splashController.navigateAfterSplash();
  }

  @override
  void dispose() {
    _collageController.dispose();
    _curtainController.dispose();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final half = size.width / 2;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.primaryColor,
          body: AnimatedBuilder(
            animation: Listenable.merge([
              _collageController,
              _curtainController,
              _logoController,
              _textController,
            ]),
            builder: (context, _) {
              final close = _curtainClose.value;
              final closed = close >= 0.999;
              // Curtains start off-screen (width 0) and grow to cover full half each.
              final leftWidth = half * close;
              final rightWidth = half * close;

              return Stack(
                fit: StackFit.expand,
                children: [
                  // Full-bleed hero image
                  FadeTransition(
                    opacity: _collageFade,
                    child: ScaleTransition(
                      scale: _collageScale,
                      child: Image.asset(
                        // Always splash-bg.jpg — never the old collage grid.
                        ManagerImages.splashBackground,
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),

                  // Left curtain (brand green)
                  if (!closed)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: leftWidth,
                        height: double.infinity,
                        color: ManagerColors.primaryColor,
                      ),
                    ),

                  // Right curtain (brand green)
                  if (!closed)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: rightWidth,
                        height: double.infinity,
                        color: ManagerColors.primaryColor,
                      ),
                    ),

                  // Solid brand fill after close — eliminates any center seam
                  if (closed)
                    const ColoredBox(color: ManagerColors.primaryColor),

                  // Logo + progress bar (only after curtains close)
                  if (closed)
                    Center(
                      child: FadeTransition(
                        opacity: _logoFade,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: const LogoInSplashWidget(),
                        ),
                      ),
                    ),

                  // Hint text
                  Positioned(
                    bottom: ManagerHeight.h20,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: _textFade,
                      child: Transform.translate(
                        offset: Offset(0, _textSlide.value),
                        child: Text(
                          ManagerStrings.splashScreenHint,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
