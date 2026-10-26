import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/auth/presentation/controller/provider_register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Step 4 — Vendor / Tailor Agreement with electronic signature.
class ProviderStepAgreement extends StatelessWidget {
  final ProviderRegisterController controller;

  const ProviderStepAgreement({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vendor / Tailor Agreement\nاتفاقية مورد / خياط المنصة',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s16,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Text(
          'Review the full agreement below, fill Party B details, and sign. Platform: Khayati.ae',
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h12),
        Container(
          constraints: BoxConstraints(maxHeight: ManagerHeight.h220),
          padding: EdgeInsets.all(ManagerWidth.w12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            border: Border.all(
              color: ManagerColors.primaryColor.withOpacity(0.35),
            ),
          ),
          child: SingleChildScrollView(
            child: Text(
              controller.agreementDocumentText,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: ManagerHeight.h16),
        Text(
          'Execution',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(ManagerWidth.w12),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.06),
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            border: Border.all(
              color: ManagerColors.primaryColor.withOpacity(0.35),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIGNED FOR AND ON BEHALF OF PARTY A',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.primaryColor,
                ),
              ),
              SizedBox(height: ManagerHeight.h6),
              Text(
                'HAMAD ALADAWI SERVICES BROKERAGE',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.black,
                ),
              ),
              Text(
                'Khayati | خيّاطي — Platform: Khayati.ae',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.primaryColor,
                ),
              ),
              Text(
                'Licence No.: CN-6580875',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ManagerHeight.h12),
        Text(
          'SIGNED FOR AND ON BEHALF OF PARTY B',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s11,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'Full name',
          controller: controller.agreementFullNameController,
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'Title',
          controller: controller.agreementTitleController,
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'Trade name',
          controller: controller.agreementTradeNameController,
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'Licence No.',
          controller: controller.agreementLicenceController,
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'EID / Passport',
          controller: controller.agreementEidController,
        ),
        SizedBox(height: ManagerHeight.h10),
        _field(
          label: 'Phone (digits only, optional +)',
          controller: controller.agreementPhoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
            LengthLimitingTextInputFormatter(16),
          ],
        ),
        SizedBox(height: ManagerHeight.h16),
        Text(
          'Signature',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Obx(
          () => Container(
            height: ManagerHeight.h140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
              border: Border.all(
                color: controller.agreementHasSignature.value
                    ? ManagerColors.primaryColor
                    : ManagerColors.greyWhiteColor.withOpacity(0.45),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(ManagerRadius.r12),
              child: SignaturePad(
                key: ValueKey(controller.agreementHasSignature.value),
                onSigned: controller.setAgreementSignatureBytes,
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: TextButton(
            onPressed: () {
              controller.clearAgreementSignature();
            },
            child: Text(
              'Clear signature',
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ),
        Obx(
          () => CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: controller.agreementAccepted.value,
            onChanged: (v) => controller.agreementAccepted.value = v ?? false,
            controlAffinity: ListTileControlAffinity.leading,
            title: Text(
              'I have read all pages of this Vendor / Tailor Agreement and agree to be bound. My account will not be verified until this agreement is completed and signed.',
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h10,
            ),
          ),
        ),
      ],
    );
  }
}

class SignaturePad extends StatefulWidget {
  final ValueChanged<Uint8List?> onSigned;

  const SignaturePad({super.key, required this.onSigned});

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  final List<Offset?> _points = [];

  Future<void> _export() async {
    if (_points.whereType<Offset>().isEmpty) {
      widget.onSigned(null);
      return;
    }
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < _points.length - 1; i++) {
      final p1 = _points[i];
      final p2 = _points[i + 1];
      if (p1 != null && p2 != null) {
        canvas.drawLine(p1, p2, paint);
      }
    }
    final picture = recorder.endRecording();
    final image = await picture.toImage(600, 220);
    final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    widget.onSigned(bytes?.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (d) => setState(() => _points.add(d.localPosition)),
      onPanUpdate: (d) => setState(() => _points.add(d.localPosition)),
      onPanEnd: (_) {
        _points.add(null);
        _export();
      },
      child: CustomPaint(
        painter: _SignaturePainter(_points),
        size: Size.infinite,
      ),
    );
  }
}

class _SignaturePainter extends CustomPainter {
  final List<Offset?> points;
  _SignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    for (var i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      if (p1 != null && p2 != null) {
        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _SignaturePainter oldDelegate) => true;
}
