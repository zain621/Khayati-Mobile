import 'dart:ui';

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Shown after a successful logout.
/// Full auth texture background + premium dialog:
/// Login again  |  Close app
class LoggedOutScreen extends StatefulWidget {
  const LoggedOutScreen({super.key});

  @override
  State<LoggedOutScreen> createState() => _LoggedOutScreenState();
}

class _LoggedOutScreenState extends State<LoggedOutScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bgController;
  late final Animation<double> _bgFade;
  bool _dialogShown = false;
  bool _actionChosen = false;

  @override
  void initState() {
    super.initState();
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _bgFade = CurvedAnimation(parent: _bgController, curve: Curves.easeOut);
    _bgController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 450), () {
        if (mounted && !_dialogShown) _showExitDialog();
      });
    });
  }

  @override
  void dispose() {
    _bgController.dispose();
    super.dispose();
  }

  Future<void> _showExitDialog() async {
    _dialogShown = true;
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'logged-out',
      barrierColor: Colors.black.withOpacity(0.35),
      transitionDuration: const Duration(milliseconds: 380),
      pageBuilder: (context, anim, secondary) {
        return const SizedBox.shrink();
      },
      transitionBuilder: (context, anim, secondary, child) {
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutBack,
        );
        return FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.9, end: 1.0).animate(curved),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: PopScope(
                canPop: false,
                child: Center(
                  child: _LoggedOutDialog(
                    onLoginAgain: () {
                      _actionChosen = true;
                      Navigator.of(context).pop();
                      Get.offAllNamed(Routes.loginScreen);
                    },
                    onCloseApp: () {
                      _actionChosen = true;
                      Navigator.of(context).pop();
                      SystemNavigator.pop();
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    // If the dialog somehow closes without a choice, show it again.
    if (mounted && !_actionChosen) {
      _dialogShown = false;
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted && !_dialogShown && !_actionChosen) _showExitDialog();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: FadeTransition(
            opacity: _bgFade,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  ManagerImages.backgroundAuth,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: ManagerColors.white.withOpacity(0.55),
                ),
                Center(
                  child: Opacity(
                    opacity: 0.35,
                    child: CustomSvgImage(
                      path: ManagerImages.logo,
                      height: ManagerHeight.h100,
                      width: ManagerWidth.w140,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoggedOutDialog extends StatelessWidget {
  final VoidCallback onLoginAgain;
  final VoidCallback onCloseApp;

  const _LoggedOutDialog({
    required this.onLoginAgain,
    required this.onCloseApp,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: ManagerWidth.w320,
        margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
        padding: EdgeInsets.fromLTRB(
          ManagerWidth.w22,
          ManagerHeight.h24,
          ManagerWidth.w22,
          ManagerHeight.h20,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.14),
              blurRadius: 24,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSvgImage(
              path: ManagerImages.logo,
              height: ManagerHeight.h56,
              width: ManagerWidth.w100,
              fit: BoxFit.contain,
            ),
            SizedBox(height: ManagerHeight.h16),
            Text(
              ManagerStrings.loggedOutDialogTitle,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s17,
                color: ManagerColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ManagerHeight.h8),
            Text(
              ManagerStrings.loggedOutDialogSubtitle,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ManagerHeight.h24),
            SizedBox(
              width: double.infinity,
              height: ManagerHeight.h46,
              child: ElevatedButton(
                onPressed: onLoginAgain,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ManagerColors.primaryColor,
                  foregroundColor: ManagerColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r10),
                  ),
                ),
                child: Text(
                  ManagerStrings.loggedOutLoginAgain,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            SizedBox(
              width: double.infinity,
              height: ManagerHeight.h46,
              child: OutlinedButton(
                onPressed: onCloseApp,
                style: OutlinedButton.styleFrom(
                  foregroundColor: ManagerColors.primaryColor,
                  side: const BorderSide(
                    color: ManagerColors.primaryColor,
                    width: 1.4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r10),
                  ),
                ),
                child: Text(
                  ManagerStrings.loggedOutCloseApp,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
