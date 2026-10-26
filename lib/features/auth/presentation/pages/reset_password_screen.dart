import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../core/widgets/button_app.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../controller/forgot_password_controller.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_footer_row.dart';
import '../widgets/custom_text_field.dart';
import '../../domain/di/di.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeTitle;
  late Animation<Offset> _slideTitle;
  late Animation<double> _fadeSubtitle;
  late Animation<Offset> _slideSubtitle;
  late Animation<double> _fadeField;
  late Animation<Offset> _slideField;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  late ForgotPasswordController _fpController;

  @override
  void initState() {
    super.initState();
    initForgotPassword();
    _fpController = Get.find<ForgotPasswordController>();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );
    _slideTitle = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.4, curve: Curves.easeOut)),
    );

    _fadeSubtitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );
    _slideSubtitle = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.15, 0.5, curve: Curves.easeOut)),
    );

    _fadeField = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );
    _slideField = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.3, 0.7, curve: Curves.easeOut)),
    );

    _fadeButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );
    _slideButton = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0, curve: Curves.easeOut)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeForgotPassword();
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
                ManagerStrings.resetPasswordTitle,
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
            opacity: _fadeSubtitle,
            child: SlideTransition(
              position: _slideSubtitle,
              child: Text(
                ManagerStrings.resetPasswordSubTitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h42),

          /// Phone Number Field
          FadeTransition(
            opacity: _fadeField,
            child: SlideTransition(
              position: _slideField,
              child: CustomTextField(
                controller: _fpController.phoneController,
                label: ManagerStrings.resetPasswordPhoneLabel,
                hintText: ManagerStrings.resetPasswordPhoneHint,
                isPhone: true,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h72),

          /// Send Code Button
          FadeTransition(
            opacity: _fadeButton,
            child: SlideTransition(
              position: _slideButton,
              child: ButtonApp(
                title: ManagerStrings.resetPasswordSendCode,
                onPressed: _fpController.sendForgotPassword,
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
