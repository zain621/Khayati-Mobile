import 'package:app_mobile/core/widgets/language_switcher_button.dart';
import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class BaseAuthScaffold extends StatelessWidget {
  final Widget child;

  /// When false, hides the top-right language control.
  final bool showLanguageSwitcher;

  /// Language set for the switcher when visible.
  final LanguageSwitcherMode languageMode;

  const BaseAuthScaffold({
    super.key,
    required this.child,
    this.showLanguageSwitcher = true,
    this.languageMode = LanguageSwitcherMode.tailor,
  });

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: SafeArea(
        top: false,
        bottom: defaultTargetPlatform == TargetPlatform.android,
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Stack(
            children: [
              /// Background Image
              Image.asset(
                ManagerImages.backgroundAuth,
                height: ManagerHeight.h241,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              /// Scroll content — leave room under the language row
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            ManagerWidth.w24,
                            topInset +
                                (showLanguageSwitcher
                                    ? ManagerHeight.h48
                                    : ManagerHeight.h16),
                            ManagerWidth.w24,
                            ManagerHeight.h16,
                          ),
                          child: child,
                        ),
                      ),
                    ),
                  );
                },
              ),

              /// Language LAST so it sits above the scroll view and receives taps
              if (showLanguageSwitcher)
                Positioned(
                  top: topInset + 10,
                  right: 12,
                  child: Material(
                    color: Colors.transparent,
                    child: LanguageSwitcherButton(mode: languageMode),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
