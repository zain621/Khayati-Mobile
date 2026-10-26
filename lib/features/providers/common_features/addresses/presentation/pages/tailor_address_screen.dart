import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/common_features/addresses/domain/model/address_model.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/controller/address_controller.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/widgets/add_address_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Address Screen — عنوان المستخدم / عنوان الخياط
// ─────────────────────────────────────────────────────────────────────────────

class TailorAddressScreen extends StatefulWidget {
  final bool isProvider;

  const TailorAddressScreen({
    super.key,
    this.isProvider = false,
  });

  @override
  State<TailorAddressScreen> createState() => _TailorAddressScreenState();
}

class _TailorAddressScreenState extends State<TailorAddressScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addressCtrl = Get.find<AddressController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Stack(
            children: [
              Column(
                children: [
                  // ── App Bar ──────────────────────────────────────────────────
                  CustomAppBar(
                    title: widget.isProvider
                        ? ManagerStrings.tailorAddressTitle
                        : ManagerStrings.profileManageAddressesTitle,
                    subtitle: widget.isProvider
                        ? ManagerStrings.tailorAddressSubtitle
                        : ManagerStrings.profileManageAddressesSubtitle,
                    showBackButton: true,
                    onBackPressed: () => Navigator.pop(context),
                  ),

                  // ── Content ──────────────────────────────────────────────────
                  Expanded(
                    child: Obx(() {
                      if (addressCtrl.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: ManagerColors.primaryColor,
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: addressCtrl.refreshAddress,
                        color: ManagerColors.primaryColor,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w16,
                            vertical: ManagerHeight.h24,
                          ),
                          child: addressCtrl.hasAddress
                              ? _AddressContent(
                                  address: addressCtrl.address.value!,
                                  animation: _controller,
                                  onEdit: _openEditDialog,
                                  cardTitle: widget.isProvider
                                      ? ManagerStrings.tailorAddressCardTitle
                                      : ManagerStrings
                                          .profileManageAddressesTitle,
                                )
                              : _EmptyContent(
                                  animation: _controller,
                                  onAdd: _openAddDialog,
                                  subtitle: widget.isProvider
                                      ? ManagerStrings
                                          .tailorAddressEmptySubtitle
                                      : ManagerStrings
                                          .profileManageAddressesSubtitle,
                                ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              // ── Loading overlay while submitting ──────────────────────────
              Obx(() => addressCtrl.isSubmitting.value
                  ? const LoadingWidget()
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  void _openAddDialog() async {
    final saved = await showAddAddressDialog(context);
    if (saved == true) _controller.forward(from: 0);
  }

  void _openEditDialog() async {
    final addr = Get.find<AddressController>().address.value;
    if (addr == null) return;
    final saved = await showAddAddressDialog(
      context,
      initialName: addr.fullName,
      initialLatitude: addr.latitude,
      initialLongitude: addr.longitude,
      initialDetail: addr.detailedDescription,
      isEdit: true,
    );
    if (saved == true) _controller.forward(from: 0);
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Content when address exists
// ══════════════════════════════════════════════════════════════════════════════

class _AddressContent extends StatelessWidget {
  final AddressModel address;
  final AnimationController animation;
  final VoidCallback onEdit;
  final String cardTitle;

  const _AddressContent({
    required this.address,
    required this.animation,
    required this.onEdit,
    required this.cardTitle,
  });

  @override
  Widget build(BuildContext context) {
    // ── Staggered intervals ───────────────────────────────────────────────
    final illustrationAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
    );
    final cardAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.3, 0.78, curve: Curves.easeOutCubic),
    );
    final buttonAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.55, 0.9, curve: Curves.easeOut),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Illustration: scale + fade ────────────────────────────────────
        FadeTransition(
          opacity: illustrationAnim,
          child: ScaleTransition(
            scale:
                Tween<double>(begin: 0.82, end: 1.0).animate(illustrationAnim),
            child: Center(
              child: CustomSvgImage(
                path: ManagerImages.locationAvatar,
                height: ManagerHeight.h235,
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h24),

        // ── Address Card: slide up + fade ─────────────────────────────────
        FadeTransition(
          opacity: cardAnim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.2),
              end: Offset.zero,
            ).animate(cardAnim),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h12,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r16),
                boxShadow: [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.07),
                    blurRadius: 20,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card header
                  Text(
                    cardTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: ManagerWidth.w42,
                        height: ManagerHeight.h42,
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w10,
                              vertical: ManagerHeight.h10),
                          child: CustomSvgImage(
                            path: ManagerIcons.homeLocation,
                            height: ManagerWidth.w20,
                            width: ManagerWidth.w20,
                          ),
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              address.fullName,
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s14,
                                color: ManagerColors.black,
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h2),
                            Text(
                              address.detailedDescription,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s13,
                                color: ManagerColors.greyWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h12),

                  // ── Selected map coordinates ─────────────────────────────
                  Row(
                    children: [
                      const Icon(
                        Icons.my_location_outlined,
                        color: ManagerColors.greyWhiteColor,
                        size: 16,
                      ),
                      SizedBox(width: ManagerWidth.w6),
                      Expanded(
                        child: Text(
                          '${address.latitude.toStringAsFixed(5)}, ${address.longitude.toStringAsFixed(5)}',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h12),

                  // ── Edit button: fade + press-scale ──────────────────────
                  FadeTransition(
                    opacity: buttonAnim,
                    child: _PressScaleButton(
                      onTap: onEdit,
                      child: Container(
                        height: ManagerHeight.h32,
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor.withOpacity(0.08),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.edit_outlined,
                              color: ManagerColors.primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: ManagerWidth.w6),
                            Text(
                              ManagerStrings.tailorAddressEditButton,
                              style: getMediumTextStyle(
                                fontSize: ManagerFontSize.s13,
                                color: ManagerColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h20),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Empty State Content
// ══════════════════════════════════════════════════════════════════════════════

class _EmptyContent extends StatelessWidget {
  final AnimationController animation;
  final VoidCallback onAdd;
  final String subtitle;

  const _EmptyContent({
    required this.animation,
    required this.onAdd,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final illustrationAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutBack),
    );
    final titleAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.35, 0.72, curve: Curves.easeOutCubic),
    );
    final subtitleAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.5, 0.85, curve: Curves.easeOutCubic),
    );
    final buttonAnim = CurvedAnimation(
      parent: animation,
      curve: const Interval(0.65, 1.0, curve: Curves.easeOut),
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: ManagerHeight.h40),

          // Illustration: scale + fade
          FadeTransition(
            opacity: illustrationAnim,
            child: ScaleTransition(
              scale:
                  Tween<double>(begin: 0.8, end: 1.0).animate(illustrationAnim),
              child: CustomSvgImage(
                path: ManagerImages.locationAvatar,
                height: ManagerHeight.h200,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),

          // Title: fade + slide up
          FadeTransition(
            opacity: titleAnim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(titleAnim),
              child: Text(
                ManagerStrings.tailorAddressEmptyTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h8),

          // Subtitle: fade + slide up (slightly delayed)
          FadeTransition(
            opacity: subtitleAnim,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.3),
                end: Offset.zero,
              ).animate(subtitleAnim),
              child: Text(
                subtitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),

          FadeTransition(
            opacity: buttonAnim,
            child: _PressScaleButton(
              onTap: onAdd,
              child: Container(
                width: double.infinity,
                height: ManagerHeight.h46,
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor,
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_location_alt_outlined,
                      color: ManagerColors.white,
                      size: 18,
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    Text(
                      ManagerStrings.tailorAddressAddButton,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Press-scale button wrapper
// ══════════════════════════════════════════════════════════════════════════════

class _PressScaleButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;

  const _PressScaleButton({required this.onTap, required this.child});

  @override
  State<_PressScaleButton> createState() => _PressScaleButtonState();
}

class _PressScaleButtonState extends State<_PressScaleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
      reverseDuration: const Duration(milliseconds: 160),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.forward(),
      child: ScaleTransition(scale: _ctrl, child: widget.child),
    );
  }
}
