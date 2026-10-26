import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/common/change_password/presentation/controller/change_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Change Password Screen — تغيير كلمة المرور
// ─────────────────────────────────────────────────────────────────────────────

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<ChangePasswordController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          bottomNavigationBar: Container(
            color: ManagerColors.white,
            padding:
                EdgeInsets.fromLTRB(0, ManagerHeight.h12, 0, ManagerHeight.h16),
            child: Obx(() => ButtonApp(
                  title: ManagerStrings.changePasswordButton,
                  onPressed: ctrl.isSubmitting.value
                      ? () {}
                      : () async {
                          FocusScope.of(context).unfocus();
                          final confirmed = await CustomConfirmDialog.show(
                            context: context,
                            title: ManagerStrings.changePasswordConfirmDialogTitle,
                            subtitle: ManagerStrings.changePasswordConfirmDialogSubtitle,
                            confirmText: ManagerStrings.changePasswordConfirmDialogConfirm,
                            cancelText: ManagerStrings.changePasswordConfirmDialogCancel,
                          );
                          if (confirmed == true) {
                            ctrl.submit();
                          }
                        },
                  paddingWidth: ManagerWidth.w16,
                )),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  CustomAppBar(
                    title: ManagerStrings.changePasswordTitle,
                    subtitle: ManagerStrings.changePasswordSubtitle,
                    showBackButton: true,
                    onBackPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ManagerColors.white,
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r12),
                              boxShadow: [
                                BoxShadow(
                                  color: ManagerColors.black.withOpacity(0.08),
                                  blurRadius: 20,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                    ManagerImages.updateProfileBackground,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w14,
                                vertical: ManagerHeight.h16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _SectionLabel(
                                    icon: Icons.lock_outline_rounded,
                                    label: ManagerStrings
                                        .changePasswordSectionLabel,
                                  ),
                                  SizedBox(height: ManagerHeight.h20),
                                  _FieldLabel(
                                      text: ManagerStrings
                                          .changePasswordCurrentLabel),
                                  SizedBox(height: ManagerHeight.h6),
                                  Obx(() => _PasswordField(
                                        controller:
                                            ctrl.currentPasswordController,
                                        hintText: '••••••••••••••',
                                        obscure: ctrl.currentObscure.value,
                                        onToggle: () => ctrl.currentObscure
                                            .toggle(),
                                      )),
                                  SizedBox(height: ManagerHeight.h16),
                                  _FieldLabel(
                                      text: ManagerStrings
                                          .changePasswordNewLabel),
                                  SizedBox(height: ManagerHeight.h6),
                                  Obx(() => _PasswordField(
                                        controller:
                                            ctrl.newPasswordController,
                                        hintText: '••••••••••••••',
                                        obscure: ctrl.newObscure.value,
                                        onToggle: () =>
                                            ctrl.newObscure.toggle(),
                                      )),
                                  SizedBox(height: ManagerHeight.h16),
                                  _FieldLabel(
                                      text: ManagerStrings
                                          .changePasswordConfirmLabel),
                                  SizedBox(height: ManagerHeight.h6),
                                  Obx(() => _PasswordField(
                                        controller:
                                            ctrl.confirmPasswordController,
                                        hintText: '••••••••••••••',
                                        obscure: ctrl.confirmObscure.value,
                                        onToggle: () =>
                                            ctrl.confirmObscure.toggle(),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h16),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Loading overlay
          Obx(() => ctrl.isSubmitting.value
              ? const LoadingWidget()
              : const SizedBox.shrink()),
        ],
      ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Banner Card — decorative top card with background image
// ══════════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _BannerCard extends StatelessWidget {
  const _BannerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Decorative bg image
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ManagerRadius.r12),
                bottomLeft: Radius.circular(ManagerRadius.r12),
              ),
              child: Opacity(
                opacity: 0.18,
                child: Image.asset(
                  ManagerImages.updateProfileBackground,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h12,
            ),
            child: Row(
              children: [
                Container(
                  width: ManagerWidth.w48,
                  height: ManagerHeight.h48,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline_rounded,
                    color: ManagerColors.primaryColor,
                    size: ManagerFontSize.s24,
                  ),
                ),
                SizedBox(width: ManagerWidth.w14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ManagerStrings.changePasswordBannerTitle,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h4),
                      Text(
                        ManagerStrings.changePasswordBannerSubtitle,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Section Label
// ══════════════════════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,
            size: ManagerFontSize.s16, color: ManagerColors.primaryColor),
        SizedBox(width: ManagerWidth.w6),
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.primaryColor,
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Field Label
// ══════════════════════════════════════════════════════════════════════════════

class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getMediumTextStyle(
        fontSize: ManagerFontSize.s13,
        color: ManagerColors.black,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Password Field — same styling as _InputField in update_profile, + eye toggle
// ══════════════════════════════════════════════════════════════════════════════

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final VoidCallback onToggle;

  const _PasswordField({
    required this.controller,
    required this.hintText,
    required this.obscure,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        textAlign: TextAlign.start,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s14,
          color: ManagerColors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getRegularTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.greyWhiteColor.withOpacity(0.5),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w14,
            vertical: ManagerHeight.h14,
          ),
          suffixIcon: IconButton(
            onPressed: onToggle,
            icon: Icon(
              obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: ManagerColors.greyWhiteColor,
              size: ManagerFontSize.s20,
            ),
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
