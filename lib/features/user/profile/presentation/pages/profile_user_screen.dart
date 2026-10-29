import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/language_bottom_sheet.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/core/widgets/logging_out_overlay.dart';
import 'package:app_mobile/features/common/delete_account/presentation/delete_account_confirm_flow.dart';
import 'package:app_mobile/features/user/profile/presentation/pages/update_user_profile_screen.dart';
import 'package:app_mobile/features/user/profile/domain/di/di.dart';
import 'package:app_mobile/features/user/profile/presentation/controller/user_profile_controller.dart';
import 'package:app_mobile/features/user/profile/presentation/widgets/custom_profile_user_appbar.dart';
import 'package:app_mobile/features/user/profile/presentation/widgets/profile_data_widget_container.dart';
import 'package:app_mobile/features/user/profile/presentation/widgets/profile_shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({super.key});

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  late final UserProfileController controller;

  @override
  void initState() {
    super.initState();
    initUserProfile(forceRefresh: true);
    controller = Get.find<UserProfileController>();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          extendBody: true,
          body: Stack(
            children: [
              // ── App Bar area ────────────────────────────────────────────
              Obx(() {
                final p = controller.profile.value;
                return SizedBox(
                  height: ManagerHeight.h300,
                  child: CustomProfileUserAppbar(
                    title: ManagerStrings.profileScreenTitle,
                    subtitle: ManagerStrings.profileScreenSubtitle,
                    showBackButton: true,
                    onBackPressed: () => Navigator.pop(context),
                    isLoading: controller.isLoading.value,
                    userName: p?.fullName,
                    userPhone: p?.phoneNumber,
                    userImage: p?.image,
                  ),
                );
              }),

              // ── Scrollable content ──────────────────────────────────────
              Padding(
                padding: EdgeInsets.only(top: ManagerHeight.h255),
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const ProfileShimmerWidget();
                  }

                  final p = controller.profile.value;

                  return RefreshIndicator(
                    onRefresh: () => controller.refreshProfile(),
                    color: ManagerColors.primaryColor,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                        child: Column(
                          children: [
                            // ── Stats row ───────────────────────────────────
                            Row(
                              children: [
                                ProfileDataWidgetContainer(
                                  title: '${p?.completedOrdersCount ?? 0}',
                                  subtitle:
                                      ManagerStrings.profileCompletedOrders,
                                  iconPath: ManagerIcons.completedOrderIcon,
                                ),
                                SizedBox(width: ManagerWidth.w12),
                                ProfileDataWidgetContainer(
                                  title: '${p?.inProgressOrdersCount ?? 0}',
                                  subtitle: ManagerStrings.profileInProgress,
                                  iconPath: ManagerIcons.inPrgressOderIcon,
                                ),
                                SizedBox(width: ManagerWidth.w12),
                                ProfileDataWidgetContainer(
                                  title: '${p?.loyaltyPoints ?? 0}',
                                  subtitle: ManagerStrings.profileLoyaltyPoints,
                                  iconPath: ManagerIcons.dirhamIcon,
                                ),
                              ],
                            ),
                            SizedBox(height: ManagerHeight.h20),

                            // ── Section: Account ────────────────────────────
                            _SectionHeader(
                              icon: Icons.person_outline_rounded,
                              label: ManagerStrings.profileSectionAccount,
                            ),
                            SizedBox(height: ManagerHeight.h8),
                            _ProfileMenuCard(
                              items: [
                                _MenuItem(
                                  icon: Icons.manage_accounts_outlined,
                                  title: ManagerStrings.profileEditTitle,
                                  subtitle: ManagerStrings.profileEditSubtitle,
                                  onTap: () {
                                    final p = Get.find<UserProfileController>()
                                        .profile
                                        .value;
                                    Get.to(() => UpdateUserProfileScreen(
                                          initialFullName: p?.fullName ?? '',
                                          phoneNumber: p?.phoneNumber ?? '',
                                          initialImage: p?.image,
                                        ));
                                  },
                                ),
                                _MenuItem(
                                  icon: Icons.lock_outline_rounded,
                                  title:
                                      ManagerStrings.profileChangePasswordTitle,
                                  subtitle: ManagerStrings
                                      .profileChangePasswordSubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.changePasswordScreen,
                                  ),
                                ),
                                _MenuItem(
                                  icon: Icons.location_on_outlined,
                                  title: ManagerStrings
                                      .profileManageAddressesTitle,
                                  subtitle: ManagerStrings
                                      .profileManageAddressesSubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.tailorAddressScreen,
                                    arguments: {'isProvider': false},
                                  ),
                                  isLast: true,
                                ),
                              ],
                            ),

                            SizedBox(height: ManagerHeight.h20),

                            // ── Section: Language ────────────────────────────
                            _SectionHeader(
                              icon: Icons.settings_outlined,
                              label: ManagerStrings.profileSectionSettings,
                            ),
                            SizedBox(height: ManagerHeight.h8),
                            _ProfileMenuCard(
                              items: [
                                _MenuItem(
                                  icon: Icons.language_rounded,
                                  title: ManagerStrings.profileLanguageTitle,
                                  subtitle:
                                      ManagerStrings.profileLanguageSubtitle,
                                  onTap: () =>
                                      LanguageBottomSheet.show(context),
                                  isLast: true,
                                ),
                              ],
                            ),

                            SizedBox(height: ManagerHeight.h20),

                            // ── Section: App Info ───────────────────────────
                            _SectionHeader(
                              icon: Icons.info_outline_rounded,
                              label: ManagerStrings.profileSectionAppInfo,
                            ),
                            SizedBox(height: ManagerHeight.h8),
                            _ProfileMenuCard(
                              items: [
                                _MenuItem(
                                  icon: Icons.info_outline_rounded,
                                  title: ManagerStrings.profileAboutTitle,
                                  subtitle: ManagerStrings.profileAboutSubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.aboutAppScreen,
                                  ),
                                ),
                                _MenuItem(
                                  icon: Icons.help_outline_rounded,
                                  title: ManagerStrings.profileFaqTitle,
                                  subtitle: ManagerStrings.profileFaqSubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.faqScreen,
                                  ),
                                ),
                                _MenuItem(
                                  icon: Icons.headset_mic_outlined,
                                  title: ManagerStrings.profileSupportTitle,
                                  subtitle: ManagerStrings.profileAboutSubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.contactUsScreen,
                                  ),
                                ),
                                _MenuItem(
                                  icon: Icons.shield_outlined,
                                  title: ManagerStrings.profilePrivacyTitle,
                                  subtitle:
                                      ManagerStrings.profilePrivacySubtitle,
                                  onTap: () => Navigator.pushNamed(
                                    context,
                                    Routes.privacyPolicyScreen,
                                  ),
                                  isLast: true,
                                ),
                              ],
                            ),

                            SizedBox(height: ManagerHeight.h24),

                            // ── Logout Button ───────────────────────────────
                            _LogoutButton(
                              onTap: () async {
                                final confirmed =
                                    await CustomConfirmDialog.show(
                                  context: context,
                                  title: ManagerStrings.logoutConfirmTitle,
                                  subtitle:
                                      ManagerStrings.logoutConfirmSubtitle,
                                  confirmText:
                                      ManagerStrings.logoutConfirmButton,
                                  cancelText: ManagerStrings.logoutCancelButton,
                                  showLogo: true,
                                );
                                if (confirmed == true) {
                                  controller.logout();
                                }
                              },
                            ),

                            SizedBox(height: ManagerHeight.h12),

                            // ── Delete Account Button ───────────────────────
                            _DeleteAccountButton(
                              onTap: () async {
                                final confirmed =
                                    await DeleteAccountConfirmFlow.confirm(
                                  context,
                                  isProvider: false,
                                );
                                if (confirmed) {
                                  controller.deleteAccount();
                                }
                              },
                            ),

                            SizedBox(height: ManagerHeight.h24),
                          ],
                        ),
                      ),
                    ), // SingleChildScrollView
                  ); // RefreshIndicator
                }),
              ),

              // ── Logout Loading Overlay ──────────────────────────────────
              Obx(() {
                if (!controller.isLoggingOut.value) {
                  return const SizedBox.shrink();
                }
                return const Positioned.fill(child: LoggingOutOverlay());
              }),

              // ── Delete Account Loading Overlay ──────────────────────────
              Obx(() {
                if (!controller.isDeleting.value)
                  return const SizedBox.shrink();
                return const Positioned.fill(child: LoadingWidget());
              }),

              // ── Language Change Loading Overlay ─────────────────────────
              Obx(() {
                if (!Get.find<LocaleController>().isChangingLanguage.value) {
                  return const SizedBox.shrink();
                }
                return const Positioned.fill(child: LoadingWidget());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
// ══════════════════════════════════════════════════════════════════════════════
// Section Header
// ══════════════════════════════════════════════════════════════════════════════

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionHeader({required this.icon, required this.label});

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
// Menu Card (white rounded card containing multiple items)
// ══════════════════════════════════════════════════════════════════════════════

class _ProfileMenuCard extends StatelessWidget {
  final List<_MenuItem> items;

  const _ProfileMenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: items,
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Single menu item row
// ══════════════════════════════════════════════════════════════════════════════

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: isLast
              ? BorderRadius.only(
                  bottomLeft: Radius.circular(ManagerRadius.r16),
                  bottomRight: Radius.circular(ManagerRadius.r16),
                )
              : BorderRadius.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w14,
              vertical: ManagerHeight.h14,
            ),
            child: Row(
              children: [
                // Icon box
                Container(
                  width: ManagerWidth.w42,
                  height: ManagerHeight.h42,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                  child: Icon(icon,
                      color: ManagerColors.primaryColor,
                      size: ManagerFontSize.s20),
                ),
                SizedBox(width: ManagerWidth.w12),
                // Title + subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.black,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h3),
                      Text(
                        subtitle,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ManagerWidth.w8),
                // Arrow
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: ManagerFontSize.s14,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.5),
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 0.8,
            indent: ManagerWidth.w68,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Logout Button
// ══════════════════════════════════════════════════════════════════════════════

class _LogoutButton extends StatelessWidget {
  final VoidCallback onTap;

  const _LogoutButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: ManagerHeight.h44,
        decoration: BoxDecoration(
          color: ManagerColors.logoutBackground,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.logout_rounded,
              color: ManagerColors.logoutRed,
              size: ManagerFontSize.s18,
            ),
            SizedBox(width: ManagerWidth.w8),
            Text(
              ManagerStrings.profileLogout,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s15,
                color: ManagerColors.logoutRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Delete Account Button
// ══════════════════════════════════════════════════════════════════════════════

class _DeleteAccountButton extends StatelessWidget {
  final VoidCallback onTap;

  const _DeleteAccountButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: ManagerHeight.h44,
        decoration: BoxDecoration(
          color: ManagerColors.logoutBackground,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          border: Border.all(
            color: ManagerColors.logoutRed.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline_rounded,
              color: ManagerColors.logoutRed,
              size: ManagerFontSize.s18,
            ),
            SizedBox(width: ManagerWidth.w8),
            Text(
              ManagerStrings.deleteAccountTitle,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s15,
                color: ManagerColors.logoutRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
