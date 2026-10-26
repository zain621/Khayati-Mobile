import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:app_mobile/features/providers/common_features/wallet/data/request/add_bank_account_request.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/controller/wallet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankAccountScreen extends StatefulWidget {
  final bool isEditMode;
  final String? existingBankName;
  final String? existingAccountHolder;
  final String? existingBankAccount;
  final String? existingBankIban;
  final String? bankAccountId;

  const AddBankAccountScreen({
    super.key,
    this.isEditMode = false,
    this.existingBankName,
    this.existingAccountHolder,
    this.existingBankAccount,
    this.existingBankIban,
    this.bankAccountId,
  });

  @override
  State<AddBankAccountScreen> createState() => _AddBankAccountScreenState();
}

class _AddBankAccountScreenState extends State<AddBankAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bankNameController = TextEditingController();
  final _accountOwnerController = TextEditingController();
  final _accountNumberController = TextEditingController();
  final _ibanController = TextEditingController();

  final _bankNameFocus = FocusNode();
  final _accountOwnerFocus = FocusNode();
  final _accountNumberFocus = FocusNode();
  final _ibanFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode) {
      _bankNameController.text = widget.existingBankName ?? '';
      _accountOwnerController.text = widget.existingAccountHolder ?? '';
      _accountNumberController.text = widget.existingBankAccount ?? '';
      _ibanController.text = widget.existingBankIban ?? '';
    }
  }

  @override
  void dispose() {
    _bankNameController.dispose();
    _accountOwnerController.dispose();
    _accountNumberController.dispose();
    _ibanController.dispose();

    _bankNameFocus.dispose();
    _accountOwnerFocus.dispose();
    _accountNumberFocus.dispose();
    _ibanFocus.dispose();
    super.dispose();
  }

  void _handleAddAccount() async {
    if (_formKey.currentState!.validate()) {
      // Show confirmation dialog
      final bool? confirmed = await CustomConfirmDialog.show(
        context: context,
        title: widget.isEditMode
            ? ManagerStrings.editBankAccountFormTitle
            : ManagerStrings.addBankAccountConfirmTitle,
        subtitle: widget.isEditMode
            ? ManagerStrings.editBankAccountFormSubTitle
            : ManagerStrings.addBankAccountConfirmSubtitle,
        confirmText: widget.isEditMode
            ? ManagerStrings.editBankAccountFormButton
            : ManagerStrings.addBankAccountConfirmButton,
        cancelText: ManagerStrings.addBankAccountCancelButton,
      );

      if (confirmed == true && mounted) {
        final ctrl = Get.find<WalletController>();
        final request = AddBankAccountRequest(
          bankName: _bankNameController.text.trim(),
          accountHolderName: _accountOwnerController.text.trim(),
          accountNumber: _accountNumberController.text.trim(),
          iban: _ibanController.text.trim(),
        );

        final bool success;
        if (widget.isEditMode && widget.bankAccountId != null) {
          success = await ctrl.updateBankAccount(widget.bankAccountId!, request);
        } else {
          success = await ctrl.addBankAccount(request);
        }

        if (success && mounted) {
          Navigator.of(context).pop(true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ctrl = Get.find<WalletController>();
      final isSaving = ctrl.isSaving.value;

      return Stack(
        children: [
          /// ── Main Screen ──────────────────────────────────────────────────
          AbsorbPointer(
            absorbing: isSaving,
            child: BaseAppScaffold(
              title: widget.isEditMode
                  ? ManagerStrings.editBankAccountFormTitle
                  : ManagerStrings.addBankAccountFormTitle,
              subtitle: widget.isEditMode
                  ? ManagerStrings.editBankAccountFormSubTitle
                  : ManagerStrings.addBankAccountFormSubTitle,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ManagerHeight.h24),

                    /// Title Section
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.isEditMode
                                ? ManagerStrings.editBankAccountFormTitle
                                : ManagerStrings.addBankAccountFormTitle,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h8),
                          Text(
                            widget.isEditMode
                                ? ManagerStrings.editBankAccountFormSubTitle
                                : ManagerStrings.addBankAccountFormSubTitle,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: ManagerHeight.h32),

                    /// Bank Name Field
                    LabeledTextField(
                      label: ManagerStrings.addBankAccountFormSub1,
                      hintText: ManagerStrings.addBankAccountFormHint1,
                      controller: _bankNameController,
                      focusNode: _bankNameFocus,
                      nextFocusNode: _accountOwnerFocus,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ManagerStrings.addBankAccountFormSub1;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    /// Account Owner Name Field
                    LabeledTextField(
                      label: ManagerStrings.addBankAccountFormSub2,
                      hintText: ManagerStrings.addBankAccountFormHint2,
                      controller: _accountOwnerController,
                      focusNode: _accountOwnerFocus,
                      nextFocusNode: _accountNumberFocus,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ManagerStrings.addBankAccountFormSub2;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    /// Account Number Field
                    LabeledTextField(
                      label: ManagerStrings.addBankAccountFormSub3,
                      hintText: ManagerStrings.addBankAccountFormHint3,
                      controller: _accountNumberController,
                      focusNode: _accountNumberFocus,
                      nextFocusNode: _ibanFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ManagerStrings.addBankAccountFormSub3;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: ManagerHeight.h20),

                    /// IBAN Field
                    LabeledTextField(
                      label: ManagerStrings.addBankAccountFormSub4,
                      hintText: ManagerStrings.addBankAccountFormHint4,
                      controller: _ibanController,
                      focusNode: _ibanFocus,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return ManagerStrings.addBankAccountFormSub4;
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: ManagerHeight.h40),

                    /// Add / Update Account Button
                    ButtonApp(
                      title: widget.isEditMode
                          ? ManagerStrings.updateProfileSaveButton
                          : ManagerStrings.addBankAccountFormButton,
                      onPressed: isSaving ? () {} : _handleAddAccount,
                      paddingWidth: ManagerWidth.w16,
                    ),

                    SizedBox(height: ManagerHeight.h24),
                  ],
                ),
              ),
            ),
          ),

          /// ── Loading Overlay ───────────────────────────────────────────────
          if (isSaving)
            Positioned.fill(
              child: Container(
                color: ManagerColors.black.withOpacity(0.35),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ManagerColors.white,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
