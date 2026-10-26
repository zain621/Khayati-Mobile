import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

enum TransactionStatus {
  completed,
  pending,
  cancelled,
  approved,
}

class TransactionItem extends StatelessWidget {
  final String title;
  final double amount;
  final String date;
  final TransactionStatus status;
  final bool isDebit;

  const TransactionItem({
    super.key,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    this.isDebit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14, vertical: ManagerHeight.h16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Status Icon Circle
            Container(
              width: ManagerWidth.w34,
              height: ManagerHeight.h34,
              decoration: BoxDecoration(
                  color: _getStatusColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(ManagerRadius.r12)),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w8, vertical: ManagerHeight.h8),
                  child: Image.asset(
                    ManagerIcons.doneIcon,
                    color: _getStatusColor(),
                    height: ManagerHeight.h20,
                    width: ManagerWidth.w20,
                  )),
            ),

            SizedBox(width: ManagerWidth.w12),

            /// Title, Date, and Action Link
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                      if (status == TransactionStatus.cancelled) ...[
                        SizedBox(height: ManagerHeight.h6),
                        Container(
                          width: ManagerWidth.w95,
                          decoration: BoxDecoration(
                            color: ManagerColors.redNew.withOpacity(0.1),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r100),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w12,
                                vertical: ManagerHeight.h4),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.timelapse,
                                  size: ManagerWidth.w12,
                                  color: ManagerColors.redNew,
                                ),
                                SizedBox(
                                  width: ManagerWidth.w2,
                                ),
                                Text(
                                  ManagerStrings.walletTransactionProcessing,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s8,
                                    color: ManagerColors.redNew,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: ManagerWidth.w12),

            /// Amount
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    isDebit ? '- ' : '+ ',
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: _getAmountColor(),
                    ),
                  ),
                  Text(
                    _formatAmount(amount),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: _getAmountColor(),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w2),
                  Text(
                    ManagerStrings.currencySymbol,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: _getAmountColor(),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getAmountColor() {
    switch (status) {
      case TransactionStatus.completed:
      case TransactionStatus.approved:
        return isDebit ? ManagerColors.redNew : ManagerColors.primaryColor;
      case TransactionStatus.pending:
        return ManagerColors.secondaryColor;
      case TransactionStatus.cancelled:
        return ManagerColors.greyWhiteColor;
    }
  }

  Color _getStatusColor() {
    switch (status) {
      case TransactionStatus.completed:
      case TransactionStatus.approved:
        return ManagerColors.primaryColor;
      case TransactionStatus.pending:
        return ManagerColors.secondaryColor;
      case TransactionStatus.cancelled:
        return ManagerColors.redNew;
    }
  }

  // ignore: unused_element
  String _getStatusText() {
    switch (status) {
      case TransactionStatus.completed:
        return ManagerStrings.walletTransactionCompleted;
      case TransactionStatus.pending:
        return ManagerStrings.walletTransactionPending;
      case TransactionStatus.cancelled:
        return ManagerStrings.walletTransactionCancelled;
      case TransactionStatus.approved:
        return ManagerStrings.walletTransactionApproved;
    }
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}
