import 'package:app_mobile/constants/constants/constants.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/locale/locales.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageBottomSheet extends StatelessWidget {
  /// When true, includes Urdu (visitor). When false, English + Arabic only.
  final bool includeUrdu;

  const LanguageBottomSheet({
    super.key,
    this.includeUrdu = false,
  });

  static Future<void> show(BuildContext context) {
    final role = instance<AppSettingsPrefs>().getUserRole();
    final isVisitor = role.isEmpty || role == 'user';
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => LanguageBottomSheet(includeUrdu: isVisitor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LocaleController>();
    final currentLocale =
        EasyLocalization.of(context)?.currentLocale?.languageCode ??
            Constants.english;
    final languages = includeUrdu
        ? LocaleSettings.visitorLanguages
        : LocaleSettings.tailorLanguages;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r24),
        ),
      ),
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w24,
        ManagerHeight.h20,
        ManagerWidth.w24,
        ManagerHeight.h32 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Handle bar
          Center(
            child: Container(
              width: ManagerWidth.w40,
              height: ManagerHeight.h4,
              decoration: BoxDecoration(
                color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                borderRadius: BorderRadius.circular(ManagerRadius.r4),
              ),
            ),
          ),
          SizedBox(height: ManagerHeight.h20),

          /// Title
          Text(
            ManagerStrings.selectLanguage,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s18,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h16),

          /// Language options (visitor: EN/AR/UR — tailor: EN/AR)
          ...languages.entries.map((entry) {
            final langCode = entry.key;
            final langName = entry.value;
            final isSelected = currentLocale == langCode;

            return Obx(() {
              final isChanging = controller.isChangingLanguage.value;
              return _LanguageTile(
                langCode: langCode,
                langName: langName,
                isSelected: isSelected,
                isChanging: isChanging,
                onTap: isChanging
                    ? null
                    : () {
                        // Close the sheet immediately so the profile-screen
                        // loading overlay becomes visible while the locale
                        // change is happening in the background.
                        Navigator.of(context).pop();
                        controller.changeLanguage(langCode);
                      },
              );
            });
          }),

          SizedBox(height: ManagerHeight.h8),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String langCode;
  final String langName;
  final bool isSelected;
  final bool isChanging;
  final VoidCallback? onTap;

  const _LanguageTile({
    required this.langCode,
    required this.langName,
    required this.isSelected,
    this.isChanging = false,
    this.onTap,
  });

  String get _flagEmoji {
    switch (langCode) {
      case Constants.arabic:
        return '🇦🇪';
      case Constants.english:
        return '🇬🇧';
      case Constants.urdu:
        return '🇵🇰';
      default:
        return '🌐';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: ManagerHeight.h10),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h14,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? ManagerColors.primaryColor.withOpacity(0.08)
              : ManagerColors.greyWhiteColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: Border.all(
            color: isSelected
                ? ManagerColors.primaryColor
                : ManagerColors.greyWhiteColor.withOpacity(0.2),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              _flagEmoji,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(width: ManagerWidth.w12),
            Expanded(
              child: Text(
                langName,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: isSelected
                      ? ManagerColors.primaryColor
                      : ManagerColors.black,
                ),
              ),
            ),
            if (isChanging && isSelected)
              SizedBox(
                width: ManagerWidth.w22,
                height: ManagerWidth.w22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: ManagerColors.primaryColor,
                ),
              )
            else if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: ManagerColors.primaryColor,
                size: ManagerWidth.w22,
              ),
          ],
        ),
      ),
    );
  }
}
