import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/controller/address_controller.dart';
import 'package:app_mobile/features/providers/common_features/addresses/presentation/pages/map_picker_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Add / Edit Address Bottom Sheet Dialog
// ─────────────────────────────────────────────────────────────────────────────

/// Shows the Add/Edit Address bottom sheet and returns `true` when saved.
Future<bool?> showAddAddressDialog(
  BuildContext context, {
  String? initialName,
  double? initialLatitude,
  double? initialLongitude,
  String? initialDetail,
  bool isEdit = false,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    barrierColor: ManagerColors.black.withOpacity(0.25),
    builder: (_) => _AddAddressSheet(
      initialName: initialName,
      initialLatitude: initialLatitude,
      initialLongitude: initialLongitude,
      initialDetail: initialDetail,
      isEdit: isEdit,
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════════════
// Bottom Sheet Widget
// ══════════════════════════════════════════════════════════════════════════════

class _AddAddressSheet extends StatefulWidget {
  final String? initialName;
  final double? initialLatitude;
  final double? initialLongitude;
  final String? initialDetail;
  final bool isEdit;

  const _AddAddressSheet({
    this.initialName,
    this.initialLatitude,
    this.initialLongitude,
    this.initialDetail,
    this.isEdit = false,
  });

  @override
  State<_AddAddressSheet> createState() => _AddAddressSheetState();
}

class _AddAddressSheetState extends State<_AddAddressSheet>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _detailController = TextEditingController();

  double? _latitude;
  double? _longitude;

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
    if (widget.initialDetail != null) {
      _detailController.text = widget.initialDetail!;
    }
    if (widget.initialLatitude != null && widget.initialLongitude != null) {
      _latitude = widget.initialLatitude;
      _longitude = widget.initialLongitude;
      _locationController.text =
          '${_latitude!.toStringAsFixed(5)}, ${_longitude!.toStringAsFixed(5)}';
    }

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _nameController.dispose();
    _locationController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: SafeArea(
          bottom: true,
          child: Container(
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ManagerRadius.r24),
              ),
            ),
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w20,
              ManagerHeight.h20,
              ManagerWidth.w20,
              ManagerHeight.h16 + bottomInset,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Drag handle ────────────────────────────────────────────
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

                  // ── Header row: title + close ──────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.isEdit
                                  ? ManagerStrings.tailorAddressEditButton
                                  : ManagerStrings.tailorAddressDialogTitle,
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s15,
                                color: ManagerColors.black,
                              ),
                            ),
                            SizedBox(height: ManagerHeight.h2),
                            Text(
                              ManagerStrings.tailorAddressDialogSubtitle,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s11,
                                color: ManagerColors.greyWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: ManagerWidth.w32,
                          height: ManagerHeight.h32,
                          decoration: BoxDecoration(
                            color:
                                ManagerColors.greyWhiteColor.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r8),
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

                  SizedBox(height: ManagerHeight.h20),

                  // ── Address name ───────────────────────────────────────────
                  CustomTextField(
                    label: ManagerStrings.tailorAddressNameLabel,
                    hintText: ManagerStrings.tailorAddressNameHint,
                    controller: _nameController,
                  ),

                  SizedBox(height: ManagerHeight.h14),

                  // ── Location field + open map button ───────────────────────
                  CustomTextField(
                    label: ManagerStrings.tailorAddressLocationLabel,
                    hintText: ManagerStrings.tailorAddressLocationHint,
                    controller: _locationController,
                    readOnly: true,
                    onTap: _onOpenMap,
                    customSuffixIcon: GestureDetector(
                      onTap: _onOpenMap,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: ManagerWidth.w4,
                          top: ManagerHeight.h4,
                          bottom: ManagerHeight.h4,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: ManagerWidth.w10),
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(ManagerRadius.r8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: ManagerColors.primaryColor,
                              size: 16,
                            ),
                            SizedBox(width: ManagerWidth.w4),
                            Text(
                              ManagerStrings.tailorAddressOpenMapButton,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s12,
                                color: ManagerColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h14),

                  // ── Detailed location ──────────────────────────────────────
                  _DetailedLocationField(controller: _detailController),

                  SizedBox(height: ManagerHeight.h24),

                  // ── Submit button ──────────────────────────────────────────
                  Obx(() {
                    final controller = Get.find<AddressController>();
                    final isSubmitting = controller.isSubmitting.value;
                    return ButtonApp(
                      title: widget.isEdit
                          ? ManagerStrings.tailorAddressEditButton
                          : ManagerStrings.tailorAddressSubmitButton,
                      onPressed: isSubmitting ? () {} : _onSubmit,
                      paddingWidth: 0,
                    );
                  }),

                  SizedBox(height: ManagerHeight.h8),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onOpenMap() async {
    final result = await Navigator.push<MapPickerResult>(
      context,
      MaterialPageRoute(
        builder: (_) => MapPickerScreen(
          initialLatitude: _latitude,
          initialLongitude: _longitude,
        ),
      ),
    );
    if (result != null) {
      setState(() {
        _latitude = result.latitude;
        _longitude = result.longitude;
        _locationController.text = result.displayText;
      });
    }
  }

  Future<void> _onSubmit() async {
    FocusScope.of(context).unfocus();

    final name = _nameController.text.trim();
    final detail = _detailController.text.trim();

    if (name.isEmpty) {
      AppSnackbar.warning(ManagerStrings.tailorAddressNameHint);
      return;
    }
    if (_latitude == null || _longitude == null) {
      AppSnackbar.warning(ManagerStrings.tailorAddressLocationHint);
      return;
    }
    if (detail.isEmpty) {
      AppSnackbar.warning(ManagerStrings.tailorAddressDetailHint);
      return;
    }

    final controller = Get.find<AddressController>();
    final success = await controller.submitAddress(
      fullName: name,
      latitude: _latitude!,
      longitude: _longitude!,
      detailedDescription: detail,
    );
    if (!mounted || !success) return;
    Navigator.pop(context, true);
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Detailed Location Textarea
// ══════════════════════════════════════════════════════════════════════════════

class _DetailedLocationField extends StatelessWidget {
  final TextEditingController controller;

  const _DetailedLocationField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ManagerStrings.tailorAddressDetailLabel,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Container(
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            border: Border.all(
              color: ManagerColors.greyWhiteColor.withOpacity(0.3),
            ),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            minLines: 3,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
            decoration: InputDecoration(
              hintText: ManagerStrings.tailorAddressDetailHint,
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
        ),
      ],
    );
  }
}
