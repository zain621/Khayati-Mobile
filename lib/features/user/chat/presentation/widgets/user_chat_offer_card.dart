import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';

// ══════════════════════════════════════════════════════════════════════════════
// ── Offer Status
// ══════════════════════════════════════════════════════════════════════════════

enum UserOfferStatus { pending, accepted, declined }

// ══════════════════════════════════════════════════════════════════════════════
// ── User Chat Offer Card
// ══════════════════════════════════════════════════════════════════════════════

/// Card showing a custom offer **received from the provider** in the user chat.
///
/// Differs from [ChatCustomOfferCard]:
/// - Shows **Accept / Decline** instead of Edit / Cancel
/// - Accept triggers a [CustomConfirmDialog] confirmation
/// - After action, card shows a status badge (accepted / declined)
class UserChatOfferCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final int durationDays;
  final String? addition;
  final String time;
  final UserOfferStatus status;
  final ValueChanged<UserOfferStatus>? onStatusChanged;
  /// Required to start Telr payment when the customer accepts.
  final String? conversationId;
  final String? offerId;

  const UserChatOfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    required this.durationDays,
    this.addition,
    required this.time,
    this.status = UserOfferStatus.pending,
    this.onStatusChanged,
    this.conversationId,
    this.offerId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Card ──────────────────────────────────────────────────────
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              color: ManagerColors.white,
              borderRadius: BorderRadius.circular(ManagerRadius.r14),
              boxShadow: [
                BoxShadow(
                  color: ManagerColors.black.withOpacity(0.08),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header (green tint) ───────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w14,
                    vertical: ManagerHeight.h12,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.07),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ManagerRadius.r14),
                      topRight: Radius.circular(ManagerRadius.r14),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: ManagerWidth.w32,
                        height: ManagerHeight.h32,
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.local_offer_rounded,
                          color: ManagerColors.primaryColor,
                          size: ManagerFontSize.s16,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w10),
                      Expanded(
                        child: Text(
                          title,
                          textDirection: Directionality.of(context),
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Description ───────────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(
                    left: ManagerWidth.w14,
                    right: ManagerWidth.w14,
                    top: ManagerHeight.h12,
                    bottom: ManagerHeight.h10,
                  ),
                  child: Text(
                    description,
                    textDirection: Directionality.of(context),
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.black.withOpacity(0.65),
                    ),
                  ),
                ),

                // ── Divider ───────────────────────────────────────────
                Divider(
                  height: 1,
                  thickness: 0.8,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.18),
                  indent: ManagerWidth.w14,
                  endIndent: ManagerWidth.w14,
                ),

                SizedBox(height: ManagerHeight.h10),

                // ── Price row ─────────────────────────────────────────
                _DetailRow(
                  icon: Icons.monetization_on_outlined,
                  label: ManagerStrings.chatOfferPrice,
                  value:
                      '${price.toStringAsFixed(0)} ${ManagerStrings.chatOfferCurrency}',
                ),

                // ── Duration row (optional) ───────────────────────────
                if (durationDays > 0) ...[
                  SizedBox(height: ManagerHeight.h8),
                  _DetailRow(
                    icon: Icons.access_time_rounded,
                    label: ManagerStrings.chatOfferDuration,
                    value: '$durationDays ${ManagerStrings.chatOfferDays}',
                  ),
                ],

                // ── Additions row (optional) ──────────────────────────
                if (addition != null && addition!.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h8),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.add_circle_outline_rounded,
                          color: ManagerColors.primaryColor,
                          size: ManagerFontSize.s15,
                        ),
                        SizedBox(width: ManagerWidth.w6),
                        Expanded(
                          child: RichText(
                            textDirection: Directionality.of(context),
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      '${ManagerStrings.chatOfferAdditions}: ',
                                  style: getMediumTextStyle(
                                    fontSize: ManagerFontSize.s11,
                                    color: ManagerColors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: addition,
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s11,
                                    color: ManagerColors.greyWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                SizedBox(height: ManagerHeight.h14),

                // ── Action buttons / Status badge ─────────────────────
                _buildActions(context),

                SizedBox(height: ManagerHeight.h6),
              ],
            ),
          ),

          // ── Timestamp below card ─────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              top: ManagerHeight.h4,
              right: ManagerWidth.w4,
            ),
            child: Text(
              time,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s10,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────────────────────────────────
  // Actions / status badge depending on current offer status
  // ────────────────────────────────────────────────────────────────────────────

  Widget _buildActions(BuildContext context) {
    switch (status) {
      case UserOfferStatus.accepted:
        return _StatusBadge(
          text: ManagerStrings.chatUserOfferAccepted,
          color: ManagerColors.primaryColor,
          icon: Icons.check_circle_rounded,
        );
      case UserOfferStatus.declined:
        return _StatusBadge(
          text: ManagerStrings.chatUserOfferDeclined,
          color: const Color(0xFFE53935),
          icon: Icons.cancel_rounded,
        );
      case UserOfferStatus.pending:
        return Column(
          children: [
            // Accept button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
              child: SizedBox(
                width: double.infinity,
                height: ManagerHeight.h42,
                child: ElevatedButton(
                  onPressed: () => _handleAccept(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ManagerColors.primaryColor,
                    foregroundColor: ManagerColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ManagerRadius.r10),
                    ),
                  ),
                  child: Text(
                    ManagerStrings.chatUserOfferAccept,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.white,
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: ManagerHeight.h6),

            // Decline text link
            GestureDetector(
              onTap: () => _handleDecline(context),
              child: Container(
                width: double.infinity,
                height: ManagerHeight.h36,
                alignment: Alignment.center,
                child: Text(
                  ManagerStrings.chatUserOfferDecline,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: const Color(0xFFE53935),
                  ).copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: const Color(0xFFE53935),
                  ),
                ),
              ),
            ),
          ],
        );
    }
  }

  Future<void> _handleAccept(BuildContext context) async {
    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.chatUserAcceptDialogTitle,
      subtitle: ManagerStrings.chatUserAcceptDialogSubtitle,
      confirmText: ManagerStrings.chatUserAcceptDialogConfirm,
      cancelText: ManagerStrings.chatUserAcceptDialogCancel,
    );
    if (confirmed != true) return;

    final convId = conversationId?.trim() ?? '';
    final oid = offerId?.trim() ?? '';
    if (convId.isEmpty || oid.isEmpty) {
      AppSnackbar.error(ManagerStrings.invalidPaymentLink);
      return;
    }

    try {
      final response =
          await instance<AppService>().acceptChatOffer(convId, oid);
      final payment = response.data?.payment;
      final rawUrl = payment?.paymentUrl?.trim() ?? '';
      final paymentUrl = CartController.normalizePaymentUrl(rawUrl);
      final sessionId = payment?.paymentSessionId?.trim() ?? '';

      if (paymentUrl.isEmpty) {
        AppSnackbar.error(ManagerStrings.invalidPaymentLink);
        return;
      }

      final paid = await Get.toNamed(
        Routes.checkoutWebViewScreen,
        arguments: {
          'url': paymentUrl,
          'sessionId': sessionId,
          'provider': payment?.provider,
          'source': 'chat',
        },
      );

      if (paid == true) {
        onStatusChanged?.call(UserOfferStatus.accepted);
      }
    } catch (e) {
      AppSnackbar.error(ManagerStrings.paymentNotCompleted);
    }
  }

  Future<void> _handleDecline(BuildContext context) async {
    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.chatUserDeclineDialogTitle,
      subtitle: ManagerStrings.chatUserDeclineDialogSubtitle,
      confirmText: ManagerStrings.chatUserDeclineDialogConfirm,
      cancelText: ManagerStrings.chatUserDeclineDialogCancel,
    );
    if (confirmed != true) return;

    final convId = conversationId?.trim() ?? '';
    final oid = offerId?.trim() ?? '';
    if (convId.isEmpty || oid.isEmpty) {
      onStatusChanged?.call(UserOfferStatus.declined);
      return;
    }

    try {
      await instance<AppService>().rejectChatOffer(convId, oid);
      onStatusChanged?.call(UserOfferStatus.declined);
    } catch (_) {
      AppSnackbar.error(ManagerStrings.errorTitle);
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ── Detail Row — icon + label + value
// ══════════════════════════════════════════════════════════════════════════════

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _DetailRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
      child: Row(
        children: [
          Icon(
            icon,
            color: ManagerColors.primaryColor,
            size: ManagerFontSize.s15,
          ),
          SizedBox(width: ManagerWidth.w6),
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ── Status Badge (shown after accept/decline)
// ══════════════════════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const _StatusBadge({
    required this.text,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
          border: Border.all(
            color: color.withOpacity(0.25),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: ManagerWidth.w18),
            SizedBox(width: ManagerWidth.w6),
            Text(
              text,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s13,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
