import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/auth/domain/model/demo_accounts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Tappable list of the four seeded demo roles so testers can fill login.
class DemoAccountsPanel extends StatelessWidget {
  const DemoAccountsPanel({
    super.key,
    required this.onSelect,
  });

  final ValueChanged<DemoAccount> onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ManagerWidth.w12),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ManagerStrings.demoAccountsTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            ManagerStrings.demoAccountsSubtitle,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          Wrap(
            spacing: ManagerWidth.w8,
            runSpacing: ManagerHeight.h8,
            children: [
              _CredentialChip(
                label: '${ManagerStrings.demoOtpHint} ${DemoAccounts.otp}',
              ),
              _CredentialChip(
                label:
                    '${ManagerStrings.demoPasswordHint} ${DemoAccounts.password}',
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h12),
          ...DemoAccounts.all.map(
            (account) => Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h8),
              child: _DemoAccountTile(
                account: account,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onSelect(account);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CredentialChip extends StatelessWidget {
  const _CredentialChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _DemoAccountTile extends StatelessWidget {
  const _DemoAccountTile({
    required this.account,
    required this.onTap,
  });

  final DemoAccount account;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManagerColors.white,
      borderRadius: BorderRadius.circular(ManagerRadius.r10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w12,
            vertical: ManagerHeight.h10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.roleLabel(account.role),
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h2),
                    Text(
                      '${account.fullName}  ·  ${account.dialCode} ${account.nationalNumber}',
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: ManagerColors.primaryColor,
                size: ManagerHeight.h22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
