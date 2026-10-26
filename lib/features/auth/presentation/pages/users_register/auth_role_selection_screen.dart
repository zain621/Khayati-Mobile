import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/language_switcher_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Shown after splash + onboarding.
/// User picks Customer or Tailor → then login/signup with the matching language set.
class AuthRoleSelectionScreen extends StatelessWidget {
  const AuthRoleSelectionScreen({super.key});

  Future<void> _selectAudience(
    BuildContext context, {
    required String audience,
  }) async {
    final prefs = instance<AppSettingsPrefs>();
    await prefs.setAuthAudience(audience);

    // Tailor flow only supports EN / AR — clamp Urdu if needed.
    if (audience == 'tailor') {
      final locale = prefs.getLocale();
      if (locale == 'ur' && Get.isRegistered<LocaleController>()) {
        await Get.find<LocaleController>().changeLanguage('en');
      }
    }

    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, Routes.loginScreen);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Stack(
            children: [
              Image.asset(
                ManagerImages.backgroundAuth,
                height: ManagerHeight.h241,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
                child: Column(
                  children: [
                    SizedBox(height: ManagerHeight.h40),
                    Text(
                      ManagerStrings.chooseAccountTitle,
                      textAlign: TextAlign.center,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h12),
                    RichText(
                      textAlign: TextAlign.center,
                      strutStyle: const StrutStyle(
                        height: 1.5,
                        forceStrutHeight: true,
                      ),
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: ManagerStrings.chooseAccountSubTitle1,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                          TextSpan(
                            text: ManagerStrings.chooseAccountSubTitleTailor,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: ManagerStrings.chooseAccountSubTitle2,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                          TextSpan(
                            text: ManagerStrings.chooseAccountSubTitleBuyer,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: ManagerStrings.chooseAccountSubTitle3,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h28),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _RoleCard(
                              imagePath: ManagerImages.continueUserCustomer,
                              title: ManagerStrings.chooseAccountCustomerTitle,
                              subtitle:
                                  ManagerStrings.chooseAccountCustomerSubTitle,
                              buttonText:
                                  ManagerStrings.chooseAccountCustomerButton,
                              languagesHint: 'EN · AR · اردو',
                              onTap: () => _selectAudience(
                                context,
                                audience: 'visitor',
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h20),
                            _RoleCard(
                              imagePath: ManagerImages.continueUserProvider,
                              title: ManagerStrings.chooseAccountProviderTitle,
                              subtitle:
                                  ManagerStrings.chooseAccountProviderSubTitle,
                              buttonText:
                                  ManagerStrings.chooseAccountProviderButton,
                              languagesHint: 'EN · العربية',
                              onTap: () => _selectAudience(
                                context,
                                audience: 'tailor',
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final String languagesHint;
  final VoidCallback onTap;

  const _RoleCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.languagesHint,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r16),
          ),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: ManagerHeight.h160,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: ManagerHeight.h110),
            child: Container(
              width: ManagerWidth.w267,
              height: ManagerHeight.h150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ManagerRadius.r16),
                ),
                color: ManagerColors.white,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      ManagerImages.cardBackgroundChooseAccountType,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w12,
                      vertical: ManagerHeight.h10,
                    ),
                    child: Column(
                      children: [
                        Text(
                          title,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ManagerHeight.h4),
                        Expanded(
                          child: Text(
                            subtitle,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          languagesHint,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s10,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h8),
                        GestureDetector(
                          onTap: onTap,
                          child: Container(
                            width: double.infinity,
                            height: ManagerHeight.h35,
                            decoration: BoxDecoration(
                              color: ManagerColors.primaryColor,
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              buttonText,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s12,
                                color: ManagerColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Helper used by login / register to resolve language switcher mode.
LanguageSwitcherMode languageModeForStoredAudience() {
  return instance<AppSettingsPrefs>().isTailorAudience
      ? LanguageSwitcherMode.tailor
      : LanguageSwitcherMode.visitor;
}
