import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/features/auth/presentation/pages/users_register/provider_register/widgets/provider_role_card.dart';
import 'package:flutter/material.dart';

/// Step 1: Choose tailor role type — icon-only cards.
class ProviderStepRole extends StatelessWidget {
  final int selectedRole;
  final ValueChanged<int> onRoleSelected;

  const ProviderStepRole({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          strutStyle: const StrutStyle(
            height: 1.5,
            forceStrutHeight: true,
          ),
          text: TextSpan(
            children: [
              TextSpan(
                text: ManagerStrings.providerRegisterSubTitle.replaceAll(
                  ManagerStrings.providerRegisterKeyword,
                  '',
                ),
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
              TextSpan(
                text: ManagerStrings.providerRegisterKeyword,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: ManagerHeight.h24),

        /// Custom Tailor
        ProviderRoleCard(
          svgIconPath: ManagerIcons.independentTailorIcon,
          title: ManagerStrings.providerRoleIndependentTitle,
          subtitle: ManagerStrings.providerRoleIndependentSubTitle,
          tags: [
            ManagerStrings.providerRoleIndependentTag1,
            ManagerStrings.providerRoleIndependentTag2,
          ],
          isSelected: selectedRole == 0,
          onTap: () => onRoleSelected(0),
        ),

        SizedBox(height: ManagerHeight.h12),

        /// Clothing Store
        ProviderRoleCard(
          svgIconPath: ManagerIcons.storeIcon,
          title: ManagerStrings.providerRoleShopTitle,
          subtitle: ManagerStrings.providerRoleShopSubTitle,
          tags: [
            ManagerStrings.providerRoleShopTag1,
            ManagerStrings.providerRoleShopTag2,
          ],
          isSelected: selectedRole == 1,
          onTap: () => onRoleSelected(1),
        ),

        SizedBox(height: ManagerHeight.h12),

        /// Tailor & Store
        ProviderRoleCard(
          svgIconPath: ManagerIcons.fullTailorIcon,
          title: ManagerStrings.providerRoleComprehensiveTitle,
          subtitle: ManagerStrings.providerRoleComprehensiveSubTitle,
          tags: [
            ManagerStrings.providerRoleComprehensiveTag1,
            ManagerStrings.providerRoleComprehensiveTag2,
          ],
          isSelected: selectedRole == 2,
          onTap: () => onRoleSelected(2),
        ),

        SizedBox(height: ManagerHeight.h16),
      ],
    );
  }
}
