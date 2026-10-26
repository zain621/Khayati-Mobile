import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../controller/forgot_password_controller.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_footer_row.dart';
import '../widgets/custom_text_field.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeTitle;
  late Animation<Offset> _slideTitle;
  late Animation<double> _fadeHint;
  late Animation<Offset> _slideHint;
  late Animation<double> _fadeFields;
  late Animation<Offset> _slideFields;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  late ForgotPasswordController _fpController;

  @override
  void initState() {
    super.initState();
    _fpController = Get.find<ForgotPasswordController>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _slideTitle =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    _fadeHint = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );
    _slideHint =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );

    _fadeFields = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _slideFields =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _fadeButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );
    _slideButton =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BaseAuthScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h52),

          /// Back Button
          const AuthBackButton(),

          SizedBox(height: ManagerHeight.h40),

          /// Title
          FadeTransition(
            opacity: _fadeTitle,
            child: SlideTransition(
              position: _slideTitle,
              child: Text(
                ManagerStrings.newPasswordTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h12),

          /// Subtitle
          FadeTransition(
            opacity: _fadeTitle,
            child: SlideTransition(
              position: _slideTitle,
              child: Text(
                ManagerStrings.newPasswordSubTitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h16),

          SizedBox(height: ManagerHeight.h40),

          /// Password Fields
          FadeTransition(
            opacity: _fadeFields,
            child: SlideTransition(
              position: _slideFields,
              child: Column(
                children: [
                  /// New Password Field
                  CustomTextField(
                    controller: _fpController.newPasswordController,
                    label: ManagerStrings.newPasswordLabel,
                    hintText: ManagerStrings.loginScreenPasswordHint,
                    isPassword: true,
                  ),
                  SizedBox(height: ManagerHeight.h6),

                  /// Password Hint Row
                  FadeTransition(
                    opacity: _fadeHint,
                    child: SlideTransition(
                      position: _slideHint,
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 18,
                            color: ManagerColors.primaryColor,
                          ),
                          SizedBox(width: ManagerWidth.w8),
                          Expanded(
                            child: Text(
                              ManagerStrings.newPasswordHint,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s9,
                                color: ManagerColors.greyWhiteColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h16),

                  /// Confirm Password Field
                  CustomTextField(
                    controller: _fpController.confirmPasswordController,
                    label: ManagerStrings.newPasswordConfirmLabel,
                    hintText: ManagerStrings.loginScreenPasswordHint,
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h44),

          /// Update Password Button
          FadeTransition(
            opacity: _fadeButton,
            child: SlideTransition(
              position: _slideButton,
              child: ButtonApp(
                title: ManagerStrings.newPasswordUpdateButton,
                onPressed: _fpController.resetPassword,
                paddingWidth: 0,
              ),
            ),
          ),

          const Spacer(),

          /// Footer
          AuthFooterRow(
            title: ManagerStrings.authFooterRememberPassword,
            titleButton: ManagerStrings.authFooterLogin,
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.loginScreen,
                (route) => false,
              );
            },
          ),

          SizedBox(height: ManagerHeight.h8),
        ],
      ),
        ),

        /// Loading overlay
        Obx(() {
          if (_fpController.isLoading.value) return const LoadingWidget();
          return const SizedBox.shrink();
        }),
      ],
    );
  }
}
