import 'dart:io';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Page 2 — Budget & Timeline (الميزانية والتوقيت)
// ═══════════════════════════════════════════════════════════════════════════════

class OrderBudgetPage extends StatelessWidget {
  final TextEditingController minBudgetController;
  final TextEditingController maxBudgetController;
  final DateTime? selectedDeadline;
  final RxList<File> referenceImages;
  final VoidCallback onPickDeadline;
  final VoidCallback onAddImages;
  final ValueChanged<int> onRemoveImage;

  const OrderBudgetPage({
    super.key,
    required this.minBudgetController,
    required this.maxBudgetController,
    required this.selectedDeadline,
    required this.referenceImages,
    required this.onPickDeadline,
    required this.onAddImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h16),

          // ── White card: heading + budget + deadline ────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Container(
              decoration: BoxDecoration(
                color: ManagerColors.white,
                boxShadow: [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12, vertical: ManagerHeight.h16),
                child: Column(
                  children: [
                    // ── Page heading card ──────────────────────────────────
                    _PageHeadingCard(
                      title: ManagerStrings.createOrderPage2Heading,
                      subtitle: ManagerStrings.createOrderPage2SubHeading,
                    ),

                    SizedBox(height: ManagerHeight.h24),

                    // ── الميزانية المتوقعة ─────────────────────────────────
                    Row(
                      children: [
                        Expanded(
                          child: LabeledTextField(
                            label: ManagerStrings.createOrderMinBudgetLabel,
                            hintText: ManagerStrings.createOrderMinBudgetHint,
                            controller: minBudgetController,
                            keyboardType: TextInputType.number,
                            paddingWidth: 0,
                            validator: (_) =>
                                minBudgetController.text.trim().isEmpty
                                    ? ManagerStrings.createOrderValidateMinBudget
                                    : null,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w12),
                        Expanded(
                          child: LabeledTextField(
                            label: ManagerStrings.createOrderMaxBudgetLabel,
                            hintText: ManagerStrings.createOrderMaxBudgetHint,
                            controller: maxBudgetController,
                            keyboardType: TextInputType.number,
                            paddingWidth: 0,
                            validator: (_) =>
                                maxBudgetController.text.trim().isEmpty
                                    ? ManagerStrings.createOrderValidateMaxBudget
                                    : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: ManagerHeight.h6),

                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Text(
                        ManagerStrings.createOrderBudgetNote,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    // ── تاريخ التسليم ──────────────────────────────────────
                    _LabeledDatePicker(
                      label: ManagerStrings.createOrderDeadlineLabel,
                      selectedDeadline: selectedDeadline,
                      onTap: onPickDeadline,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),

          // ── صور مشابهة (outside card — same as fabric grid) ──────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: _ImagesHeading(),
          ),

          SizedBox(height: ManagerHeight.h12),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Obx(() {
              final images = referenceImages.toList();
              return _ImageUploadArea(
                images: images,
                onAddImages: onAddImages,
                onRemoveImage: onRemoveImage,
              );
            }),
          ),

          SizedBox(height: ManagerHeight.h16),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Page Heading Card — matches order_details_page style exactly
// ═══════════════════════════════════════════════════════════════════════════════

class _PageHeadingCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _PageHeadingCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: ManagerWidth.w48,
          height: ManagerHeight.h48,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
            child: CustomSvgImage(
              path: ManagerIcons.walletIcon,
            ),
          ),
        ),
        SizedBox(width: ManagerWidth.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h4),
              Text(
                subtitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Labeled Date Picker — label + tappable date field
// ═══════════════════════════════════════════════════════════════════════════════

class _LabeledDatePicker extends StatelessWidget {
  final String label;
  final DateTime? selectedDeadline;
  final VoidCallback onTap;

  const _LabeledDatePicker({
    required this.label,
    required this.selectedDeadline,
    required this.onTap,
  });

  String get _displayText {
    if (selectedDeadline == null) return ManagerStrings.createOrderDeadlineHint;
    final d = selectedDeadline!;
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h12,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
              border: Border.all(
                color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  color: ManagerColors.primaryColor,
                  size: ManagerWidth.w18,
                ),
                Text(
                  _displayText,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: selectedDeadline != null
                        ? ManagerColors.black
                        : ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Images Section Heading — matches fabric label style
// ═══════════════════════════════════════════════════════════════════════════════

class _ImagesHeading extends StatelessWidget {
  const _ImagesHeading();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: ManagerWidth.w40,
          height: ManagerHeight.h40,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
          ),
          child: Icon(
            Icons.photo_library_outlined,
            color: ManagerColors.primaryColor,
            size: ManagerWidth.w20,
          ),
        ),
        SizedBox(width: ManagerWidth.w12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ManagerStrings.createOrderImagesLabel,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h2),
              Text(
                ManagerStrings.createOrderImagesSubtitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Image Upload Area — empty state + grid with thumbnails
// ═══════════════════════════════════════════════════════════════════════════════

class _ImageUploadArea extends StatelessWidget {
  final List<File> images;
  final VoidCallback onAddImages;
  final ValueChanged<int> onRemoveImage;

  const _ImageUploadArea({
    required this.images,
    required this.onAddImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return _EmptyUploadArea(onTap: onAddImages);

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length + 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: ManagerWidth.w8,
        mainAxisSpacing: ManagerHeight.h8,
      ),
      itemBuilder: (_, index) {
        if (index == images.length) {
          return GestureDetector(
            onTap: onAddImages,
            child: Container(
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
                border: Border.all(
                  color: ManagerColors.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Icon(
                Icons.add_rounded,
                color: ManagerColors.primaryColor,
                size: ManagerWidth.w28,
              ),
            ),
          );
        }
        return _ImageThumbnail(
          file: images[index],
          onRemove: () => onRemoveImage(index),
        );
      },
    );
  }
}

class _EmptyUploadArea extends StatelessWidget {
  final VoidCallback onTap;

  const _EmptyUploadArea({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(ManagerRadius.r12),
        color: ManagerColors.primaryColor.withOpacity(0.5),
        strokeWidth: 1.5,
        dashPattern: const [8, 5],
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h32),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.02),
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
          ),
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ManagerWidth.w52,
              height: ManagerHeight.h52,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_upload_outlined,
                color: ManagerColors.primaryColor,
                size: ManagerWidth.w28,
              ),
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              ManagerStrings.createOrderImagesUpload,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.primaryColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h4),
            Text(
              ManagerStrings.createOrderImagesFormats,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Image Thumbnail with remove button
// ═══════════════════════════════════════════════════════════════════════════════

class _ImageThumbnail extends StatelessWidget {
  final File file;
  final VoidCallback onRemove;

  const _ImageThumbnail({required this.file, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          child: Image.file(
            file,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: -6,
          left: -6,
          child: GestureDetector(
            onTap: onRemove,
            child: Container(
              width: ManagerWidth.w20,
              height: ManagerHeight.h20,
              decoration: const BoxDecoration(
                color: Color(0xFFE53935),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: ManagerColors.white,
                size: ManagerWidth.w12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
