import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:flutter/material.dart';

import '../widgets/on_boarding_indicator.dart';
import '../widgets/on_boarding_page_content.dart';

/// OnBoarding data model
class _OnBoardingItem {
  final String image;
  final String title;
  final String subtitle;

  const _OnBoardingItem({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  late final List<_OnBoardingItem> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      _OnBoardingItem(
        image: ManagerImages.onBoarding1,
        title: ManagerStrings.onBoardingTitle1,
        subtitle: ManagerStrings.onBoardingSubtitle1,
      ),
      _OnBoardingItem(
        image: ManagerImages.onBoarding2,
        title: ManagerStrings.onBoardingTitle2,
        subtitle: ManagerStrings.onBoardingSubtitle2,
      ),
      _OnBoardingItem(
        image: ManagerImages.onBoarding3,
        title: ManagerStrings.onBoardingTitle3,
        subtitle: ManagerStrings.onBoardingSubtitle3,
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool get _isLastPage => _currentIndex == _pages.length - 1;

  void _onNextPressed() {
    if (_isLastPage) {
      _onStartPressed();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _onStartPressed() async {
    await instance<AppSettingsPrefs>().setOutBoardingScreenViewed();
    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.authRoleSelection);
    }
  }

  Future<void> _onLoginPressed() async {
    await instance<AppSettingsPrefs>().setOutBoardingScreenViewed();
    if (mounted) {
      Navigator.pushReplacementNamed(context, Routes.authRoleSelection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        backgroundColor: ManagerColors.white,
        body: Column(
          children: [
            SizedBox(height: ManagerHeight.h48),
            // Step indicator
            OnBoardingIndicator(
              currentIndex: _currentIndex,
              totalPages: _pages.length,
            ),
            SizedBox(height: ManagerHeight.h42),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnBoardingPageContent(
                    imagePath: page.image,
                    title: page.title,
                    subtitle: page.subtitle,
                  );
                },
              ),
            ),

            // Bottom section: button + login link
            Padding(
              padding: EdgeInsets.only(
                bottom: ManagerHeight.h24,
                top: ManagerHeight.h8,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Next / Start button
                  ButtonApp(
                    title: _isLastPage
                        ? ManagerStrings.onBoardingStart
                        : ManagerStrings.onBoardingNext,
                    onPressed: _onNextPressed,
                    paddingWidth: ManagerWidth.w24,
                  ),

                  // Login link (hidden on last page)
                  if (!_isLastPage) ...[
                    SizedBox(height: ManagerHeight.h12),
                    GestureDetector(
                      onTap: _onLoginPressed,
                      child: Text(
                        ManagerStrings.onBoardingLogin,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.greyWhiteColor,
                          decoration: TextDecoration.underline,
                        ).copyWith(
                          decorationColor: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
