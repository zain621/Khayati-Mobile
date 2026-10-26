import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/auth/domain/model/category_model.dart';
import 'package:flutter/material.dart';

/// Step 3: Experience, bio, and specialization tags (dynamic from API).
class ProviderStepExperience extends StatelessWidget {
  final String? selectedYears;
  final ValueChanged<String?> onYearsChanged;
  final TextEditingController bioController;
  final List<CategoryModel> categories;
  final Set<String> selectedCategoryIds;
  final ValueChanged<String> onCategoryToggle;
  final bool isCategoriesLoading;

  const ProviderStepExperience({
    super.key,
    required this.selectedYears,
    required this.onYearsChanged,
    required this.bioController,
    required this.categories,
    required this.selectedCategoryIds,
    required this.onCategoryToggle,
    this.isCategoriesLoading = false,
  });

  static const List<String> _years = [
    'أقل من سنة',
    '1 - 3 سنوات',
    '3 - 5 سنوات',
    '5 - 10 سنوات',
    'أكثر من 10 سنوات',
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
                  text: ManagerStrings.providerExperienceTitle,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                const TextSpan(text: ' '),
                TextSpan(
                  text: ManagerStrings.providerExperienceSubTitle,
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

        /// Years of Experience Dropdown
        _buildLabel(ManagerStrings.providerYearsLabel),
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
              value: selectedYears,
              hint: Text(
                ManagerStrings.providerYearsHint,
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
              items: _years.map((year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(
                    year,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                );
              }).toList(),
              onChanged: onYearsChanged,
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h16),

        /// Bio
        _buildLabel(ManagerStrings.providerBioLabel),
        SizedBox(height: ManagerHeight.h8),
        TextFormField(
          controller: bioController,
          maxLines: 4,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
          decoration: InputDecoration(
            hintText: ManagerStrings.providerBioHint,
            hintStyle: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
            filled: true,
            fillColor: ManagerColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
              borderSide: BorderSide(
                color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
              borderSide: BorderSide(
                color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
              borderSide: const BorderSide(
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h16),

        /// Specializations
        _buildLabel(ManagerStrings.providerSpecializationsLabel),
        SizedBox(height: ManagerHeight.h10),
        if (isCategoriesLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h16),
              child: const CircularProgressIndicator(
                color: ManagerColors.primaryColor,
              ),
            ),
          )
        else
          Wrap(
            spacing: ManagerWidth.w8,
            runSpacing: ManagerHeight.h8,
            children: categories.map((category) {
              final isSelected = selectedCategoryIds.contains(category.id);
              return GestureDetector(
                onTap: () => onCategoryToggle(category.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12,
                    vertical: ManagerHeight.h8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ManagerColors.primaryColor
                        : ManagerColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(ManagerRadius.r20),
                    border: Border.all(
                      color: isSelected
                          ? ManagerColors.primaryColor
                          : ManagerColors.primaryColor.withOpacity(0),
                    ),
                  ),
                  child: Text(
                    category.name,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: isSelected
                          ? ManagerColors.white
                          : ManagerColors.primaryColor,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

        SizedBox(height: ManagerHeight.h24),

        /// Next Step Info Box
        Container(
          width: double.infinity,
          // padding: EdgeInsets.all(ManagerWidth.w12),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.04),
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            // border: Border.all(
            //   color: ManagerColors.primaryColor.withOpacity(0.15),
            // ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image.asset(ManagerImages.card2BackgroundChooseAccountType,
                height: ManagerHeight.h98,
                width: ManagerWidth.w173,
                fit: BoxFit.cover,
                ),
              ),
              Padding(
                
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12, vertical: ManagerHeight.h12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: ManagerColors.primaryColor,
                      size: 18,
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ManagerStrings.providerNextStepTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h4),
                          Text(
                            ManagerStrings.providerNextStepDescription,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
