import 'dart:io';
import 'dart:ui' as ui;

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';

import '../controller/add_edit_product_controller.dart';

/// Bottom sheet with two tabs for picking a custom color:
///   Tab 1 — HSV color wheel
///   Tab 2 — Capture image, tap a pixel to extract its color
class ColorPickerSheet extends StatefulWidget {
  final AddEditProductController ctrl;
  const ColorPickerSheet({super.key, required this.ctrl});

  @override
  State<ColorPickerSheet> createState() => _ColorPickerSheetState();
}

class _ColorPickerSheetState extends State<ColorPickerSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabCtrl;

  // ── Wheel tab ────────────────────────────────────────────────────────────
  Color _wheelColor = const Color(0xFF7986CB);
  final _nameCtrl = TextEditingController();

  // ── Camera tab ───────────────────────────────────────────────────────────
  File? _capturedImage;
  Color? _sampledColor;
  final _cameraNameCtrl = TextEditingController();
  final GlobalKey _imageKey = GlobalKey();
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
    _tabCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    _nameCtrl.dispose();
    _cameraNameCtrl.dispose();
    super.dispose();
  }

  // ── Helpers ──────────────────────────────────────────────────────────────

  Future<Color?> _extractPixel(Offset localOffset, Size widgetSize) async {
    if (_capturedImage == null) return null;
    try {
      final bytes = await _capturedImage!.readAsBytes();
      final ui.Codec codec = await ui.instantiateImageCodec(bytes);
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ui.Image img = fi.image;
      final double scaleX = img.width / widgetSize.width;
      final double scaleY = img.height / widgetSize.height;
      final int px =
          (localOffset.dx * scaleX).round().clamp(0, img.width - 1);
      final int py =
          (localOffset.dy * scaleY).round().clamp(0, img.height - 1);
      final byteData =
          await img.toByteData(format: ui.ImageByteFormat.rawRgba);
      if (byteData == null) return null;
      final int off = (py * img.width + px) * 4;
      return Color.fromARGB(255, byteData.getUint8(off),
          byteData.getUint8(off + 1), byteData.getUint8(off + 2));
    } catch (_) {
      return null;
    }
  }

  void _onImageTap(TapDownDetails details) async {
    final box =
        _imageKey.currentContext?.findRenderObject() as RenderBox?;
    if (box == null) return;
    final color = await _extractPixel(details.localPosition, box.size);
    if (color != null && mounted) setState(() => _sampledColor = color);
  }

  Future<void> _captureImage(ImageSource source) async {
    final XFile? file =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (file != null && mounted) {
      setState(() {
        _capturedImage = File(file.path);
        _sampledColor = null;
      });
    }
  }

  void _submitWheel() {
    final name = _nameCtrl.text.trim();
    if (name.isEmpty) {
      _showNameError();
      return;
    }
    widget.ctrl.addCustomColor(name, _wheelColor);
    Navigator.of(context).pop();
  }

  void _submitCamera() {
    final name = _cameraNameCtrl.text.trim();
    if (name.isEmpty) {
      _showNameError();
      return;
    }
    if (_sampledColor == null) return;
    widget.ctrl.addCustomColor(name, _sampledColor!);
    Navigator.of(context).pop();
  }

  void _showNameError() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        ManagerStrings.addProductColorNameRequired,
        style: getRegularTextStyle(
            fontSize: ManagerFontSize.s13, color: Colors.white),
      ),
      backgroundColor: Colors.red.shade700,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: Directionality.of(context),
      child: DraggableScrollableSheet(
        initialChildSize: 0.88,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        builder: (_, scrollCtrl) => SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ManagerRadius.r20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildHeader(context),
                Divider(height: 1, color: Colors.grey.shade100),
                _buildTabBar(),
                Divider(height: 1, color: Colors.grey.shade100),
                Expanded(
                  child: TabBarView(
                    controller: _tabCtrl,
                    children: [
                      _WheelTab(
                        scrollCtrl: scrollCtrl,
                        color: _wheelColor,
                        nameCtrl: _nameCtrl,
                        onColorChanged: (c) =>
                            setState(() => _wheelColor = c),
                        onSubmit: _submitWheel,
                      ),
                      _CameraTab(
                        scrollCtrl: scrollCtrl,
                        imageKey: _imageKey,
                        capturedImage: _capturedImage,
                        sampledColor: _sampledColor,
                        nameCtrl: _cameraNameCtrl,
                        onCapture: () => _captureImage(ImageSource.camera),
                        onGallery: () => _captureImage(ImageSource.gallery),
                        onImageTap: _onImageTap,
                        onSubmit: _submitCamera,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    // Active color preview (wheel or sampled)
    final previewColor = _tabCtrl.index == 0
        ? _wheelColor
        : (_sampledColor ?? Colors.transparent);
    final showPreview =
        _tabCtrl.index == 0 || _sampledColor != null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: ManagerHeight.h10, bottom: ManagerHeight.h8),
            width: ManagerWidth.w40,
            height: ManagerHeight.h4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
          ),
        ),
        // Title row: [spacer] [title] [close]
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8, vertical: ManagerHeight.h4),
          child: Row(
            children: [
              // Left side matches IconButton width for visual centering
              AnimatedOpacity(
                opacity: showPreview ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: ManagerWidth.w36,
                  height: ManagerHeight.h36,
                  margin:
                      EdgeInsets.symmetric(horizontal: ManagerWidth.w8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: showPreview ? previewColor : Colors.transparent,
                    border: Border.all(
                        color: Colors.grey.shade200, width: 1.5),
                    boxShadow: showPreview
                        ? [
                            BoxShadow(
                              color: previewColor.withOpacity(0.35),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : null,
                  ),
                ),
              ),
              // Title
              Expanded(
                child: Text(
                  ManagerStrings.addProductColorPickerTitle,
                  textAlign: TextAlign.center,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.black,
                  ),
                ),
              ),
              // Close button
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close_rounded),
                color: ManagerColors.greyWhiteColor,
                iconSize: ManagerFontSize.s20,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(
                    minWidth: ManagerWidth.w36,
                    minHeight: ManagerHeight.h36),
              ),
            ],
          ),
        ),
        SizedBox(height: ManagerHeight.h4),
      ],
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabCtrl,
      labelColor: ManagerColors.primaryColor,
      unselectedLabelColor: ManagerColors.greyWhiteColor,
      indicatorColor: ManagerColors.primaryColor,
      indicatorWeight: 2.5,
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: Colors.transparent,
      labelStyle: getBoldTextStyle(
          fontSize: ManagerFontSize.s13,
          color: ManagerColors.primaryColor),
      unselectedLabelStyle: getRegularTextStyle(
          fontSize: ManagerFontSize.s13,
          color: ManagerColors.greyWhiteColor),
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.palette_outlined, size: ManagerFontSize.s16),
              SizedBox(width: ManagerWidth.w8),
              Text(ManagerStrings.addProductColorWheelTab),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.camera_alt_outlined, size: ManagerFontSize.s16),
              SizedBox(width: ManagerWidth.w8),
              Text(ManagerStrings.addProductColorCameraTab),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Tab 1: HSV Color Wheel ───────────────────────────────────────────────

class _WheelTab extends StatelessWidget {
  final ScrollController scrollCtrl;
  final Color color;
  final TextEditingController nameCtrl;
  final ValueChanged<Color> onColorChanged;
  final VoidCallback onSubmit;

  const _WheelTab({
    required this.scrollCtrl,
    required this.color,
    required this.nameCtrl,
    required this.onColorChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollCtrl,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w20,
        ManagerHeight.h12,
        ManagerWidth.w20,
        ManagerHeight.h20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Live color preview strip
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: ManagerHeight.h44,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
              border: Border.all(color: Colors.grey.shade100),
            ),
          ),
          SizedBox(height: ManagerHeight.h16),
          // HSV picker
          ColorPicker(
            pickerColor: color,
            onColorChanged: onColorChanged,
            pickerAreaHeightPercent: 0.65,
            enableAlpha: false,
            displayThumbColor: true,
            hexInputBar: true,
            labelTypes: const [],
          ),
          SizedBox(height: ManagerHeight.h14),
          _ColorNameField(nameCtrl: nameCtrl),
          SizedBox(height: ManagerHeight.h14),
          _AddButton(accentColor: color, onPressed: onSubmit),
        ],
      ),
    );
  }
}

// ─── Tab 2: Camera / Pixel picker ────────────────────────────────────────

class _CameraTab extends StatelessWidget {
  final ScrollController scrollCtrl;
  final GlobalKey imageKey;
  final File? capturedImage;
  final Color? sampledColor;
  final TextEditingController nameCtrl;
  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final GestureTapDownCallback onImageTap;
  final VoidCallback onSubmit;

  const _CameraTab({
    required this.scrollCtrl,
    required this.imageKey,
    required this.capturedImage,
    required this.sampledColor,
    required this.nameCtrl,
    required this.onCapture,
    required this.onGallery,
    required this.onImageTap,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollCtrl,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w20,
        ManagerHeight.h16,
        ManagerWidth.w20,
        ManagerHeight.h20 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Camera / gallery buttons
          Row(
            children: [
              Expanded(
                child: _OutlineIconButton(
                  icon: Icons.camera_alt_outlined,
                  label: ManagerStrings.addProductTakePhoto,
                  onPressed: onCapture,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: _OutlineIconButton(
                  icon: Icons.photo_library_outlined,
                  label: ManagerStrings.addProductPickFromGallery,
                  onPressed: onGallery,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h14),

          // Image or placeholder
          if (capturedImage == null)
            Container(
              height: ManagerHeight.h180,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.04),
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                border: Border.all(
                    color: ManagerColors.primaryColor.withOpacity(0.2)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_search_outlined,
                    size: ManagerFontSize.s40,
                    color: ManagerColors.primaryColor.withOpacity(0.35),
                  ),
                  SizedBox(height: ManagerHeight.h8),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w20),
                    child: Text(
                      ManagerStrings.addProductTapToPickColor,
                      textAlign: TextAlign.center,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
              child: GestureDetector(
                onTapDown: onImageTap,
                child: Image.file(
                  key: imageKey,
                  capturedImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            Text(
              ManagerStrings.addProductTapToPickColor,
              textAlign: TextAlign.center,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],

          // Sampled color result + form
          if (sampledColor != null) ...[
            SizedBox(height: ManagerHeight.h14),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h12,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Container(
                    width: ManagerWidth.w36,
                    height: ManagerHeight.h36,
                    decoration: BoxDecoration(
                      color: sampledColor,
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: sampledColor!.withOpacity(0.35),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  Text(
                    ManagerStrings.selectedColor,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h14),
            _ColorNameField(nameCtrl: nameCtrl),
            SizedBox(height: ManagerHeight.h14),
            _AddButton(accentColor: sampledColor!, onPressed: onSubmit),
          ],
        ],
      ),
    );
  }
}

// ─── Shared widgets ───────────────────────────────────────────────────────

class _ColorNameField extends StatelessWidget {
  final TextEditingController nameCtrl;
  const _ColorNameField({required this.nameCtrl});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: nameCtrl,
      textDirection: Directionality.of(context),
      style: getRegularTextStyle(
          fontSize: ManagerFontSize.s13, color: ManagerColors.black),
      decoration: InputDecoration(
        hintText: ManagerStrings.addProductColorNameHint,
        hintStyle: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.greyWhiteColor,
        ),
        filled: true,
        fillColor: const Color(0xFFF8F9FA),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          borderSide:
              BorderSide(color: ManagerColors.primaryColor, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14,
          vertical: ManagerHeight.h12,
        ),
      ),
    );
  }
}

/// Button whose background matches the chosen color for instant visual feedback.
class _AddButton extends StatelessWidget {
  final Color accentColor;
  final VoidCallback onPressed;

  const _AddButton({required this.accentColor, required this.onPressed});

  bool get _isLight => accentColor.computeLuminance() > 0.4;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: ManagerHeight.h50,
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          child: Center(
            child: Text(
              ManagerStrings.addProductColorAdd,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s14,
                color: _isLight ? Colors.black87 : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineIconButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _OutlineIconButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: ManagerFontSize.s18),
      label: Text(
        label,
        style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.primaryColor),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: ManagerColors.primaryColor,
        side: BorderSide(
            color: ManagerColors.primaryColor.withOpacity(0.4)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
        ),
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
      ),
    );
  }
}
