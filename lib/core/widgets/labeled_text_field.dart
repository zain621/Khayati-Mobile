import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

class LabeledTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
    final double paddingWidth;

  final bool enabled;
  final TextInputType keyboardType;

  final Widget? buttonWidget;
  final VoidCallback? onButtonTap;
  final double widthButton;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Widget? suffixWidget;

   LabeledTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.paddingWidth = 16,
    this.enabled = true,
    this.keyboardType = TextInputType.text,
    this.buttonWidget,
    this.onButtonTap,
    this.widthButton = 0,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.validator,
    this.suffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingWidth==16 ? ManagerWidth.w16 : paddingWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h8),
              child: Text(
                label!,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.black,
                ),
              ),
            ),
          ],
          TextFormField(
            controller: controller,
            focusNode: focusNode,
            textInputAction: textInputAction,
            validator: validator,
            onFieldSubmitted: onFieldSubmitted ??
                (_) {
                  if (nextFocusNode != null) {
                    FocusScope.of(context).requestFocus(nextFocusNode);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
            minLines: minLines,
            maxLines: maxLines,
            enabled: enabled,
            keyboardType: keyboardType,
            textAlign: TextAlign.right,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w8,
                vertical: ManagerHeight.h12,
              ),
              filled: true,
              fillColor: ManagerColors.white,
              suffix: suffixWidget,
              suffixIcon: (onButtonTap != null)
                  ? ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                        width: widthButton,
                        height: ManagerHeight.h48,
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: ManagerWidth.w4,
                            top: ManagerHeight.h4,
                            bottom: ManagerHeight.h4),
                        child: ElevatedButton(
                            onPressed: onButtonTap,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ManagerColors.primaryColor,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(ManagerRadius.r4),
                                  bottomLeft: Radius.circular(ManagerRadius.r4),
                                ),
                              ),
                              elevation: 0,
                            ),
                            child: buttonWidget),
                      ),
                    )
                  : null,
              suffixIconConstraints: BoxConstraints(
                minWidth: 0,
                minHeight: 0,
                maxHeight: ManagerHeight.h48,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: BorderSide(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: BorderSide(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                borderSide: const BorderSide(
                  color: ManagerColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
