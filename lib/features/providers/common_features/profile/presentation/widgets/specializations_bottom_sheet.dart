import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/features/providers/common_features/profile/domain/model/provider_profile_model.dart';
import 'package:app_mobile/features/providers/common_features/profile/presentation/controller/portfolio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Specializations Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

Future<void> showSpecializationsBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _SpecializationsSheet(),
  );
}

// ══════════════════════════════════════════════════════════════════════════════

class _SpecializationsSheet extends StatefulWidget {
  const _SpecializationsSheet();

  @override
  State<_SpecializationsSheet> createState() => _SpecializationsSheetState();
}

class _SpecializationsSheetState extends State<_SpecializationsSheet> {
  final _textController = TextEditingController();

  List<_SpecializationSuggestion> get _suggestions => [
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionEveningAbayas,
          aliases: const ['عبايات سهرة', 'Evening Abayas', 'شام کی عبایات'],
        ),
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionKidsAbayas,
          aliases: const ['عبايات أطفال', 'Kids Abayas', 'بچوں کی عبایات'],
        ),
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionCasualAbayas,
          aliases: const ['عبايات كاجوال', 'Casual Abayas', 'روزمرہ عبایات'],
        ),
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionAlterations,
          aliases: const [
            'تعديلات وإصلاحات',
            'Alterations & Repairs',
            'ترمیم اور مرمت',
          ],
        ),
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionOccasionAbayas,
          aliases: const [
            'عبايات مناسبات',
            'Occasion Abayas',
            'تقریبات کی عبایات',
          ],
        ),
        _SpecializationSuggestion(
          label: ManagerStrings.specialSuggestionMaternityAbayas,
          aliases: const [
            'عبايات حوامل',
            'Maternity Abayas',
            'حاملہ خواتین کی عبایات',
          ],
        ),
      ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _addFromField(PortfolioController controller) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    controller.addSpecialization(text);
  }

  void _addSuggestion(
    PortfolioController controller,
    _SpecializationSuggestion suggestion,
  ) {
    final alreadyExists = controller.specializations.any(
      (s) => suggestion.matches(s.name),
    );
    if (alreadyExists) return;
    controller.addSpecialization(suggestion.label);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PortfolioController>();
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      bottom: true,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.90,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r24),
          ),
        ),
        padding: EdgeInsets.fromLTRB(
          ManagerWidth.w20,
          ManagerHeight.h16,
          ManagerWidth.w20,
          ManagerHeight.h16 + bottomInset,
        ),
        child: Obx(() {
          final specializations = controller.specializations;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Drag handle ────────────────────────────────────────────────
                Center(
                  child: Container(
                    width: ManagerWidth.w40,
                    height: ManagerHeight.h4,
                    decoration: BoxDecoration(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    ),
                  ),
                ),

                SizedBox(height: ManagerHeight.h16),

                // ── Header: title + close ──────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ManagerStrings.specialTitle,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s17,
                        color: ManagerColors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: ManagerWidth.w32,
                        height: ManagerHeight.h32,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(ManagerRadius.r8),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          size: ManagerFontSize.s18,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h14),

                // ── Info banner ────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w14,
                    vertical: ManagerHeight.h10,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    border: Border.all(
                      color: ManagerColors.primaryColor.withOpacity(0.18),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: ManagerFontSize.s16,
                        color: ManagerColors.primaryColor,
                      ),
                      SizedBox(width: ManagerWidth.w8),
                      Expanded(
                        child: Text(
                          ManagerStrings.specialInfoBanner,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.primaryColor,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ManagerHeight.h18),

                // ── Loading bar while adding ───────────────────────────────────
                if (controller.isAddingSpecialization.value)
                  Padding(
                    padding: EdgeInsets.only(bottom: ManagerHeight.h10),
                    child: LinearProgressIndicator(
                      color: ManagerColors.primaryColor,
                      backgroundColor:
                          ManagerColors.primaryColor.withOpacity(0.12),
                      minHeight: 2,
                    ),
                  ),

                // ── Add new section ────────────────────────────────────────────
                Text(
                  ManagerStrings.specialAddLabel,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.black,
                  ),
                ),

                SizedBox(height: ManagerHeight.h8),

                Row(
                  children: [
                    // + Button
                    GestureDetector(
                      onTap: controller.isAddingSpecialization.value
                          ? null
                          : () => _addFromField(controller),
                      child: Container(
                        width: ManagerWidth.w46,
                        height: ManagerHeight.h46,
                        decoration: BoxDecoration(
                          color: controller.isAddingSpecialization.value
                              ? ManagerColors.primaryColor.withOpacity(0.5)
                              : ManagerColors.primaryColor,
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                        ),
                        child: Icon(
                          Icons.add_rounded,
                          color: ManagerColors.white,
                          size: ManagerFontSize.s22,
                        ),
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w10),

                    // Text field
                    Expanded(
                      child: Container(
                        height: ManagerHeight.h46,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                          border: Border.all(
                            color:
                                ManagerColors.greyWhiteColor.withOpacity(0.2),
                          ),
                        ),
                        child: TextField(
                          controller: _textController,
                          textAlign: TextAlign.start,
                          onSubmitted: (_) => _addFromField(controller),
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: ManagerStrings.specialAddHint,
                            hintStyle: getRegularTextStyle(
                              fontSize: ManagerFontSize.s13,
                              color: ManagerColors.greyWhiteColor,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w14,
                              vertical: ManagerHeight.h12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h18),

                // ── Current specializations ────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ManagerStrings.specialCurrentLabel,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w10,
                        vertical: ManagerHeight.h3,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(ManagerRadius.r20),
                      ),
                      child: Text(
                        '${specializations.length} ${ManagerStrings.specialNoun}',
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h8),

                // List — natural height inside scroll view
                if (specializations.isNotEmpty)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: specializations.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      thickness: 0.7,
                      color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                    ),
                    itemBuilder: (_, i) {
                      final spec = specializations[i];
                      final bool isDeleting = controller
                              .isDeletingSpecialization.value &&
                          controller.deletingSpecializationId.value == spec.id;
                      return _SpecializationTile(
                        spec: spec,
                        isDeleting: isDeleting,
                        onDelete: () =>
                            controller.deleteSpecialization(spec.id),
                      );
                    },
                  ),

                SizedBox(height: ManagerHeight.h16),

                // ── Suggestions ────────────────────────────────────────────────
                Text(
                  ManagerStrings.specialSuggestionsLabel,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),

                SizedBox(height: ManagerHeight.h8),

                Wrap(
                  spacing: ManagerWidth.w8,
                  runSpacing: ManagerHeight.h8,
                  children: _suggestions
                      .where(
                        (s) => !specializations.any((e) => s.matches(e.name)),
                      )
                      .map(
                        (s) => GestureDetector(
                          onTap: controller.isAddingSpecialization.value
                              ? null
                              : () => _addSuggestion(controller, s),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w12,
                              vertical: ManagerHeight.h6,
                            ),
                            decoration: BoxDecoration(
                              color: ManagerColors.white,
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r20),
                              border: Border.all(
                                color: ManagerColors.greyWhiteColor
                                    .withOpacity(0.25),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  size: ManagerFontSize.s14,
                                  color: ManagerColors.primaryColor,
                                ),
                                SizedBox(width: ManagerWidth.w4),
                                Text(
                                  s.label,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s12,
                                    color: ManagerColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(height: ManagerHeight.h20),

                // ── Close button ───────────────────────────────────────────────
                ButtonApp(
                  onPressed: () => Navigator.pop(context),
                  title: ManagerStrings.specialSaveButton,
                  paddingWidth: 0,
                ),
              ],
            ), // Column
          ); // SingleChildScrollView
        }), // Obx
      ),
    );
  }
}

// ── Single specialization row ──────────────────────────────────────────────

class _SpecializationSuggestion {
  final String label;
  final List<String> aliases;

  const _SpecializationSuggestion({
    required this.label,
    required this.aliases,
  });

  bool matches(String value) {
    final normalizedValue = _normalize(value);
    if (normalizedValue == _normalize(label)) return true;
    return aliases.any((alias) => normalizedValue == _normalize(alias));
  }

  static String _normalize(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }
}

class _SpecializationTile extends StatelessWidget {
  final SpecializationModel spec;
  final bool isDeleting;
  final VoidCallback onDelete;

  const _SpecializationTile({
    required this.spec,
    required this.isDeleting,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ManagerHeight.h10),
      child: Row(
        children: [
          // Delete / Loading
          if (isDeleting)
            SizedBox(
              width: ManagerWidth.w18,
              height: ManagerHeight.h18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: ManagerColors.greyWhiteColor,
              ),
            )
          else
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.delete_outline_rounded,
                size: ManagerFontSize.s18,
                color: ManagerColors.greyWhiteColor.withOpacity(0.6),
              ),
            ),
          SizedBox(width: ManagerWidth.w12),
          // Label
          Expanded(
            child: Text(
              spec.name,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.black,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          // Star
          Icon(
            Icons.star_rounded,
            size: ManagerFontSize.s16,
            color: ManagerColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Specializations Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────
