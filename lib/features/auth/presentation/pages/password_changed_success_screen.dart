import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../core/widgets/button_app.dart';

class PasswordChangedSuccessScreen extends StatelessWidget {
  const PasswordChangedSuccessScreen({super.key});

  void _navigateToLogin(BuildContext context) {
    // Navigate to login screen and remove all previous routes
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.loginScreen,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ManagerHeight.h50),

          /// Success Animation
          Image.asset(
            ManagerImages.passwordChangedSuccess,
            height: ManagerHeight.h84,
            width: ManagerWidth.w84,
            color: ManagerColors.primaryColor,
          ),

          SizedBox(height: ManagerHeight.h22),

          /// Success Title
          Text(
            ManagerStrings.passwordChangedTitle,
            textAlign: TextAlign.center,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),

          SizedBox(height: ManagerHeight.h6),

          /// Success Subtitle with two colors
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: ManagerStrings.passwordChangedSubTitle1,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                TextSpan(
                  text: ' ${ManagerStrings.passwordChangedSubTitle2}',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h60),

          /// Login Button
          ButtonApp(
            title: ManagerStrings.passwordChangedButton,
            onPressed: () => _navigateToLogin(context),
            paddingWidth: 0,
          ),

          SizedBox(height: ManagerHeight.h16),

          /// Privacy Policy Link
          GestureDetector(
            onTap: () {
              // Navigate to privacy policy screen
            },
            child: Text(
              ManagerStrings.passwordChangedPrivacy,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h40),
        ],
      ),
    );
  }
}
