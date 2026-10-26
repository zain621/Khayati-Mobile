import 'package:app_mobile/constants/constants/constants.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Which languages the switcher offers.
enum LanguageSwitcherMode {
  /// English + Arabic (tailors / default auth)
  tailor,

  /// English + Arabic + Urdu (visitors / customers)
  visitor,
}

/// Top-bar language control.
class LanguageSwitcherButton extends StatelessWidget {
  final Color? foregroundColor;
  final LanguageSwitcherMode mode;

  const LanguageSwitcherButton({
    super.key,
    this.foregroundColor,
    this.mode = LanguageSwitcherMode.tailor,
  });

  List<(String code, String label)> get _options {
    final list = <(String, String)>[
      (Constants.english, Constants.englishName),
      (Constants.arabic, Constants.arabicName),
    ];
    if (mode == LanguageSwitcherMode.visitor) {
      list.add((Constants.urdu, Constants.urduName));
    }
    return list;
  }

  String _labelFor(String code) {
    if (code.startsWith(Constants.arabic)) return Constants.arabicName;
    if (code.startsWith(Constants.urdu)) return Constants.urduName;
    return Constants.englishName;
  }

  @override
  Widget build(BuildContext context) {
    final color = foregroundColor ?? ManagerColors.primaryColor;
    final current =
        EasyLocalization.of(context)?.currentLocale?.languageCode ??
            Constants.english;
    final currentLabel = _labelFor(current);
    final options = _options;

    return PopupMenuButton<String>(
      tooltip: 'Language',
      offset: const Offset(0, 40),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 140),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: ManagerColors.white,
      elevation: 8,
      onSelected: (code) {
        if (!Get.isRegistered<LocaleController>()) return;
        Get.find<LocaleController>().changeLanguage(code);
      },
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<String>(
            value: option.$1,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option.$2,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: current == option.$1
                          ? ManagerColors.primaryColor
                          : ManagerColors.black,
                    ),
                  ),
                ),
                if (current == option.$1)
                  const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: ManagerColors.primaryColor,
                  ),
              ],
            ),
          ),
      ],
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.language_rounded, size: 20, color: color),
              const SizedBox(width: 6),
              Text(
                currentLabel,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: color,
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
