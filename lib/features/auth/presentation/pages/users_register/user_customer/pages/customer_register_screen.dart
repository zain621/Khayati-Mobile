import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_footer_row.dart';
import 'package:app_mobile/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../../core/resources/manager_width.dart';
import '../../../../../../../core/widgets/base_auth_scaffold.dart';
import '../../../../../../../core/widgets/language_switcher_button.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../../../../core/widgets/button_app.dart';
import '../../../../../domain/di/di.dart';
import '../../../../../presentation/controller/customer_register_controller.dart';

/// Customer registration screen (UI only).
class CustomerRegisterScreen extends StatefulWidget {
  const CustomerRegisterScreen({super.key});

  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeTitle;
  late Animation<Offset> _slideTitle;
  late Animation<double> _fadeSubtitle;
  late Animation<Offset> _slideSubtitle;
  late Animation<double> _fadeFields;
  late Animation<Offset> _slideFields;
  late Animation<double> _fadeButton;
  late Animation<Offset> _slideButton;

  @override
  void initState() {
    super.initState();
    initCustomerRegister();
    _setupAnimations();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeTitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );
    _slideTitle = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _fadeSubtitle = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.5, curve: Curves.easeOut),
      ),
    );
    _slideSubtitle = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.15, 0.5, curve: Curves.easeOut),
      ),
    );

    _fadeFields = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );
    _slideFields = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );

    _fadeButton = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
    _slideButton = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    disposeCustomerRegister();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerController = Get.find<CustomerRegisterController>();
    return BaseAuthScaffold(
      showLanguageSwitcher: true,
      languageMode: LanguageSwitcherMode.visitor,
      child: Obx(
        () => Column(
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
                child: Padding(
                  padding: EdgeInsets.only(left: ManagerWidth.w16),
                  child: Text(
                    ManagerStrings.registerTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
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
                  ManagerStrings.registerSubTitle,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h40),

            /// Input Fields
            FadeTransition(
              opacity: _fadeFields,
              child: SlideTransition(
                position: _slideFields,
                child: Column(
                  children: [
                    /// Full Name Field
                    CustomTextField(
                      label: ManagerStrings.registerFullNameLabel,
                      hintText: ManagerStrings.registerFullNameHint,
                      controller: registerController.fullNameController,
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    /// Phone Number Field
                    CustomTextField(
                      label: ManagerStrings.registerPhoneLabel,
                      hintText: ManagerStrings.registerPhoneHint,
                      isPhone: true,
                      initialCountryCode:
                          registerController.selectedCountryCode.value,
                      controller: registerController.phoneController,
                      onCountryCodeChanged: (code) =>
                          registerController.selectedCountryCode.value = code,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h40),

            /// Register Button
            FadeTransition(
              opacity: _fadeButton,
              child: SlideTransition(
                position: _slideButton,
                child: ButtonApp(
                  title: ManagerStrings.registerButton,
                  onPressed: () => registerController.submitRegister(),
                  paddingWidth: 0,
                  isLoading: registerController.isLoading.value,
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h96),
            const Spacer(),

            /// Footer - Already have account
            AuthFooterRow(
              title: ManagerStrings.registerHaveAccount,
              titleButton: ManagerStrings.registerLogin,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  Routes.loginScreen,
                  (route) => false,
                );
              },
            ),

            SizedBox(
              height: MediaQuery.viewInsetsOf(context).bottom > 0 ? 16 : 8,
            ),
          ],
        ),
      ),
    );
  }
}
