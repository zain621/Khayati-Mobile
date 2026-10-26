import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

class WalletBalanceCard extends StatelessWidget {
  final double currentBalance;
  final double pendingBalance;
  final double withdrawableBalance;

  const WalletBalanceCard({
    super.key,
    required this.currentBalance,
    required this.pendingBalance,
    required this.withdrawableBalance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ManagerHeight.h14),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Current Balance Label
                    Text(
                      ManagerStrings.walletCurrentBalance,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),

                    SizedBox(height: ManagerHeight.h8),

                    /// Current Balance Amount
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatAmount(currentBalance),
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s36,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w4),
                        Padding(
                          padding: EdgeInsets.only(bottom: ManagerHeight.h5),
                          child: Text(
                            ManagerStrings.currencyNameFull,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Spacer(),

                /// Wallet Icon
                Container(
                    width: ManagerWidth.w42,
                    height: ManagerHeight.h42,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor,
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w8,
                          vertical: ManagerHeight.h8),
                      child: Image.asset(
                        ManagerIcons.cardIcon,
                        height: ManagerHeight.h24,
                        width: ManagerWidth.w24,
                      ),
                    )),
              ],
            ),

            SizedBox(height: ManagerHeight.h16),

            /// Dotted Divider
            CustomPaint(
              size: Size(double.infinity, 1),
              painter: DottedLinePainter(
                color: ManagerColors.greyWhiteColor.withOpacity(0.4),
              ),
            ),

            SizedBox(height: ManagerHeight.h16),

            /// Pending Balance Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ManagerStrings.walletPendingBalance,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _formatAmount(pendingBalance),
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w2),
                    Text(
                      ManagerStrings.currencySymbol,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ],
            ),

            SizedBox(height: ManagerHeight.h16),

            /// Withdrawable Balance Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ManagerStrings.walletWithdrawableBalance,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _formatAmount(withdrawableBalance),
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w2),
                   Text(
                      ManagerStrings.currencySymbol,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: ManagerHeight.h14),
          ],
        ),
      ),
    );
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(1).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
        );
  }
}

/// Custom Painter for Dotted Line
class DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashLength;
  final double dashSpace;

  DottedLinePainter({
    required this.color,
    this.dashLength = 6.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashLength, 0),
        paint,
      );
      startX += dashLength + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
