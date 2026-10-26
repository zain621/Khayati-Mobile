import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/widgets/language_switcher_button.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/auth_role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/resources/manager_width.dart';
import '../../../../core/widgets/base_auth_scaffold.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import '../../../../core/widgets/button_app.dart';
import '../widgets/auth_footer_row.dart';
import '../widgets/custom_text_field.dart';
import '../../domain/di/di.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final LoginController controller;
  late final LanguageSwitcherMode _languageMode;
  late final bool _isTailor;

  @override
  void initState() {
    super.initState();
    initLogin();
    controller = Get.find<LoginController>();
    final prefs = instance<AppSettingsPrefs>();
    _isTailor = prefs.isTailorAudience;
    _languageMode = languageModeForStoredAudience();
  }

  void _onRegisterTap() {
    if (_isTailor) {
      Navigator.pushNamed(context, Routes.providerRegister);
    } else {
      Navigator.pushNamed(context, Routes.customerRegister);
    }
  }

  void _onChangeRoleTap() {
    Navigator.pushReplacementNamed(context, Routes.authRoleSelection);
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthScaffold(
      showLanguageSwitcher: true,
      languageMode: _languageMode,
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ManagerHeight.h80),

            /// Title
            Padding(
              padding: EdgeInsets.only(left: ManagerWidth.w16),
              child: Text(
                ManagerStrings.loginScreenTitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s32,
                  color: ManagerColors.black,
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h12),

            /// Subtitle
            Text(
              ManagerStrings.loginScreenSubTitle,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
            ),

            SizedBox(height: ManagerHeight.h40),

            /// Phone Number Field
            CustomTextField(
              label: ManagerStrings.loginScreenPhoneLabel,
              hintText: ManagerStrings.loginScreenPhoneHint,
              isPhone: true,
              initialCountryCode: controller.selectedCountryCode.value,
              controller: controller.phoneController,
              onCountryCodeChanged: (code) =>
                  controller.selectedCountryCode.value = code,
            ),

            SizedBox(height: ManagerHeight.h24),

            /// Login Button
            ButtonApp(
              title: ManagerStrings.loginScreenButton,
              onPressed: () => controller.login(),
              paddingWidth: 0,
              isLoading: controller.isLoading.value,
            ),

            SizedBox(height: ManagerHeight.h24),
            const Spacer(),

            /// Register Link — goes to the matching signup for this audience
            AuthFooterRow(
              title: ManagerStrings.loginScreenNoAccount,
              titleButton: ManagerStrings.loginScreenRegister,
              onTap: _onRegisterTap,
            ),
            SizedBox(height: ManagerHeight.h8),
            Center(
              child: GestureDetector(
                onTap: _onChangeRoleTap,
                child: Text(
                  _isTailor
                      ? ManagerStrings.switchToCustomerRole
                      : ManagerStrings.switchToTailorRole,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ).copyWith(decorationColor: ManagerColors.primaryColor),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.viewInsetsOf(context).bottom > 0 ? 16 : 8),
          ],
        ),
      ),
    );
  }
}
