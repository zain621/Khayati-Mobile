import 'dart:io';
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
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:app_mobile/features/providers/common_features/profile/domain/di/di.dart'
    as profile_di;
import '../controller/update_provider_profile_controller.dart';
import '../controller/provider_profile_controller.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Update Profile Screen — تعديل الملف الشخصي (Provider)
// ─────────────────────────────────────────────────────────────────────────────

class UpdateProfileProviderScreen extends StatefulWidget {
  final bool isUser;
  const UpdateProfileProviderScreen({super.key, required this.isUser});

  @override
  State<UpdateProfileProviderScreen> createState() =>
      _UpdateProfileProviderScreenState();
}

class _UpdateProfileProviderScreenState
    extends State<UpdateProfileProviderScreen> {
  late UpdateProviderProfileController _c;
  late TextEditingController _phoneController;

  static const int _maxBio = 500;

  @override
  void initState() {
    super.initState();
    profile_di.initUpdateProviderProfile();
    _c = Get.find<UpdateProviderProfileController>();
    final phone =
        Get.find<ProviderProfileController>().profile.value?.phoneNumber ?? '';
    _phoneController = TextEditingController(text: phone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    profile_di.disposeUpdateProviderProfile();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          // ── Fixed save button ──────────────────────────────────────────────
          bottomNavigationBar: Container(
            color: ManagerColors.white,
            padding:
                EdgeInsets.fromLTRB(0, ManagerHeight.h12, 0, ManagerHeight.h16),
            child: Obx(() => ButtonApp(
              title: _c.isSaving.value
                  ? ''
                  : ManagerStrings.updateProfileSaveButton,
              onPressed: _c.isSaving.value ? () {} : _onSave,
              paddingWidth: ManagerWidth.w16,
            )),
          ),
          body: Stack(
            children: [
            Column(
            children: [
              // ── App Bar ────────────────────────────────────────────────────
              CustomAppBar(
                title: ManagerStrings.updateProfileTitle,
                subtitle: ManagerStrings.updateProfileSubtitle,
                showBackButton: true,
                onBackPressed: () => Navigator.pop(context),
              ),

              // ── Scrollable Content ─────────────────────────────────────────
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
                      // ── Avatar ─────────────────────────────────────────────
                      Container(
                        height: ManagerHeight.h143,
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
                            ]),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                ManagerImages.updateProfileBackground,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _AvatarPicker(
                                    controller: _c,
                                    networkImageUrl: Get.find<ProviderProfileController>().profile.value?.image,
                                  ),
                                  SizedBox(height: ManagerHeight.h8),
                                  Text(
                                    ManagerStrings.updateProfileAvatarHint,
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s12,
                                      color: ManagerColors.greyWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h16),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w12,
                            vertical: ManagerHeight.h16),
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
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Section header ─────────────────────────────────────
                            _SectionLabel(
                              icon: Icons.person_outline_rounded,
                              label: ManagerStrings.updateProfileSectionLabel,
                            ),

                            SizedBox(height: ManagerHeight.h14),

                            // ── Name field(s) based on role ──────────────────────
                            if (_c.isShopOwner) ...[
                              _FieldLabel(text: ManagerStrings.updateProfileNameArLabel),
                              SizedBox(height: ManagerHeight.h6),
                              _InputField(
                                controller: _c.nameArController,
                                hintText: ManagerStrings.updateProfileNameArLabel,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(height: ManagerHeight.h16),
                              _FieldLabel(text: ManagerStrings.updateProfileNameEnLabel),
                              SizedBox(height: ManagerHeight.h6),
                              _InputField(
                                controller: _c.nameEnController,
                                hintText: ManagerStrings.updateProfileNameEnLabel,
                                keyboardType: TextInputType.name,
                              ),
                            ] else ...[
                              _FieldLabel(text: ManagerStrings.updateProfileNameLabel),
                              SizedBox(height: ManagerHeight.h6),
                              _InputField(
                                controller: _c.fullNameController,
                                hintText: ManagerStrings.updateProfileNameHint,
                                keyboardType: TextInputType.name,
                              ),
                              SizedBox(height: ManagerHeight.h16),
                              // ── Phone (disabled) ─────────────────────────────────
                              _FieldLabel(text: ManagerStrings.updateProfilePhoneLabel),
                              SizedBox(height: ManagerHeight.h6),
                              _InputField(
                                controller: _phoneController,
                                hintText: ManagerStrings.updateProfilePhoneHint,
                                keyboardType: TextInputType.phone,
                                enabled: false,
                              ),
                            ],

                            SizedBox(height: ManagerHeight.h16),

                            if (widget.isUser != true) ...[
                              // ── Bio ────────────────────────────────────────────────
                              _FieldLabel(
                                  text: ManagerStrings.updateProfileBioLabel),
                              SizedBox(height: ManagerHeight.h6),
                              _BioField(
                                controller: _c.bioController,
                                maxLength: _maxBio,
                              ),
                            ],
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
          // ── Loading overlay ──────────────────────────────────────────────
          Obx(() => _c.isSaving.value
              ? const LoadingWidget()
              : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }

  void _onSave() {
    FocusScope.of(context).unfocus();
    if (_c.isShopOwner) {
      _c.saveShopProfile();
    } else {
      _c.saveTailorProfile();
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Avatar Picker Widget
// ══════════════════════════════════════════════════════════════════════════════

class _AvatarPicker extends StatelessWidget {
  final UpdateProviderProfileController controller;
  final String? networkImageUrl;

  const _AvatarPicker({
    required this.controller,
    this.networkImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.pickImage,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Avatar circle
          Container(
            width: ManagerWidth.w93,
            height: ManagerHeight.h93,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ManagerColors.primaryColor.withOpacity(0.3),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Obx(() {
                final picked = controller.pickedImage.value;
                if (picked != null) {
                  return Image.file(File(picked.path), fit: BoxFit.cover);
                }
                if (networkImageUrl != null && networkImageUrl!.isNotEmpty) {
                  return CachedNetworkImage(
                    imageUrl: networkImageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => _placeholder(),
                    errorWidget: (_, __, ___) => _placeholder(),
                  );
                }
                return _placeholder();
              }),
            ),
          ),

          // Edit camera badge
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: ManagerWidth.w28,
              height: ManagerHeight.h28,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(
                    color: ManagerColors.white.withOpacity(0.7),
                    width: 2),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: ManagerColors.white,
                size: ManagerFontSize.s14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: ManagerColors.greyWhiteColor.withOpacity(0.12),
      child: Icon(
        Icons.person,
        size: ManagerFontSize.s40,
        color: ManagerColors.greyWhiteColor.withOpacity(0.4),
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
// Input Field
// ══════════════════════════════════════════════════════════════════════════════

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool enabled;

  const _InputField({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bg = enabled
        ? ManagerColors.white
        : ManagerColors.greyWhiteColor.withOpacity(0.08);

    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: enabled
              ? ManagerColors.greyWhiteColor.withOpacity(0.2)
              : ManagerColors.greyWhiteColor.withOpacity(0.12),
          width: 1,
        ),
        // boxShadow: enabled
        //     ? [
        //         BoxShadow(
        //           color: ManagerColors.black.withOpacity(0.04),
        //           blurRadius: 8,
        //           offset: const Offset(0, 2),
        //         ),
        //       ]
        //     : null,
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        textAlign: TextAlign.start,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s14,
          color: enabled ? ManagerColors.black : ManagerColors.greyWhiteColor,
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
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Bio Text Area with char counter
// ══════════════════════════════════════════════════════════════════════════════

class _BioField extends StatefulWidget {
  final TextEditingController controller;
  final int maxLength;

  const _BioField({required this.controller, required this.maxLength});

  @override
  State<_BioField> createState() => _BioFieldState();
}

class _BioFieldState extends State<_BioField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.controller.text.length;

    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: widget.controller,
            maxLines: 5,
            minLines: 4,
            maxLength: widget.maxLength,
            buildCounter: (_,
                    {required currentLength, required isFocused, maxLength}) =>
                const SizedBox.shrink(),
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
            decoration: InputDecoration(
              hintText: ManagerStrings.updateProfileBioHint,
              hintStyle: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h12,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
          // Counter
          Padding(
            padding: EdgeInsets.only(
              right: ManagerWidth.w12,
              left: ManagerWidth.w12,
              bottom: ManagerHeight.h8,
            ),
            child: Text(
              '$count/${widget.maxLength}',
              textAlign: TextAlign.start,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
