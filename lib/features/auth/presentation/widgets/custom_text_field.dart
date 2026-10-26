import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show FilteringTextInputFormatter, LengthLimitingTextInputFormatter;
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/util/phone_validator.dart';

/// Reusable text field for auth screens.
/// Supports password visibility toggle and optional country code dropdown for phone fields.
class CustomTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool isPhone;
  final bool readOnly;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? customSuffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onCountryCodeChanged;
  /// Called when the phone field text changes (after optional country auto-detect).
  final ValueChanged<String>? onPhoneChanged;
  final String initialCountryCode;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.isPhone = false,
    this.readOnly = false,
    this.controller,
    this.keyboardType,
    this.validator,
    this.prefixIcon,
    this.customSuffixIcon,
    this.onTap,
    this.onCountryCodeChanged,
    this.onPhoneChanged,
    this.initialCountryCode = '+971',
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  late String _selectedCountryCode;

  static const List<_CountryCode> _countryCodes = [
    _CountryCode(code: '+971', flag: '🇦🇪'),
    _CountryCode(code: '+966', flag: '🇸🇦'),
    _CountryCode(code: '+92', flag: '🇵🇰'),
    _CountryCode(code: '+970', flag: '🇵🇸'),
    _CountryCode(code: '+972', flag: '🇮🇱'),
    _CountryCode(code: '+965', flag: '🇰🇼'),
    _CountryCode(code: '+974', flag: '🇶🇦'),
    _CountryCode(code: '+973', flag: '🇧🇭'),
    _CountryCode(code: '+968', flag: '🇴🇲'),
    _CountryCode(code: '+962', flag: '🇯🇴'),
    _CountryCode(code: '+20', flag: '🇪🇬'),
  ];

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
    _selectedCountryCode = widget.initialCountryCode;
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCountryCode != widget.initialCountryCode) {
      _selectedCountryCode = widget.initialCountryCode;
    }
  }

  /// When the user types a leading country code (e.g. 971… or 92…),
  /// auto-select that country and keep only the national digits in the field.
  void _onPhoneChanged(String value) {
    final detected = PhoneValidator.detectCountryFromDigits(value);
    if (detected != null && detected.dialCode != _selectedCountryCode) {
      setState(() => _selectedCountryCode = detected.dialCode);
      widget.onCountryCodeChanged?.call(detected.dialCode);
      final national = detected.national;
      final ctrl = widget.controller;
      if (ctrl != null && ctrl.text != national) {
        ctrl.value = TextEditingValue(
          text: national,
          selection: TextSelection.collapsed(offset: national.length),
        );
      }
      widget.onPhoneChanged?.call(national);
      return;
    }
    widget.onPhoneChanged?.call(value);
  }

  Widget? _buildPrefixIcon() {
    if (widget.isPhone) {
      return _buildCountryCodeDropdown();
    }
    return widget.prefixIcon;
  }

  Widget _buildCountryCodeDropdown() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: ManagerWidth.w12),

        /// Flag + Arrow dropdown
        DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedCountryCode,
            isDense: true,
            icon: Padding(
              padding: EdgeInsets.only(left: ManagerWidth.w6),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ManagerColors.greyWhiteColor,
                size: ManagerHeight.h20,
              ),
            ),
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
            items: _countryCodes.map((country) {
              return DropdownMenuItem<String>(
                value: country.code,
                child: Text(
                  '${country.flag}  ${country.code}',
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedCountryCode = value);
                widget.onCountryCodeChanged?.call(value);
              }
            },
            selectedItemBuilder: (context) {
              return _countryCodes.map((country) {
                return Center(
                  child: Text(
                    country.flag,
                    style: const TextStyle(fontSize: 22),
                  ),
                );
              }).toList();
            },
          ),
        ),

        SizedBox(width: ManagerWidth.w8),

        /// Vertical divider
        Container(
          height: ManagerHeight.h24,
          width: 1,
          color: ManagerColors.greyWhiteColor.withOpacity(0.3),
        ),

        SizedBox(width: ManagerWidth.w8),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.customSuffixIcon != null) return widget.customSuffixIcon;
    if (!widget.isPassword) return null;
    return IconButton(
      icon: Icon(
        _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
        color: ManagerColors.greyWhiteColor,
      ),
      onPressed: () => setState(() => _obscureText = !_obscureText),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Directionality(
          textDirection:
              widget.isPhone ? TextDirection.ltr : Directionality.of(context),
          child: TextFormField(
            controller: widget.controller,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            obscureText: widget.isPassword && _obscureText,
            keyboardType:
                widget.isPhone ? TextInputType.phone : widget.keyboardType,
            onChanged: widget.isPhone ? _onPhoneChanged : widget.onPhoneChanged,
            inputFormatters: widget.isPhone
                ? [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(
                      PhoneValidator.maxInputLength(_selectedCountryCode),
                    ),
                  ]
                : null,
            validator: widget.validator,
            textDirection:
                widget.isPhone ? TextDirection.ltr : Directionality.of(context),
            textAlign: widget.isPhone ? TextAlign.left : TextAlign.start,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.greyWhiteColor,
              ),
              prefixIcon: _buildPrefixIcon(),
              prefixIconConstraints: widget.isPhone
                  ? BoxConstraints(minWidth: ManagerWidth.w100)
                  : null,
              suffixIcon: _buildSuffixIcon(),
              filled: true,
              fillColor: ManagerColors.white,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h14,
              ),
              border:
                  _buildBorder(ManagerColors.greyWhiteColor.withOpacity(0.3)),
              enabledBorder:
                  _buildBorder(ManagerColors.greyWhiteColor.withOpacity(0.3)),
              focusedBorder:
                  _buildBorder(ManagerColors.primaryColor, width: 1.2),
              errorBorder: _buildBorder(ManagerColors.redNew),
              focusedErrorBorder:
                  _buildBorder(ManagerColors.redNew, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder(Color color, {double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(ManagerRadius.r10),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}

class _CountryCode {
  final String code;
  final String flag;

  const _CountryCode({required this.code, required this.flag});
}
