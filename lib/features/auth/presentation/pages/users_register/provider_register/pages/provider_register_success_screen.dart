import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:flutter/material.dart';

/// Provider registration success screen — application submitted.
class ProviderRegisterSuccessScreen extends StatelessWidget {
  const ProviderRegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ManagerHeight.h50),

          /// Success Icon
          Image.asset(
            ManagerImages.createAccountSuccess,
            height: ManagerHeight.h84,
            width: ManagerWidth.w84,
            color: ManagerColors.primaryColor,
          ),

          SizedBox(height: ManagerHeight.h22),

          /// Title
          Text(
            ManagerStrings.providerSuccessTitle,
            textAlign: TextAlign.center,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),

          SizedBox(height: ManagerHeight.h6),

          /// Subtitle
          Text(
            ManagerStrings.providerSuccessSubTitle,
            textAlign: TextAlign.center,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),

          SizedBox(height: ManagerHeight.h60),

          /// Button
          ButtonApp(
            title: ManagerStrings.providerSuccessButton,
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              );
            },
            paddingWidth: 0,
          ),

          SizedBox(height: ManagerHeight.h40),
        ],
      ),
    );
  }
}
