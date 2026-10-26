import 'dart:io';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/labeled_dropdown_field.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/add_edit_product_controller.dart';
import '../../data/request/add_variant_request.dart';
import '../../domain/model/product_model.dart';
import '../../domain/model/selected_color_entry.dart';
import 'color_picker_sheet.dart';

// ─── Shared card wrapper ──────────────────────────────────────────────────

class AddEditCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const AddEditCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: ManagerWidth.w36,
                  height: ManagerWidth.w36,
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
                SizedBox(width: ManagerWidth.w10),
                Text(
                  title,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h16),
            child,
          ],
        ),
      ),
    );
  }
}

// ─── Bottom submit bar ────────────────────────────────────────────────────

class AddEditBottomBar extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditBottomBar({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 1, color: const Color(0xFFEEEEEE)),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h12,
              ),
              child: Obx(() => ButtonApp(
                    title: ctrl.isEditMode
                        ? ManagerStrings.addProductSubmitEdit
                        : ManagerStrings.addProductSubmitAdd,
                    onPressed: ctrl.isSaving.value ? () {} : ctrl.submitForm,
                    paddingWidth: 0,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Section 1: Images ───────────────────────────────────────────────────

class AddEditImagesSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditImagesSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.photo_library_outlined,
      title: ManagerStrings.addProductSecImages,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ManagerStrings.addProductImagesTip,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h12),
          Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // Existing networked images (edit mode)
                    ...ctrl.existingImages.asMap().entries.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(left: ManagerWidth.w8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r10),
                              child: CachedNetworkImage(
                                imageUrl: e.value.imageUrl,
                                width: ManagerWidth.w80,
                                height: ManagerWidth.w80,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Container(
                                  width: ManagerWidth.w80,
                                  height: ManagerWidth.w80,
                                  color: ManagerColors.primaryColor
                                      .withOpacity(0.06),
                                ),
                                errorWidget: (_, __, ___) => Container(
                                  width: ManagerWidth.w80,
                                  height: ManagerWidth.w80,
                                  color: ManagerColors.primaryColor
                                      .withOpacity(0.06),
                                  child: Icon(Icons.broken_image_outlined,
                                      color: ManagerColors.greyWhiteColor),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () =>
                                    ctrl.removeExistingImage(e.value),
                                child: Container(
                                  width: ManagerWidth.w22,
                                  height: ManagerWidth.w22,
                                  decoration: const BoxDecoration(
                                    color: ManagerColors.redNew,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: ManagerColors.white,
                                    size: ManagerFontSize.s12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // New local images
                    ...ctrl.newImages.asMap().entries.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(left: ManagerWidth.w8),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r10),
                              child: Image.file(
                                File(e.value.path),
                                width: ManagerWidth.w80,
                                height: ManagerWidth.w80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 4,
                              right: 4,
                              child: GestureDetector(
                                onTap: () => ctrl.removeNewImage(e.key),
                                child: Container(
                                  width: ManagerWidth.w22,
                                  height: ManagerWidth.w22,
                                  decoration: const BoxDecoration(
                                    color: ManagerColors.redNew,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: ManagerColors.white,
                                    size: ManagerFontSize.s12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    // Add image button
                    Obx(() {
                      final total = ctrl.existingImages.length +
                          ctrl.newImages.length;
                      if (total >= AddEditProductController.maxImages) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: ManagerWidth.w8),
                        child: GestureDetector(
                          onTap: () => _showImageSourceSheet(context, ctrl),
                          child: Container(
                            width: ManagerWidth.w80,
                            height: ManagerWidth.w80,
                            decoration: BoxDecoration(
                              color: ManagerColors.primaryColor
                                  .withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r10),
                              border: Border.all(
                                color: ManagerColors.primaryColor
                                    .withOpacity(0.3),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_photo_alternate_outlined,
                                  color: ManagerColors.primaryColor,
                                  size: ManagerFontSize.s26,
                                ),
                                SizedBox(height: ManagerHeight.h4),
                                Text(
                                  ManagerStrings.addProductAddImage,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s10,
                                    color: ManagerColors.primaryColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

/// Bottom sheet letting the user choose between camera and gallery for product
/// images.
void _showImageSourceSheet(
    BuildContext context, AddEditProductController ctrl) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: ManagerColors.white,
    shape: RoundedRectangleBorder(
      borderRadius:
          BorderRadius.vertical(top: Radius.circular(ManagerRadius.r20)),
    ),
    builder: (sheetCtx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: ManagerHeight.h12),
          Container(
            width: ManagerWidth.w40,
            height: ManagerHeight.h4,
            decoration: BoxDecoration(
              color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(ManagerRadius.r4),
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          ListTile(
            leading: Icon(Icons.photo_camera_rounded,
                color: ManagerColors.primaryColor),
            title: Text(
              ManagerStrings.addProductTakePhoto,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(sheetCtx);
              ctrl.captureImage();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library_rounded,
                color: ManagerColors.primaryColor),
            title: Text(
              ManagerStrings.addProductPickFromGallery,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.black,
              ),
            ),
            onTap: () {
              Navigator.pop(sheetCtx);
              ctrl.pickImages();
            },
          ),
          SizedBox(height: ManagerHeight.h8),
        ],
      ),
    ),
  );
}

// ─── Section 2: Basic info ────────────────────────────────────────────────

class AddEditBasicInfoSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditBasicInfoSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.info_outline_rounded,
      title: ManagerStrings.addProductSecBasicInfo,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Arabic name + translate button
          LabeledTextField(
            label: ManagerStrings.addProductNameAr,
            hintText: ManagerStrings.addProductNameArHint,
            controller: ctrl.nameArCtrl,
            paddingWidth: 0,
          ),
          SizedBox(height: ManagerHeight.h8),
          Obx(() => SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed:
                      ctrl.isTranslating.value ? null : ctrl.translate,
                  icon: ctrl.isTranslating.value
                      ? SizedBox(
                          width: ManagerWidth.w14,
                          height: ManagerWidth.w14,
                          child: CircularProgressIndicator(
                            strokeWidth: 1.5,
                            color: ManagerColors.primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.translate_rounded,
                          size: ManagerFontSize.s16,
                          color: ManagerColors.primaryColor,
                        ),
                  label: Text(
                    ctrl.isTranslating.value
                        ? ManagerStrings.addProductTranslating
                        : ManagerStrings.addProductTranslate,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: ManagerColors.primaryColor.withOpacity(0.4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ManagerRadius.r8),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: ManagerHeight.h10,
                    ),
                  ),
                ),
              )),
          SizedBox(height: ManagerHeight.h14),
          LabeledTextField(
            label: ManagerStrings.addProductNameEn,
            hintText: ManagerStrings.addProductNameEnHint,
            controller: ctrl.nameEnCtrl,
            paddingWidth: 0,
          ),
          SizedBox(height: ManagerHeight.h14),
          LabeledTextField(
            label: ManagerStrings.addProductNameUr,
            hintText: ManagerStrings.addProductNameUrHint,
            controller: ctrl.nameUrCtrl,
            paddingWidth: 0,
          ),
          SizedBox(height: ManagerHeight.h14),
          // Category dropdown
          Obx(() {
            if (ctrl.isLoadingCategories.value) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
                child: Center(
                  child: SizedBox(
                    width: ManagerWidth.w24,
                    height: ManagerWidth.w24,
                    child: CircularProgressIndicator(
                      color: ManagerColors.primaryColor,
                      strokeWidth: 2,
                    ),
                  ),
                ),
              );
            }
            return LabeledDropdownField<String>(
              label: ManagerStrings.addProductSecCategory,
              hint: ManagerStrings.addProductCategoryHint,
              value: ctrl.selectedCategoryId.value.isEmpty
                  ? null
                  : ctrl.selectedCategoryId.value,
              items: ctrl.categories
                  .map((c) => DropdownMenuItem<String>(
                        value: c.id,
                        child: Text(c.name),
                      ))
                  .toList(),
              onChanged: (id) {
                if (id == null) return;
                final cat = ctrl.categories.firstWhere((c) => c.id == id);
                ctrl.selectCategory(cat);
              },
            );
          }),
          SizedBox(height: ManagerHeight.h14),
          // Price row
          Row(
            children: [
              Expanded(
                child: LabeledTextField(
                  label: ManagerStrings.addProductPriceLabel,
                  hintText: ManagerStrings.addProductPriceHint,
                  controller: ctrl.priceCtrl,
                  keyboardType: TextInputType.number,
                  paddingWidth: 0,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: LabeledTextField(
                  label: ManagerStrings.addProductOriginalPrice,
                  hintText: ManagerStrings.addProductOriginalPriceHint,
                  controller: ctrl.originalPriceCtrl,
                  keyboardType: TextInputType.number,
                  paddingWidth: 0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Section 3: Colors ────────────────────────────────────────────────────

class AddEditColorsSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditColorsSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.palette_outlined,
      title: ManagerStrings.addProductSecColors,
      child: Obx(() {
        final predefined = AddEditProductController.kPredefinedColors;
        final predefinedHexes =
            predefined.map((e) => e['hex']!.toUpperCase()).toSet();
        final selectedHexCodes = ctrl.selectedColors
            .map((c) => c.hexCode.toUpperCase())
            .toSet();
        // Custom colors added by user (not in predefined list)
        final customEntries = ctrl.selectedColors
            .where((c) => !predefinedHexes.contains(c.hexCode.toUpperCase()))
            .toList();
        final totalItems = predefined.length + customEntries.length + 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            mainAxisSpacing: ManagerHeight.h12,
            crossAxisSpacing: ManagerWidth.w8,
            childAspectRatio: 0.72,
          ),
          itemCount: totalItems,
          itemBuilder: (ctx, i) {
            // Last cell — "add custom color" button
            if (i == totalItems - 1) {
              return GestureDetector(
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => ColorPickerSheet(ctrl: ctrl),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                ManagerColors.primaryColor.withOpacity(0.06),
                            border: Border.all(
                              color: ManagerColors.primaryColor
                                  .withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            color: ManagerColors.primaryColor,
                            size: ManagerFontSize.s18,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      ManagerStrings.addProductAddCustomColor,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s9,
                        color: ManagerColors.primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            // Resolve entry: predefined first, then custom
            final SelectedColorEntry entry;
            if (i < predefined.length) {
              final item = predefined[i];
              entry = SelectedColorEntry(
                  nameAr: item['nameAr']!, hexCode: item['hex']!);
            } else {
              entry = customEntries[i - predefined.length];
            }

            final isSelected =
                selectedHexCodes.contains(entry.hexCode.toUpperCase());
            return GestureDetector(
              onTap: () => ctrl.toggleColor(entry),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: entry.toColor(),
                          border: Border.all(
                            color: isSelected
                                ? ManagerColors.primaryColor
                                : Colors.grey.shade300,
                            width: isSelected ? 2.5 : 1.0,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: ManagerColors.primaryColor
                                        .withOpacity(0.3),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  )
                                ]
                              : null,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                color: _isLightColor(entry.toColor())
                                    ? Colors.black87
                                    : Colors.white,
                                size: ManagerFontSize.s13,
                              )
                            : null,
                      ),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h4),
                  Text(
                    AddEditProductController.localizedColorName(
                      entry.hexCode,
                      fallback: entry.nameAr,
                    ),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s9,
                      color: isSelected
                          ? ManagerColors.primaryColor
                          : ManagerColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

// ─── Section 4: Sizes ────────────────────────────────────────────────────

class AddEditSizesSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditSizesSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.straighten_outlined,
      title: ManagerStrings.addProductSecSizes,
      child: Obx(() => Wrap(
            spacing: ManagerWidth.w10,
            runSpacing: ManagerHeight.h10,
            children: AddEditProductController.kAvailableSizes.map((size) {
              final isSelected = ctrl.isSizeSelected(size);
              return GestureDetector(
                onTap: () => ctrl.toggleSize(size),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: ManagerWidth.w56,
                  height: ManagerHeight.h44,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ManagerColors.primaryColor
                        : ManagerColors.primaryColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                    border: Border.all(
                      color: isSelected
                          ? ManagerColors.primaryColor
                          : ManagerColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      size,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: isSelected
                            ? ManagerColors.white
                            : ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          )),
    );
  }
}

// ─── Section 5: Stock (kept for reference — not used in current form) ─────

class AddEditStockSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditStockSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─── Section 6: Description (kept for reference — not used in current form)

class AddEditDescriptionSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditDescriptionSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}

// ─── Section 7: Delivery time ─────────────────────────────────────────────

class AddEditDeliverySection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditDeliverySection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.local_shipping_outlined,
      title: ManagerStrings.addProductSecDelivery,
      child: Row(
        children: [
          Expanded(
            child: LabeledTextField(
              label: ManagerStrings.addProductDeliveryMin,
              hintText: '1',
              controller: ctrl.deliveryMinCtrl,
              keyboardType: TextInputType.number,
              paddingWidth: 0,
              suffixWidget: Text(
                ManagerStrings.addProductDeliveryDay,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          Expanded(
            child: LabeledTextField(
              label: ManagerStrings.addProductDeliveryMax,
              hintText: '7',
              controller: ctrl.deliveryMaxCtrl,
              keyboardType: TextInputType.number,
              paddingWidth: 0,
              suffixWidget: Text(
                ManagerStrings.addProductDeliveryDay,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Section 8: Care instructions ────────────────────────────────────────

class AddEditCareInstructionsSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditCareInstructionsSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return _AddEditChipListSection(
      ctrl: ctrl,
      icon: Icons.dry_cleaning_outlined,
      title: ManagerStrings.addProductSecCareInstructions,
      hintText: ManagerStrings.addProductCareHint,
      items: ctrl.careInstructions,
      onAdd: ctrl.addCareInstruction,
      onRemove: ctrl.removeCareInstruction,
    );
  }
}

// ─── Section 9: Features ─────────────────────────────────────────────────

class AddEditFeaturesSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditFeaturesSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return _AddEditChipListSection(
      ctrl: ctrl,
      icon: Icons.star_outline_rounded,
      title: ManagerStrings.addProductSecFeatures,
      hintText: ManagerStrings.addProductFeaturesHint,
      items: ctrl.features,
      onAdd: ctrl.addFeature,
      onRemove: ctrl.removeFeature,
    );
  }
}

/// Shared chip-list section used for care instructions and features.
class _AddEditChipListSection extends StatefulWidget {
  final AddEditProductController ctrl;
  final IconData icon;
  final String title;
  final String hintText;
  final RxList<String> items;
  final void Function(String) onAdd;
  final void Function(int) onRemove;

  const _AddEditChipListSection({
    required this.ctrl,
    required this.icon,
    required this.title,
    required this.hintText,
    required this.items,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  State<_AddEditChipListSection> createState() =>
      _AddEditChipListSectionState();
}

class _AddEditChipListSectionState extends State<_AddEditChipListSection> {
  final _ctrl = TextEditingController();

  void _submit() {
    widget.onAdd(_ctrl.text);
    _ctrl.clear();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: widget.icon,
      title: widget.title,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => widget.items.isEmpty
              ? const SizedBox.shrink()
              : Wrap(
                  spacing: ManagerWidth.w8,
                  runSpacing: ManagerHeight.h8,
                  children: widget.items.asMap().entries.map((e) {
                    return Chip(
                      label: Text(
                        e.value,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.black,
                        ),
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        size: ManagerFontSize.s14,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      onDeleted: () => widget.onRemove(e.key),
                      backgroundColor:
                          ManagerColors.primaryColor.withOpacity(0.06),
                      side: BorderSide(
                        color: ManagerColors.primaryColor.withOpacity(0.2),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r8),
                      ),
                    );
                  }).toList(),
                )),
          SizedBox(height: ManagerHeight.h12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _ctrl,
                  onSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w12,
                      vertical: ManagerHeight.h10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      borderSide: BorderSide(
                        color: ManagerColors.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      borderSide: BorderSide(
                        color: ManagerColors.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      borderSide: BorderSide(
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    isDense: true,
                  ),
                ),
              ),
              SizedBox(width: ManagerWidth.w8),
              GestureDetector(
                onTap: _submit,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w14,
                    vertical: ManagerHeight.h10,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor,
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                  child: Text(
                    ManagerStrings.addProductAddItem,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Section 10: Variant quantity matrix (create mode) ──────────────────

class AddEditVariantsQuantitySection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditVariantsQuantitySection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.grid_view_rounded,
      title: ManagerStrings.addProductSecVariants,
      child: Obx(() {
        final colors = ctrl.selectedColors;
        final sizes  = ctrl.selectedSizes;

        if (colors.isEmpty && sizes.isEmpty) {
          return Text(
            ManagerStrings.chooseColorsSizesFirst,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            if (sizes.isNotEmpty)
              Row(
                children: [
                  SizedBox(width: ManagerWidth.w80),
                  ...sizes.map((size) => SizedBox(
                        width: ManagerWidth.w60,
                        child: Center(
                          child: Text(
                            size,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            SizedBox(height: ManagerHeight.h8),
            // Rows per color
            ...colors.map((color) {
              return Padding(
                padding: EdgeInsets.only(bottom: ManagerHeight.h8),
                child: Row(
                  children: [
                    SizedBox(
                      width: ManagerWidth.w80,
                      child: Row(
                        children: [
                          Container(
                            width: ManagerWidth.w18,
                            height: ManagerWidth.w18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: color.toColor(),
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 1),
                            ),
                          ),
                          SizedBox(width: ManagerWidth.w4),
                          Expanded(
                            child: Text(
                              color.nameAr,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s10,
                                color: ManagerColors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...sizes.map((size) => SizedBox(
                          width: ManagerWidth.w60,
                          child: Obx(() => _QtyField(
                                value: ctrl.getVariantQty(
                                    color.hexCode, size),
                                onChanged: (v) => ctrl.setVariantQty(
                                    color.hexCode, size, v),
                              )),
                        )),
                  ],
                ),
              );
            }),
          ],
        );
      }),
    );
  }
}

/// Small quantity input field for the variant matrix.
class _QtyField extends StatefulWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _QtyField({required this.value, required this.onChanged});

  @override
  State<_QtyField> createState() => _QtyFieldState();
}

class _QtyFieldState extends State<_QtyField> {
  late final TextEditingController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = TextEditingController(
      text: widget.value > 0 ? widget.value.toString() : '',
    );
  }

  @override
  void didUpdateWidget(_QtyField old) {
    super.didUpdateWidget(old);
    if (old.value != widget.value) {
      final text = widget.value > 0 ? widget.value.toString() : '';
      if (_ctrl.text != text) _ctrl.text = text;
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
      child: TextField(
        controller: _ctrl,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (v) => widget.onChanged(int.tryParse(v) ?? 0),
        decoration: InputDecoration(
          hintText: '0',
          contentPadding: EdgeInsets.symmetric(
            vertical: ManagerHeight.h6,
            horizontal: ManagerWidth.w4,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r6),
            borderSide: BorderSide(
              color: ManagerColors.primaryColor.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r6),
            borderSide: BorderSide(
              color: ManagerColors.primaryColor.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r6),
            borderSide:
                BorderSide(color: ManagerColors.primaryColor),
          ),
          isDense: true,
        ),
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
    );
  }
}

// ─── Section 11: Existing variants (edit mode) ───────────────────────────

class AddEditExistingVariantsSection extends StatelessWidget {
  final AddEditProductController ctrl;

  const AddEditExistingVariantsSection({super.key, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return AddEditCard(
      icon: Icons.list_alt_rounded,
      title: ManagerStrings.addProductSecExistingVariants,
      child: Obx(() {
        final variants = ctrl.existingVariants;
        return Column(
          children: [
            ...variants.map((v) => _VariantListTile(
                  variant: v,
                  ctrl: ctrl,
                )),
            SizedBox(height: ManagerHeight.h12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () =>
                    _showVariantDialog(context, ctrl, variant: null),
                icon: Icon(
                  Icons.add_rounded,
                  color: ManagerColors.primaryColor,
                  size: ManagerFontSize.s16,
                ),
                label: Text(
                  ManagerStrings.addProductAddVariant,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: ManagerColors.primaryColor.withOpacity(0.4),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _VariantListTile extends StatelessWidget {
  final ProductVariantModel variant;
  final AddEditProductController ctrl;

  const _VariantListTile({required this.variant, required this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ManagerHeight.h8),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          // Color swatch
          Container(
            width: ManagerWidth.w22,
            height: ManagerWidth.w22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: SelectedColorEntry(
                nameAr: variant.color,
                hexCode: variant.hexCode,
              ).toColor(),
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          Expanded(
            child: Text(
              '${variant.color}  •  ${variant.size}  •  ${variant.quantity}',
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.black,
              ),
            ),
          ),
          // Edit
          GestureDetector(
            onTap: () =>
                _showVariantDialog(context, ctrl, variant: variant),
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w6),
              child: Icon(
                Icons.edit_outlined,
                size: ManagerFontSize.s16,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
          // Delete
          GestureDetector(
            onTap: () => ctrl.deleteVariant(variant.id),
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w6),
              child: Icon(
                Icons.delete_outline_rounded,
                size: ManagerFontSize.s16,
                color: ManagerColors.redNew,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Show dialog to add or edit a variant.
void _showVariantDialog(
  BuildContext context,
  AddEditProductController ctrl, {
  ProductVariantModel? variant,
}) {
  showDialog<void>(
    context: context,
    builder: (_) => _VariantDialog(ctrl: ctrl, variant: variant),
  );
}

class _VariantDialog extends StatefulWidget {
  final AddEditProductController ctrl;
  final ProductVariantModel? variant;

  const _VariantDialog({required this.ctrl, this.variant});

  @override
  State<_VariantDialog> createState() => _VariantDialogState();
}

class _VariantDialogState extends State<_VariantDialog> {
  late SelectedColorEntry? _selectedColor;
  late String? _selectedSize;
  final _qtyCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.variant != null) {
      final v = widget.variant!;
      _selectedColor = SelectedColorEntry(
          nameAr: v.color, hexCode: v.hexCode);
      _selectedSize = v.size;
      _qtyCtrl.text = v.quantity.toString();
    } else {
      _selectedColor = null;
      _selectedSize   = null;
    }
  }

  @override
  void dispose() {
    _qtyCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (_selectedColor == null || _selectedSize == null) return;
    final qty = int.tryParse(_qtyCtrl.text.trim()) ?? 0;
    if (qty <= 0) return;

    final req = AddVariantRequest(
      color: _selectedColor!.nameAr,
      colorHexCode: _selectedColor!.hexCode,
      size: _selectedSize!,
      quantity: qty,
    );

    if (widget.variant == null) {
      widget.ctrl.addVariant(req);
    } else {
      widget.ctrl.updateVariant(widget.variant!.id, req);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.variant == null
            ? ManagerStrings.addProductAddVariant
            : ManagerStrings.addProductEditVariant,
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s15,
          color: ManagerColors.black,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color
            Text(
              ManagerStrings.addProductVariantColor,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            Wrap(
              spacing: ManagerWidth.w6,
              runSpacing: ManagerHeight.h6,
              children: AddEditProductController.kPredefinedColors
                  .map((item) {
                final entry = SelectedColorEntry(
                    nameAr: item['nameAr']!, hexCode: item['hex']!);
                final isSelected =
                    _selectedColor?.hexCode.toUpperCase() ==
                        entry.hexCode.toUpperCase();
                return GestureDetector(
                  onTap: () => setState(() => _selectedColor = entry),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: ManagerWidth.w32,
                        height: ManagerWidth.w32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: entry.toColor(),
                          border: Border.all(
                            color: isSelected
                                ? ManagerColors.primaryColor
                                : Colors.grey.shade300,
                            width: isSelected ? 2.5 : 1,
                          ),
                        ),
                        child: isSelected
                            ? Icon(Icons.check_rounded,
                                color: Colors.white,
                                size: ManagerFontSize.s13)
                            : null,
                      ),
                      SizedBox(height: ManagerHeight.h2),
                      SizedBox(
                        width: ManagerWidth.w32,
                        child: Text(
                          AddEditProductController.localizedColorName(
                            entry.hexCode,
                            fallback: entry.nameAr,
                          ),
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s9,
                            color: ManagerColors.black,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: ManagerHeight.h14),
            // Size
            Text(
              ManagerStrings.addProductVariantSize,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            Wrap(
              spacing: ManagerWidth.w6,
              runSpacing: ManagerHeight.h6,
              children: AddEditProductController.kAvailableSizes.map((size) {
                final isSelected = _selectedSize == size;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSize = size),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w12,
                      vertical: ManagerHeight.h8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? ManagerColors.primaryColor
                          : ManagerColors.primaryColor.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(ManagerRadius.r6),
                      border: Border.all(
                        color: isSelected
                            ? ManagerColors.primaryColor
                            : ManagerColors.primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      size,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: isSelected
                            ? ManagerColors.white
                            : ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: ManagerHeight.h14),
            // Quantity
            Text(
              ManagerStrings.addProductVariantQty,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            TextField(
              controller: _qtyCtrl,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: '0',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  borderSide:
                      BorderSide(color: ManagerColors.primaryColor),
                ),
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w12,
                  vertical: ManagerHeight.h10,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            ManagerStrings.cancel,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: ManagerColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
          ),
          child: Text(
            widget.variant == null
                ? ManagerStrings.addProductAddVariant
                : ManagerStrings.addProductEditVariant,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.white,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Helpers ──────────────────────────────────────────────────────────────

bool _isLightColor(Color color) => color.computeLuminance() > 0.4;
