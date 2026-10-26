import 'package:flutter/material.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';

// ──────────────────────────────────────────────────────────────────────────────
// Chat Custom Offer Card
// ──────────────────────────────────────────────────────────────────────────────

/// White elevated card showing a custom offer in the chat thread.
/// Matches the mockup 1:1 — header, details rows, edit/cancel actions.
class ChatCustomOfferCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final int? durationDays;
  final String? addition;
  final String time;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const ChatCustomOfferCard({
    super.key,
    required this.title,
    required this.description,
    required this.price,
    this.durationDays,
    this.addition,
    required this.time,
    this.onEdit,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Card ────────────────────────────────────────────────────────
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
                // ── Header (green tint) ─────────────────────────────────
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

                // ── Description ─────────────────────────────────────────
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

                // ── Divider ─────────────────────────────────────────────
                Divider(
                  height: 1,
                  thickness: 0.8,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.18),
                  indent: ManagerWidth.w14,
                  endIndent: ManagerWidth.w14,
                ),

                SizedBox(height: ManagerHeight.h10),

                // ── Price row ───────────────────────────────────────────
                _DetailRow(
                  icon: Icons.monetization_on_outlined,
                  label: ManagerStrings.chatOfferPrice,
                  value:
                      '${price.toStringAsFixed(0)} ${ManagerStrings.chatOfferCurrency}',
                ),

                SizedBox(height: ManagerHeight.h8),

                // ── Duration row ────────────────────────────────────────
                if (durationDays != null) ...[
                  _DetailRow(
                    icon: Icons.access_time_rounded,
                    label: ManagerStrings.chatOfferDuration,
                    value: '$durationDays ${ManagerStrings.chatOfferDays}',
                  ),
                ],

                // ── Additions row (optional) ────────────────────────────
                if (addition != null && addition!.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
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
                                  text: '${ManagerStrings.chatOfferAdditions}: ',
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

                // ── Edit button ─────────────────────────────────────────
                if (onEdit != null)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
                    child: SizedBox(
                      width: double.infinity,
                      height: ManagerHeight.h42,
                      child: ElevatedButton(
                        onPressed: onEdit,
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
                          ManagerStrings.chatOfferEdit,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                // ── Cancel (text link) ──────────────────────────────────
                if (onCancel != null) ...[
                  SizedBox(height: ManagerHeight.h6),
                  GestureDetector(
                    onTap: onCancel,
                    child: Container(
                      width: double.infinity,
                      height: ManagerHeight.h36,
                      alignment: Alignment.center,
                      child: Text(
                        ManagerStrings.chatOfferCancel,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.primaryColor,
                        ).copyWith(
                          decoration: TextDecoration.underline,
                          decorationColor: ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],

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
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Detail Row — icon + label + value
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

