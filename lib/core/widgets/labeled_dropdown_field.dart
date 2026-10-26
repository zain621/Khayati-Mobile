import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

/// A styled labeled dropdown that visually matches [LabeledTextField].
///
/// Set [paddingWidth] = 0 when used inside an already-padded card.
class LabeledDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  /// Horizontal padding on both sides. Pass 0 to remove padding.
  final double paddingWidth;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.paddingWidth = 16,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = paddingWidth == 0
        ? EdgeInsets.zero
        : EdgeInsets.symmetric(horizontal: 0);

    return Padding(
      padding: effectivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: onChanged,
            hint: Text(
              hint,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Colors.black54,
            ),
            isExpanded: true,
            dropdownColor: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r8),
            elevation: 3,
            menuMaxHeight: ManagerHeight.h250,
            decoration: InputDecoration(
              isDense: false,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h12,
              ),
              filled: true,
              fillColor: ManagerColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: BorderSide(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.35),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: BorderSide(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.35),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: BorderSide(
                  color: ManagerColors.primaryColor,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
