import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/user/profile/domain/di/di.dart';
import 'package:app_mobile/features/user/profile/presentation/controller/update_user_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Update User Profile Screen
// ─────────────────────────────────────────────────────────────────────────────

class UpdateUserProfileScreen extends StatefulWidget {
  final String initialFullName;
  final String phoneNumber;
  final String? initialImage;

  const UpdateUserProfileScreen({
    super.key,
    required this.initialFullName,
    required this.phoneNumber,
    this.initialImage,
  });

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  late UpdateUserProfileController _controller;

  @override
  void initState() {
    super.initState();
    initUpdateUserProfile(
      initialFullName: widget.initialFullName,
      phone: widget.phoneNumber,
      initialImage: widget.initialImage,
    );
    _controller = Get.find<UpdateUserProfileController>();
  }

  @override
  void dispose() {
    disposeUpdateUserProfile();
    super.dispose();
  }

  // ── Save flow ──────────────────────────────────────────────────────────────

  Future<void> _onSavePressed() async {
    FocusScope.of(context).unfocus();

    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.updateUserProfileConfirmTitle,
      subtitle: ManagerStrings.updateUserProfileConfirmSubtitle,
      confirmText: ManagerStrings.updateUserProfileConfirmYes,
      cancelText: ManagerStrings.updateUserProfileConfirmNo,
    );

    if (confirmed == true) {
      await _controller.submitUpdate();
    }
  }

  // ── Image bottom sheet ─────────────────────────────────────────────────────

  void _showImagePicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: ManagerColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r16),
        ),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h24,
            ),
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: ManagerWidth.w40,
                height: ManagerHeight.h4,
                decoration: BoxDecoration(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                ),
              ),
              SizedBox(height: ManagerHeight.h20),

              Text(
                ManagerStrings.updateUserProfileImagePickerTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h20),

              // Camera option
              _PickerOption(
                icon: Icons.camera_alt_rounded,
                label: ManagerStrings.updateUserProfileImageCamera,
                onTap: () {
                  Navigator.pop(context);
                  _controller.pickImage(ImageSource.camera);
                },
              ),
              SizedBox(height: ManagerHeight.h12),

              // Gallery option
              _PickerOption(
                icon: Icons.photo_library_rounded,
                label: ManagerStrings.updateUserProfileImageGallery,
                onTap: () {
                  Navigator.pop(context);
                  _controller.pickImage(ImageSource.gallery);
                },
              ),
              SizedBox(height: ManagerHeight.h16),

              // Cancel
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: double.infinity,
                  height: ManagerHeight.h46,
                  decoration: BoxDecoration(
                    color: ManagerColors.greyWhiteColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    ManagerStrings.updateUserProfileImageCancel,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: ManagerHeight.h8),
            ],
          ),
        ),
        );
      },
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          // ── Save button ────────────────────────────────────────────────────
          bottomNavigationBar: Obx(
            () => Container(
              color: ManagerColors.white,
              padding: EdgeInsets.fromLTRB(
                0,
                ManagerHeight.h12,
                0,
                ManagerHeight.h16,
              ),
              child: ButtonApp(
                title: ManagerStrings.updateUserProfileSaveButton,
                onPressed:
                    _controller.isLoading.value ? () {} : _onSavePressed,
                paddingWidth: ManagerWidth.w16,
              ),
            ),
          ),

          // ── Body ────────────────────────────────────────────────────────────
          body: Obx(
            () => Stack(
              children: [
                Column(
                  children: [
                    // ── App Bar ──────────────────────────────────────────────
                    CustomAppBar(
                      title: ManagerStrings.updateUserProfileTitle,
                      subtitle: ManagerStrings.updateUserProfileSubtitle,
                      showBackButton: true,
                      onBackPressed: () => Navigator.pop(context),
                    ),

                    // ── Scrollable Content ───────────────────────────────────
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
                            // ── Avatar picker ──────────────────────────────
                            _AvatarSection(
                              controller: _controller,
                              onTap: _showImagePicker,
                            ),
                            SizedBox(height: ManagerHeight.h24),

                            // ── Personal info card ─────────────────────────
                            _PersonalInfoCard(controller: _controller),
                            SizedBox(height: ManagerHeight.h16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // ── Loading overlay ─────────────────────────────────────────
                if (_controller.isLoading.value) const LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Avatar Section
// ══════════════════════════════════════════════════════════════════════════════

class _AvatarSection extends StatelessWidget {
  final UpdateUserProfileController controller;
  final VoidCallback onTap;

  const _AvatarSection({required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h143,
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          // Decorative background images
          Align(
            alignment: Alignment.bottomRight,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(ManagerImages.backgroundProfileImage1),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(ManagerImages.backgroundProfileImage2),
            ),
          ),

          // Avatar + edit badge
          Center(
            child: Obx(() {
              final localFile = controller.selectedImage.value;
              final networkUrl = controller.initialImage;

              return GestureDetector(
                onTap: onTap,
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
                          color: ManagerColors.primaryColor.withOpacity(0.4),
                          width: 2.5,
                        ),
                      ),
                      child: ClipOval(
                        child: _buildAvatarImage(localFile, networkUrl),
                      ),
                    ),

                    // Camera badge
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
                            color: ManagerColors.white,
                            width: 2,
                          ),
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
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarImage(dynamic localFile, String? networkUrl) {
    // Locally selected image takes priority
    if (localFile != null) {
      return Image.file(
        localFile,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }
    // Network image with proper loading/error states
    if (networkUrl != null && networkUrl.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: networkUrl,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        placeholder: (_, __) => _loadingPlaceholder(),
        errorWidget: (_, __, ___) => _defaultImage(),
      );
    }
    // No image at all — show default
    return _defaultImage();
  }

  /// Spinner shown while the network image is loading.
  Widget _loadingPlaceholder() {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.08),
      child: Center(
        child: SizedBox(
          width: ManagerWidth.w24,
          height: ManagerHeight.h24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              ManagerColors.primaryColor.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  /// Default profile image — shown on error or when no URL is provided.
  Widget _defaultImage() {
    return Image.asset(
      ManagerImages.defaultProfileImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Personal Info Card
// ══════════════════════════════════════════════════════════════════════════════

class _PersonalInfoCard extends StatelessWidget {
  final UpdateUserProfileController controller;

  const _PersonalInfoCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h20,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: ManagerFontSize.s16,
                color: ManagerColors.primaryColor,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                ManagerStrings.updateUserProfileSectionPersonal,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),

          SizedBox(height: ManagerHeight.h16),
          Divider(
            height: 1,
            thickness: 0.8,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),
          SizedBox(height: ManagerHeight.h16),

          // Full name field
          _FieldLabel(text: ManagerStrings.updateUserProfileNameLabel),
          SizedBox(height: ManagerHeight.h8),
          _EditableField(
            controller: controller.fullNameController,
            hintText: ManagerStrings.updateUserProfileNameHint,
            keyboardType: TextInputType.name,
          ),

          SizedBox(height: ManagerHeight.h16),

          // Phone number (read-only)
          _FieldLabel(text: ManagerStrings.updateUserProfilePhoneLabel),
          SizedBox(height: ManagerHeight.h8),
          _ReadOnlyField(
            value: controller.phone,
            note: ManagerStrings.updateUserProfilePhoneDisabledNote,
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Picker Option Row
// ══════════════════════════════════════════════════════════════════════════════

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: ManagerHeight.h52,
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(
            color: ManagerColors.primaryColor.withOpacity(0.15),
            width: 1,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        child: Row(
          children: [
            Container(
              width: ManagerWidth.w36,
              height: ManagerHeight.h36,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
              ),
              child: Icon(
                icon,
                color: ManagerColors.primaryColor,
                size: ManagerFontSize.s18,
              ),
            ),
            SizedBox(width: ManagerWidth.w12),
            Text(
              label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.black,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: ManagerFontSize.s13,
              color: ManagerColors.greyWhiteColor.withOpacity(0.5),
            ),
          ],
        ),
      ),
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
// Editable Text Field
// ══════════════════════════════════════════════════════════════════════════════

class _EditableField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  const _EditableField({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.25),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
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
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            borderSide: BorderSide(
              color: ManagerColors.primaryColor.withOpacity(0.4),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Read-only Field (phone number)
// ══════════════════════════════════════════════════════════════════════════════

class _ReadOnlyField extends StatelessWidget {
  final String value;
  final String note;

  const _ReadOnlyField({required this.value, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          width: 1,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h14,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              value,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          Icon(
            Icons.lock_outline_rounded,
            size: ManagerFontSize.s14,
            color: ManagerColors.greyWhiteColor.withOpacity(0.5),
          ),
          SizedBox(width: ManagerWidth.w4),
          Text(
            note,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.greyWhiteColor.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
