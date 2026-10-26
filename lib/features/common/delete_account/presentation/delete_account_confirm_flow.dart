import 'dart:ui';

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:flutter/material.dart';

/// Two-step delete-account confirmation required by Google Play.
///
/// 1) Explains permanent deletion (provider copy warns about wallet / orders).
/// 2) Requires typing [DELETE] before the request is sent.
class DeleteAccountConfirmFlow {
  const DeleteAccountConfirmFlow._();

  static Future<bool> confirm(
    BuildContext context, {
    required bool isProvider,
  }) async {
    final first = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.deleteAccountConfirmTitle,
      subtitle: isProvider
          ? ManagerStrings.deleteAccountConfirmSubtitleProvider
          : ManagerStrings.deleteAccountConfirmSubtitle,
      confirmText: ManagerStrings.deleteAccountConfirmButton,
      cancelText: ManagerStrings.deleteAccountCancelButton,
    );
    if (first != true || !context.mounted) return false;

    final second = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => const _TypeDeleteConfirmDialog(),
    );
    return second == true;
  }
}

class _TypeDeleteConfirmDialog extends StatefulWidget {
  const _TypeDeleteConfirmDialog();

  @override
  State<_TypeDeleteConfirmDialog> createState() =>
      _TypeDeleteConfirmDialogState();
}

class _TypeDeleteConfirmDialogState extends State<_TypeDeleteConfirmDialog> {
  static const _requiredWord = 'DELETE';
  final _controller = TextEditingController();
  bool _matches = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final next = _controller.text.trim().toUpperCase() == _requiredWord;
      if (next != _matches) setState(() => _matches = next);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r8),
          ),
          padding: EdgeInsets.all(ManagerWidth.w20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ManagerStrings.deleteAccountTypeConfirmTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ManagerHeight.h8),
              Text(
                ManagerStrings.deleteAccountTypeConfirmSubtitle,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: ManagerHeight.h16),
              TextField(
                controller: _controller,
                autofocus: true,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  hintText: ManagerStrings.deleteAccountTypeConfirmHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    borderSide: const BorderSide(color: ManagerColors.logoutRed),
                  ),
                ),
              ),
              SizedBox(height: ManagerHeight.h20),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _matches
                          ? () => Navigator.of(context).pop(true)
                          : null,
                      child: Container(
                        height: ManagerHeight.h42,
                        decoration: BoxDecoration(
                          color: _matches
                              ? ManagerColors.logoutRed
                              : ManagerColors.logoutRed.withValues(alpha: 0.35),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Center(
                          child: Text(
                            ManagerStrings.deleteAccountConfirmButton,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(false),
                      child: Container(
                        height: ManagerHeight.h42,
                        decoration: BoxDecoration(
                          color: ManagerColors.redNew.withValues(alpha: 0.04),
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r4),
                        ),
                        child: Center(
                          child: Text(
                            ManagerStrings.deleteAccountCancelButton,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.redNew,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
