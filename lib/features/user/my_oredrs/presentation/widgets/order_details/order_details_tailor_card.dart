import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/order_details_model.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsTailorCard
// Section header inside · avatar with scissors · name · location ·
// chat / call action buttons
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsTailorCard extends StatelessWidget {
  final OrderTailor tailor;
  const OrderDetailsTailorCard({super.key, required this.tailor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(ManagerWidth.w16),
      child: Column(
        children: [
          // ── Section header inside card ────────────────────────────────
          _SectionHeaderInCard(
            icon: Icons.person_outline_rounded,
            title: ManagerStrings.orderDetailsTailorSection,
          ),

          SizedBox(height: ManagerHeight.h8),

          // ── Avatar + name + location (centered) ──────────────────────
          Row(
            children: [
              _TailorAvatar(),
              SizedBox(width: ManagerWidth.w12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tailor.name,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s15,
                      color: ManagerColors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                      SizedBox(width: ManagerWidth.w4),
                      Text(
                        tailor.location,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),

          SizedBox(height: ManagerHeight.h8),


          // ── Action buttons ────────────────────────────────────────────
          Row(
            children: [
              Expanded(
                child: _TailorActionBtn(
                  label: ManagerStrings.orderDetailsChat,
                  icon: Icons.chat_bubble_outline_rounded,
                  isPrimary: true,
                  onTap: () {
                    // TODO: navigate to chat
                  },
                ),
              ),
              SizedBox(width: ManagerWidth.w10),
              Expanded(
                child: _TailorActionBtn(
                  label: ManagerStrings.orderDetailsCall,
                  icon: Icons.phone_outlined,
                  isPrimary: false,
                  onTap: () {
                    // TODO: launch phone dialer
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Private sub-widgets ────────────────────────────────────────────────────

/// Section header rendered inside the card (icon box + title).
class _SectionHeaderInCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeaderInCard({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: ManagerWidth.w30,
          height: ManagerHeight.h30,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.10),
            borderRadius: BorderRadius.circular(ManagerRadius.r8),
          ),
          child: Icon(
            icon,
            size: ManagerFontSize.s15,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

/// Circular dark green avatar with scissors icon.
class _TailorAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ManagerWidth.w56,
      height: ManagerHeight.h56,
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.content_cut_rounded,
        color: Colors.white,
        size: 26,
      ),
    );
  }
}

class _TailorActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _TailorActionBtn({
    required this.label,
    required this.icon,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: Container(
        height: ManagerHeight.h44,
        decoration: BoxDecoration(
          color: isPrimary ? ManagerColors.primaryColor : ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          border: isPrimary
              ? null
              : Border.all(
                  color: ManagerColors.primaryColor.withOpacity(0.5),
                  width: 1.2,
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: ManagerFontSize.s15,
              color:
                  isPrimary ? ManagerColors.white : ManagerColors.primaryColor,
            ),
            SizedBox(width: ManagerWidth.w6),
            Text(
              label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: isPrimary
                    ? ManagerColors.white
                    : ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
