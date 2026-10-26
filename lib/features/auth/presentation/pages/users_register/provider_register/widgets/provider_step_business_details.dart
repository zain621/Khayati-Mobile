import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

/// Step 2: Business details — name, owner, phone, city, location, address.
class ProviderStepBusinessDetails extends StatelessWidget {
  final TextEditingController businessNameController;
  final TextEditingController ownerNameController;
  final TextEditingController phoneController;
  final TextEditingController? emailController;
  final bool showEmail;
  final TextEditingController addressController;
  final TextEditingController locationController;
  final String? selectedCity;
  final ValueChanged<String?> onCityChanged;
  final VoidCallback onOpenMap;
  final ValueChanged<String>? onPhoneCountryCodeChanged;
  final String initialPhoneCountryCode;

  const ProviderStepBusinessDetails({
    super.key,
    required this.businessNameController,
    required this.ownerNameController,
    required this.phoneController,
    this.emailController,
    this.showEmail = false,
    required this.addressController,
    required this.locationController,
    required this.selectedCity,
    required this.onCityChanged,
    required this.onOpenMap,
    this.onPhoneCountryCodeChanged,
    this.initialPhoneCountryCode = '+92',
  });

  static const List<String> _cities = [
    'أبو ظبي',
    'دبي',
    'الشارقة',
    'عجمان',
    'أم القيوين',
    'رأس الخيمة',
    'الفجيرة',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Section header
        Center(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: ManagerStrings.providerBusinessDetailsTitle,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                const TextSpan(text: '  '),
                TextSpan(
                  text: ManagerStrings.providerBusinessDetailsSubTitle,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h20),

        /// Business Name
        CustomTextField(
          label: ManagerStrings.providerBusinessNameLabel,
          hintText: ManagerStrings.providerBusinessNameHint,
          controller: businessNameController,
        ),

        SizedBox(height: ManagerHeight.h16),

        /// Owner Name
        CustomTextField(
          label: ManagerStrings.providerOwnerNameLabel,
          hintText: ManagerStrings.providerOwnerNameHint,
          controller: ownerNameController,
        ),

        SizedBox(height: ManagerHeight.h16),

        /// Phone
        CustomTextField(
          label: ManagerStrings.providerPhoneLabel,
          hintText: ManagerStrings.providerPhoneHint,
          controller: phoneController,
          isPhone: true,
          initialCountryCode: initialPhoneCountryCode,
          onCountryCodeChanged: onPhoneCountryCodeChanged,
        ),

        if (showEmail && emailController != null) ...[
          SizedBox(height: ManagerHeight.h16),
          CustomTextField(
            label: 'Email address',
            hintText: 'name@example.com',
            controller: emailController!,
            keyboardType: TextInputType.emailAddress,
          ),
        ],

        SizedBox(height: ManagerHeight.h16),

        /// City Dropdown
        _buildLabel(ManagerStrings.providerCityLabel),
        SizedBox(height: ManagerHeight.h8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            border: Border.all(
              color: ManagerColors.greyWhiteColor.withOpacity(0.3),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedCity,
              hint: Text(
                ManagerStrings.providerCityHint,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: ManagerColors.greyWhiteColor,
              ),
              items: _cities.map((city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(
                    city,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onCityChanged,
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h16),

        /// Location — read-only field with map button
        CustomTextField(
          label: ManagerStrings.providerLocationLabel,
          hintText: ManagerStrings.providerLocationHint,
          controller: locationController,
          readOnly: true,
          onTap: onOpenMap,
          customSuffixIcon: GestureDetector(
            onTap: onOpenMap,
            child: Container(
              margin: EdgeInsets.only(left: ManagerWidth.w4,top: ManagerHeight.h4, bottom: ManagerHeight.h4),
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w10),
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
                    ManagerStrings.providerOpenMapButton,
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

        SizedBox(height: ManagerHeight.h16),

        /// Address
        CustomTextField(
          label: ManagerStrings.providerAddressLabel,
          hintText: ManagerStrings.providerAddressHint,
          controller: addressController,
        ),

        SizedBox(height: ManagerHeight.h16),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: getMediumTextStyle(
        fontSize: ManagerFontSize.s12,
        color: ManagerColors.black,
      ),
    );
  }
}
