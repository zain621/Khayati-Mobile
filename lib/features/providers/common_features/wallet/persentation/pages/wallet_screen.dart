import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/button_app.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/widgets/wallet_app_bar_custom.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/widgets/transaction_item.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/widgets/wallet_balance_card.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/controller/wallet_controller.dart';
import 'package:app_mobile/features/providers/common_features/wallet/persentation/widgets/wallet_screen_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController _scrollController = ScrollController();
  late final WalletController ctrl;

  @override
  void initState() {
    super.initState();
    ctrl = Get.find<WalletController>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SafeArea(
        top: false,
        bottom: true,
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          extendBody: true,
          body: Stack(
            children: [
              /// App Bar
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: WalletAppBarCustom(
                  title: ManagerStrings.walletScreenTitle,
                  subtitle: ManagerStrings.walletScreenSubTitle,
                  showBackButton: true,
                  trailing: GestureDetector(
                    onTap: _handleBankAccount,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w10,
                        vertical: ManagerHeight.h6,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.account_balance,
                            color: ManagerColors.white,
                            size: ManagerHeight.h18,
                          ),
                          SizedBox(width: ManagerWidth.w4),
                          Text(
                            ManagerStrings.walletBankAccountButton,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: ManagerHeight.h104,
                left: 0,
                right: 0,
                bottom: 0,
                child: RefreshIndicator(
                  onRefresh: () async {
                    ctrl.loadAll();
                    // wait for all three loaders to finish
                    await Future.doWhile(() async {
                      await Future.delayed(const Duration(milliseconds: 100));
                      return ctrl.isLoadingWallet.value ||
                          ctrl.isLoadingTransactions.value ||
                          ctrl.isLoadingBankAccounts.value;
                    });
                  },
                  color: ManagerColors.primaryColor,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Balance Card
                        Obx(() {
                          if (ctrl.isLoadingWallet.value &&
                              ctrl.wallet.value == null) {
                            return const WalletBalanceCardShimmer();
                          }
                          return WalletBalanceCard(
                            currentBalance:
                                ctrl.wallet.value?.totalBalance ?? 0,
                            pendingBalance:
                                ctrl.wallet.value?.pendingBalance ?? 0,
                            withdrawableBalance:
                                ctrl.wallet.value?.withdrawableBalance ?? 0,
                          );
                        }),
                        SizedBox(height: ManagerHeight.h16),

                        /// Withdraw / Add Bank Account Button
                        Obx(() {
                          if (ctrl.isLoadingBankAccounts.value) {
                            return const WalletActionButtonShimmer();
                          }
                          return ctrl.hasBankAccount
                              ? ButtonApp(
                                  title: ManagerStrings.walletWithdrawButton,
                                  onPressed: _handleWithdraw,
                                  paddingWidth: ManagerWidth.w16,
                                )
                              : ButtonApp(
                                  title: ManagerStrings.addBankAccountFormTitle,
                                  onPressed: _handleAddBankAccount,
                                  paddingWidth: ManagerWidth.w16,
                                );
                        }),
                        SizedBox(height: ManagerHeight.h16),

                        /// Transactions Title
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: ManagerWidth.w16),
                          child: Text(
                            ManagerStrings.walletTransactionsTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h12),

                        /// Transactions List
                        Obx(() {
                          if (ctrl.isLoadingTransactions.value) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: ManagerHeight.h24,
                              ),
                              child: const WalletTransactionsListShimmer(),
                            );
                          }
                          if (ctrl.transactions.isEmpty) {
                            return _buildEmptyState();
                          }
                          return ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(
                              ManagerWidth.w16,
                              0,
                              ManagerWidth.w16,
                              ManagerHeight.h24,
                            ),
                            itemCount: ctrl.transactions.length,
                            itemBuilder: (context, index) {
                              final tx = ctrl.transactions[index];
                              return TransactionItem(
                                title: tx.typeLabel,
                                amount: tx.amount,
                                date: tx.createdAt,
                                status: tx.isDebit
                                    ? TransactionStatus.cancelled
                                    : TransactionStatus.completed,
                                isDebit: tx.isDebit,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: ManagerHeight.h12);
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h80),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: ManagerHeight.h80,
              color: ManagerColors.greyWhiteColor,
            ),
            SizedBox(height: ManagerHeight.h16),
            Text(
              ManagerStrings.walletNoTransactions,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            Text(
              ManagerStrings.walletNoTransactionsDescription,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleWithdraw() {
    Navigator.pushNamed(
      context,
      Routes.withdrawRequestScreen,
    );
  }

  void _handleAddBankAccount() {
    Navigator.pushNamed(
      context,
      Routes.addBankAccountScreen,
    );
  }

  void _handleBankAccount() {
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
}
