import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Page 1 — Order Details (ماذا تريد؟)
// ═══════════════════════════════════════════════════════════════════════════════

class OrderDetailsPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descController;
  final TextEditingController specialRequestsController;
  final String? selectedFabric;
  final ValueChanged<String> onFabricSelected;

  const OrderDetailsPage({
    super.key,
    required this.nameController,
    required this.descController,
    required this.specialRequestsController,
    required this.selectedFabric,
    required this.onFabricSelected,
  });

  static final List<String> _fabrics = [
    ManagerStrings.createOrderFabricChiffon,
    ManagerStrings.createOrderFabricCrepe,
    ManagerStrings.createOrderFabricCotton,
    ManagerStrings.createOrderFabricSilk,
    ManagerStrings.createOrderFabricVelvet,
    ManagerStrings.createOrderFabricOther,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      // padding: EdgeInsets.symmetric(
      //   horizontal: ManagerWidth.w20,
      //   vertical: ManagerHeight.h20,
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Container(
              // height: ManagerHeight.h,
              decoration: BoxDecoration(color: ManagerColors.white, boxShadow: [
                BoxShadow(
                  color: ManagerColors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12, vertical: ManagerHeight.h16),
                child: Column(
                  children: [
                    // ── Page heading card ──────────────────────────────────────────
                    _PageHeadingCard(
                      icon: Icons.checkroom_rounded,
                      title: ManagerStrings.createOrderPage1Heading,
                      subtitle: ManagerStrings.createOrderPage1SubHeading,
                    ),
                    SizedBox(height: ManagerHeight.h24),

                    // ── اسم الملبس ─────────────────────────────────────────────────
                    LabeledTextField(
                      label: ManagerStrings.createOrderNameLabel,
                      hintText: ManagerStrings.createOrderNameHint,
                      controller: nameController,
                      paddingWidth: 0,
                      validator: (_) => nameController.text.trim().isEmpty
                          ? ManagerStrings.createOrderValidateName
                          : null,
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    // ── وصف الملبس والتفاصيل ───────────────────────────────────────
                    LabeledTextField(
                      label: ManagerStrings.createOrderDescLabel,
                      hintText: ManagerStrings.createOrderDescHint,
                      controller: descController,
                      minLines: 4,
                      maxLines: 4,
                      paddingWidth: 0,
                      validator: (_) => descController.text.trim().isEmpty
                          ? ManagerStrings.createOrderValidateDesc
                          : null,
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    // ── طلبات خاصة (اختياري) ──────────────────────────────────────
                    LabeledTextField(
                      label: ManagerStrings.createOrderSpecialLabel,
                      hintText: ManagerStrings.createOrderSpecialHint,
                      controller: specialRequestsController,
                      paddingWidth: 0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),

          // ── نوع القماش ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: _SectionLabel(label: ManagerStrings.createOrderFabricLabel)),
          SizedBox(height: ManagerHeight.h12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: _FabricGrid(
              fabrics: _fabrics,
              selectedFabric: selectedFabric,
              onSelected: onFabricSelected,
            ),
          ),

          SizedBox(height: ManagerHeight.h16),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Page Heading Card — icon + title + subtitle
// ═══════════════════════════════════════════════════════════════════════════════

class _PageHeadingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PageHeadingCard({
    required this.icon,
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
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12,),
            child: CustomSvgImage(
              path: ManagerIcons.customOfferIcon,
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
// ── Section Label
// ═══════════════════════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        label,
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s13,
          color: ManagerColors.black,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Fabric Type Grid
// ═══════════════════════════════════════════════════════════════════════════════

class _FabricGrid extends StatelessWidget {
  final List<String> fabrics;
  final String? selectedFabric;
  final ValueChanged<String> onSelected;

  const _FabricGrid({
    required this.fabrics,
    required this.selectedFabric,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: fabrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: ManagerWidth.w10,
        mainAxisSpacing: ManagerHeight.h10,
        childAspectRatio: 3.4,
      ),
      itemBuilder: (_, index) {
        final fabric = fabrics[index];
        final isSelected = selectedFabric == fabric;
        return _FabricChip(
          label: fabric,
          isSelected: isSelected,
          onTap: () => onSelected(fabric),
        );
      },
    );
  }
}

class _FabricChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FabricChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected ? ManagerColors.primaryColor : ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          border: Border.all(
            color: isSelected
                ? ManagerColors.primaryColor
                : ManagerColors.greyWhiteColor.withOpacity(0.25),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: isSelected ? ManagerColors.white : ManagerColors.black,
          ),
        ),
      ),
    );
  }
}
