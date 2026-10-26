import 'package:app_mobile/constants/constants/constants.dart';
import 'package:app_mobile/core/locale/locale_controller.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Account path that selected a language context.
enum LanguageAudience {
  /// Customer / visitor — English, Arabic, Urdu
  visitor,

  /// Tailor / provider — English, Arabic only
  tailor,
}

/// Dedicated language pick after account-type choice.
/// Flow: Slider → Login choices → Language → Register
class LanguageSelectionScreen extends StatefulWidget {
  final LanguageAudience audience;

  const LanguageSelectionScreen({
    super.key,
    required this.audience,
  });

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  late String _selected;

  List<(String code, String name, String flag)> get _options {
    final base = <(String, String, String)>[
      (Constants.english, Constants.englishName, '🇬🇧'),
      (Constants.arabic, Constants.arabicName, '🇦🇪'),
    ];
    if (widget.audience == LanguageAudience.visitor) {
      base.add((Constants.urdu, Constants.urduName, '🇵🇰'));
    }
    return base;
  }

  @override
  void initState() {
    super.initState();
    _selected = Constants.english;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final current =
          EasyLocalization.of(context)?.currentLocale?.languageCode ??
              Constants.english;
      final codes = _options.map((e) => e.$1).toList();
      setState(() {
        _selected = codes.contains(current) ? current : Constants.english;
      });
    });
  }

  Future<void> _continue() async {
    final controller = Get.find<LocaleController>();
    await controller.changeLanguage(_selected);
    if (!mounted) return;

    if (widget.audience == LanguageAudience.visitor) {
      Navigator.pushReplacementNamed(context, Routes.customerRegister);
    } else {
      Navigator.pushReplacementNamed(context, Routes.providerRegister);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppSafeArea(
      child: Scaffold(
        backgroundColor: ManagerColors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: ManagerHeight.h52),
              Stack(
                alignment: Alignment.center,
                children: [
                  const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthBackButton(),
                  ),
                  Text(
                    ManagerStrings.selectLanguage,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ManagerHeight.h28),
              Text(
                widget.audience == LanguageAudience.visitor
                    ? ManagerStrings.languageSelectVisitorHint
                    : ManagerStrings.languageSelectTailorHint,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ManagerHeight.h28),
              ..._options.map((opt) {
                final selected = _selected == opt.$1;
                return Padding(
                  padding: EdgeInsets.only(bottom: ManagerHeight.h12),
                  child: GestureDetector(
                    onTap: () => setState(() => _selected = opt.$1),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h16,
                      ),
                      decoration: BoxDecoration(
                        color: selected
                            ? ManagerColors.primaryColor.withOpacity(0.08)
                            : ManagerColors.white,
                        borderRadius: BorderRadius.circular(ManagerRadius.r14),
                        border: Border.all(
                          color: selected
                              ? ManagerColors.primaryColor
                              : ManagerColors.greyWhiteColor.withOpacity(0.25),
                          width: selected ? 1.6 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(selected ? 0.06 : 0.03),
                            blurRadius: selected ? 12 : 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(opt.$3, style: const TextStyle(fontSize: 26)),
                          SizedBox(width: ManagerWidth.w14),
                          Expanded(
                            child: Text(
                              opt.$2,
                              style: getMediumTextStyle(
                                fontSize: ManagerFontSize.s15,
                                color: selected
                                    ? ManagerColors.primaryColor
                                    : ManagerColors.black,
                              ),
                            ),
                          ),
                          Icon(
                            selected
                                ? Icons.check_circle_rounded
                                : Icons.circle_outlined,
                            color: selected
                                ? ManagerColors.primaryColor
                                : ManagerColors.greyWhiteColor,
                            size: 22,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),
              ButtonApp(
                title: ManagerStrings.onBoardingNext,
                onPressed: _continue,
                paddingWidth: 0,
              ),
              SizedBox(height: ManagerHeight.h28),
            ],
          ),
        ),
      ),
    );
  }
}
