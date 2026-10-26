import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:flutter/material.dart';

/// Choose account type screen — customer or provider (UI only).
class ChooseTypeAccountScreen extends StatelessWidget {
  const ChooseTypeAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAuthScaffold(
      showLanguageSwitcher: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Back + Title (language is in its own top-right layer above)
          Row(
            children: [
              const AuthBackButton(),
              Expanded(
                child: Text(
                  ManagerStrings.chooseAccountTitle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: ManagerWidth.w40),
            ],
          ),

          SizedBox(height: ManagerHeight.h28),

          /// Subtitle with colored keywords
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
                  ).copyWith(decorationThickness: 2),
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
                  ).copyWith(decorationThickness: 2),
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

          SizedBox(height: ManagerHeight.h24),

          /// Customer Card
          _AccountTypeCard(
            imagePath: ManagerImages.continueUserCustomer,
            title: ManagerStrings.chooseAccountCustomerTitle,
            subtitle: ManagerStrings.chooseAccountCustomerSubTitle,
            buttonText: ManagerStrings.chooseAccountCustomerButton,
            onTap: () {
              Navigator.pushNamed(context, Routes.customerRegister);
            },
          ),

          SizedBox(height: ManagerHeight.h20),

          /// Provider Card
          _AccountTypeCard(
            imagePath: ManagerImages.continueUserProvider,
            title: ManagerStrings.chooseAccountProviderTitle,
            subtitle: ManagerStrings.chooseAccountProviderSubTitle,
            buttonText: ManagerStrings.chooseAccountProviderButton,
            onTap: () {
              Navigator.pushNamed(context, Routes.providerRegister);
            },
          ),

          SizedBox(height: ManagerHeight.h20),
        ],
      ),
    );
  }
}

/// Reusable card widget for account type selection.
class _AccountTypeCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onTap;

  const _AccountTypeCard({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.buttonText,
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
              height: ManagerHeight.h140,
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
                  color: ManagerColors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )],
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
                        /// Title
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

                        /// Subtitle — flexible so long copy doesn't overflow
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

                        SizedBox(height: ManagerHeight.h8),

                        /// Action Button
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
