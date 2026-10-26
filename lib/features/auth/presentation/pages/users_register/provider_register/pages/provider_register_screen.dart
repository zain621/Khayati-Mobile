import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/language_switcher_button.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/auth/domain/di/di.dart';
import 'package:app_mobile/features/auth/presentation/controller/provider_register_controller.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/widgets/provider_step_agreement.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/widgets/provider_step_business_details.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/widgets/provider_step_experience.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/widgets/provider_step_role.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Main provider registration page with 3 interactive steps.
class ProviderRegisterScreen extends StatefulWidget {
  const ProviderRegisterScreen({super.key});

  @override
  State<ProviderRegisterScreen> createState() => _ProviderRegisterScreenState();
}

class _ProviderRegisterScreenState extends State<ProviderRegisterScreen> {
  late final ProviderRegisterController controller;

  @override
  void initState() {
    super.initState();
    initProviderRegister();
    controller = Get.find<ProviderRegisterController>();
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: ManagerColors.white,
        body: Stack(
          children: [
            /// Background Image
            Image.asset(
              ManagerImages.backgroundAuth,
              height: ManagerHeight.h241,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            /// Main Content
            SafeArea(
              bottom: true,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
                child: Obx(() => Column(
                      children: [
                        /// Space so title clears the top-right language control
                        SizedBox(height: ManagerHeight.h44),

                        /// Back + Title (title padded so it never collides with language)
                        Row(
                          children: [
                            AuthBackButton(
                              onTap: controller.currentStep.value > 0
                                  ? controller.previousStep
                                  : null,
                            ),
                            Expanded(
                              child: Text(
                                ManagerStrings.providerRegisterTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getBoldTextStyle(
                                  fontSize: ManagerFontSize.s16,
                                  color: ManagerColors.black,
                                ),
                              ),
                            ),
                            /// Balance the back button width so title stays centered
                            SizedBox(width: ManagerWidth.w40),
                          ],
                        ),

                        SizedBox(height: ManagerHeight.h16),

                        /// Step Indicator
                        _buildStepIndicator(controller),

                        SizedBox(height: ManagerHeight.h20),

                        /// ── Scrollable Step Content ──
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: FadeTransition(
                              opacity: controller.fadeAnim,
                              child: SlideTransition(
                                position: controller.slideAnim,
                                child: _buildCurrentStep(context, controller),
                              ),
                            ),
                          ),
                        ),

                        /// ── Fixed Bottom Buttons ──
                        _buildBottomButtons(controller),

                        SizedBox(height: ManagerHeight.h16),
                      ],
                    )),
              ),
            ),

            /// Language above content (receives taps) — separate from title row
            Positioned(
              top: topInset + 10,
              right: 12,
              child: const Material(
                color: Colors.transparent,
                child: LanguageSwitcherButton(
                  mode: LanguageSwitcherMode.tailor,
                ),
              ),
            ),

            /// Loading overlay on top of everything
            Obx(() => controller.isLoading.value
                ? const LoadingWidget()
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  /// Horizontal progress bar indicator (same style as OnBoarding).
  Widget _buildStepIndicator(ProviderRegisterController controller) {
    return Obx(() {
      final steps = controller.totalSteps;
      return Row(
        children: List.generate(steps, (index) {
          final isActive = index <= controller.currentStep.value;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              height: ManagerHeight.h4,
              margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w3),
              decoration: BoxDecoration(
                color: isActive
                    ? ManagerColors.primaryColor
                    : ManagerColors.geyBackgroundOnBoarding,
                borderRadius: BorderRadius.circular(ManagerHeight.h4),
              ),
            ),
          );
        }),
      );
    });
  }

  /// Returns the widget for the current step.
  Widget _buildCurrentStep(
      BuildContext context, ProviderRegisterController controller) {
    switch (controller.currentStep.value) {
      case 0:
        return ProviderStepRole(
          selectedRole: controller.selectedRole.value,
          onRoleSelected: (role) {
            controller.selectedRole.value = role;
            controller.clampStepToRole();
          },
        );
      case 1:
        return ProviderStepBusinessDetails(
          businessNameController: controller.businessNameController,
          ownerNameController: controller.ownerNameController,
          phoneController: controller.phoneController,
          emailController: controller.emailController,
          showEmail: controller.needsVendorAgreement,
          addressController: controller.addressController,
          locationController: controller.locationController,
          selectedCity: controller.selectedCity.value,
          onCityChanged: (city) => controller.selectedCity.value = city,
          onOpenMap: () => controller.openMapPicker(context),
          initialPhoneCountryCode: controller.selectedCountryCode.value,
          onPhoneCountryCodeChanged: (code) =>
              controller.selectedCountryCode.value = code,
        );
      case 2:
        return ProviderStepExperience(
          selectedYears: controller.selectedYears.value,
          onYearsChanged: (years) => controller.selectedYears.value = years,
          bioController: controller.bioController,
          categories: controller.categories,
          selectedCategoryIds: controller.selectedCategoryIds,
          onCategoryToggle: controller.toggleCategory,
          isCategoriesLoading: controller.isCategoriesLoading.value,
        );
      case 3:
        return ProviderStepAgreement(controller: controller);
      default:
        return const SizedBox.shrink();
    }
  }

  /// Bottom navigation buttons (Previous / Next / Submit).
  Widget _buildBottomButtons(ProviderRegisterController controller) {
    return Obx(() {
      final isLast =
          controller.currentStep.value == controller.totalSteps - 1;
      final isFirst = controller.currentStep.value == 0;
      final canProceed = controller.canProceed;

    return Row(
      children: [
        /// Previous Button
        if (!isFirst)
          Expanded(
            child: GestureDetector(
              onTap: controller.previousStep,
              child: Container(
                height: ManagerHeight.h46,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.circular(ManagerRadius.r5),
                  border: Border.all(
                    color: ManagerColors.primaryColor,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  ManagerStrings.providerPreviousButton,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
            ),
          ),

        if (!isFirst) SizedBox(width: ManagerWidth.w12),

        /// Next / Submit Button
        Expanded(
          child: GestureDetector(
            onTap: canProceed ? controller.nextStep : null,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: ManagerHeight.h46,
              decoration: BoxDecoration(
                color: canProceed
                    ? ManagerColors.primaryColor
                    : ManagerColors.primaryColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(ManagerRadius.r5),
              ),
              alignment: Alignment.center,
              child: Text(
                isLast
                    ? ManagerStrings.providerSubmitButton
                    : ManagerStrings.providerNextButton,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
    });
  }
}
