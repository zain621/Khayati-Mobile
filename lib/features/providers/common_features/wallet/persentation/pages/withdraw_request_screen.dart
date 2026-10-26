import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/labeled_text_field.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/controller/wallet_controller.dart';
import 'package:app_mobile/features/providers/common_features/wallet/data/request/withdrawal_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WithdrawRequestScreen extends StatefulWidget {
  const WithdrawRequestScreen({super.key});

  @override
  State<WithdrawRequestScreen> createState() => _WithdrawRequestScreenState();
}

class _WithdrawRequestScreenState extends State<WithdrawRequestScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  late final WalletController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = Get.find<WalletController>();
    _amountController.text = '';
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSaving = ctrl.isSaving.value;
      return Stack(
        children: [
          /// ── Main Screen ───────────────────────────────────────────────────
          AbsorbPointer(
            absorbing: isSaving,
            child: BaseAppScaffold(
              title: ManagerStrings.withdrawRequestTitle,
              subtitle: ManagerStrings.withdrawRequestSubtitle,
              showBackButton: true,
              child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ManagerHeight.h12),

            /// Withdraw Request Card
            _buildWithdrawRequestCard(),

            SizedBox(height: ManagerHeight.h24),

            /// Confirm Button
            Obx(() => ButtonApp(
                  title: ManagerStrings.withdrawRequestConfirmButton,
                  onPressed:
                      ctrl.isSaving.value ? () {} : _handleConfirmWithdraw,
                  paddingWidth: 0,
                )),


            SizedBox(height: ManagerHeight.h12),

            /// Processing Time Info
            _buildProcessingTimeInfo(),

            SizedBox(height: ManagerHeight.h24),
          ],
        ),
      ),
    ),
          ),

          /// ── Loading Overlay ───────────────────────────────────────────────
          if (isSaving) const Positioned.fill(child: LoadingWidget()),
        ],
      );
    });
  }

  Widget _buildWithdrawRequestCard() {
    return Container(
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Card Header with Icon
          Row(
            children: [
              Container(
                width: ManagerWidth.w48,
                height: ManagerHeight.h48,
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor,
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w8,
                    vertical: ManagerWidth.w8,
                  ),
                  child: Image.asset(
                    ManagerIcons.cardIcon,
                    height: ManagerHeight.h24,
                    width: ManagerWidth.w24,
                  ),
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.withdrawRequestCardTitle,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      ManagerStrings.withdrawRequestCardSubtitle,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s11,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: ManagerHeight.h24),

          /// Amount Section
          Text(
            ManagerStrings.withdrawRequestAmountLabel,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),

          LabeledTextField(
            label: null,
            hintText: '0',
            controller: _amountController,
            keyboardType: TextInputType.number,
            paddingWidth: 0,
          ),

          SizedBox(height: ManagerHeight.h12),

          /// Max Limit Text
          Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    ManagerStrings.withdrawRequestMaxLimit,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w4),
                  Text(
                    _formatAmount(
                        ctrl.wallet.value?.withdrawableBalance ?? 0),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w4),
                  Text(
                    ManagerStrings.currencySymbol,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ],
              )),

          SizedBox(height: ManagerHeight.h16),

          /// Notes Section
          LabeledTextField(
            label: ManagerStrings.withdrawRequestNotesLabel,
            hintText: ManagerStrings.withdrawRequestNotesHint,
            controller: _notesController,
            keyboardType: TextInputType.multiline,
            minLines: 4,
            maxLines: 6,
            paddingWidth: 0,
          ),
          SizedBox(height: ManagerHeight.h16),

          /// Bank Account Section
          Obx(() => Container(
                padding: EdgeInsets.all(ManagerWidth.w14),
                decoration: BoxDecoration(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  border: Border.all(
                    color: ManagerColors.greyWhiteColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ManagerStrings.withdrawRequestBankAccountLabel,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h6),
                          Text(
                            ctrl.hasBankAccount
                                ? '${ctrl.primaryBankAccount!.bankName} - ${_getFormattedIban(ctrl.primaryBankAccount!.iban)}'
                                : ManagerStrings.withdrawRequestNoBankAccount,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _handleChangeAccount,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w10,
                          vertical: ManagerHeight.h6,
                        ),
                        decoration: BoxDecoration(
                          color: ManagerColors.secondaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(ManagerRadius.r6),
                        ),
                        child: Text(
                          ManagerStrings.withdrawRequestChangeAccount,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildProcessingTimeInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.info_outline,
          size: ManagerWidth.w16,
          color: ManagerColors.greyWhiteColor,
        ),
        SizedBox(width: ManagerWidth.w6),
        Text(
          ManagerStrings.withdrawRequestProcessingTime,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s10,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  void _handleChangeAccount() {
    Navigator.pushNamed(
      context,
      Routes.addBankAccountScreen,
      arguments: {
        'isEditMode': ctrl.hasBankAccount,
        'existingBankName': ctrl.primaryBankAccount?.bankName,
        'existingAccountHolder': ctrl.primaryBankAccount?.accountHolderName,
        'existingBankAccount': ctrl.primaryBankAccount?.accountNumber,
        'existingBankIban': ctrl.primaryBankAccount?.iban,
        'bankAccountId': ctrl.primaryBankAccount?.id,
      },
    );
  }

  Future<void> _handleConfirmWithdraw() async {
    if (!ctrl.hasBankAccount) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ManagerStrings.withdrawRequestNoBankAccount),
          backgroundColor: ManagerColors.redNew,
        ),
      );
      return;
    }

    final String amountText = _amountController.text.replaceAll(',', '');
    final double? amount = double.tryParse(amountText);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ManagerStrings.withdrawRequestInvalidAmount),
          backgroundColor: ManagerColors.redNew,
        ),
      );
      return;
    }

    final double withdrawable = ctrl.wallet.value?.withdrawableBalance ?? 0;
    if (amount > withdrawable) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ManagerStrings.withdrawRequestAmountExceedsLimit),
          backgroundColor: ManagerColors.redNew,
        ),
      );
      return;
    }

    final bool? confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.withdrawRequestConfirmDialogTitle,
      subtitle: ManagerStrings.withdrawRequestConfirmDialogSubtitle,
      confirmText: ManagerStrings.withdrawRequestConfirmDialogConfirm,
      cancelText: ManagerStrings.withdrawRequestConfirmDialogCancel,
    );

    if (confirmed != true) return;

    final bool success = await ctrl.withdraw(
      WithdrawalRequest(
        amount: amount,
        notes: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        bankAccountId: ctrl.primaryBankAccount!.id,
      ),
    );

    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  String _getFormattedIban(String iban) {
    if (iban.length <= 8) return iban;
    return '${iban.substring(0, 4)}****${iban.substring(iban.length - 4)}';
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
