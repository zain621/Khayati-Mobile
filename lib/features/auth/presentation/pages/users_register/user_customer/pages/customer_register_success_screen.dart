import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/service/session_reset_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/resources/manager_width.dart';
import '../../../../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../../../../core/widgets/button_app.dart';
import '../../../../../../../core/widgets/loading_widget.dart';
import '../../../../../presentation/controller/customer_register_controller.dart';

/// Customer registration success screen (UI only).
class CustomerRegisterSuccessScreen extends StatelessWidget {
  const CustomerRegisterSuccessScreen({super.key});

  void _navigateToHome(CustomerRegisterController controller) async {
    controller.isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 300));
    resetSessionControllers();
    Get.offAllNamed(Routes.mainNavigation);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CustomerRegisterController>();
    return BaseAuthScaffold(
      child: Obx(
        () => Stack(
          children: [
            Column(
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

          /// Success Title
          Text(
            ManagerStrings.registerSuccessTitle,
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
                  text: ManagerStrings.registerSuccessSubTitle1,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                TextSpan(
                  text: ' ${ManagerStrings.registerSuccessSubTitle2}',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h60),

          /// Go to Home Button
          ButtonApp(
            title: ManagerStrings.registerSuccessButton,
            onPressed: controller.isLoading.value
                ? () {}
                : () => _navigateToHome(controller),
            paddingWidth: 0,
          ),

          SizedBox(height: ManagerHeight.h16),

          /// Privacy Policy Link
          GestureDetector(
            onTap: () {
              // Navigate to privacy policy screen
            },
            child: Text(
              ManagerStrings.registerSuccessPrivacy,
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

      // Fullscreen loading overlay
      if (controller.isLoading.value) const LoadingWidget(),
    ],
        ),
      ),
    );
  }
}
