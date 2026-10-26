import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_domain_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_colors.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsSummaryCard
// Shows: type badge · order number · status chip · creation date
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsSummaryCard extends StatelessWidget {
  final UserOrderDomainModel order;
  const OrderDetailsSummaryCard({super.key, required this.order});

  // ── helpers ────────────────────────────────────────────────────────────────

  bool get _isShop => order.orderType == UserOrderApiType.shop;

  String get _badgeLabel =>
      _isShop ? ManagerStrings.orderDetailsReadyBadge : ManagerStrings.orderDetailsCustomBadge;

  IconData get _badgeIcon =>
      _isShop ? Icons.shopping_bag_rounded : Icons.design_services_rounded;

  String get _statusLabel {
    switch (order.status) {
      case UserOrderApiStatus.active:
        return _isShop
            ? ManagerStrings.orderDetailsStatusInProgress
            : (order.hasAcceptedOffer
                ? ManagerStrings.orderDetailsStatusInProgress
                : ManagerStrings.orderDetailsStatusWaiting);
      case UserOrderApiStatus.accepted:
        return ManagerStrings.orderDetailsStatusHasOffers;
      case UserOrderApiStatus.completed:
        return ManagerStrings.orderDetailsStatusCompleted;
      case UserOrderApiStatus.cancelled:
        return ManagerStrings.orderDetailsStatusWaiting;
      case UserOrderApiStatus.unknown:
        return order.status.name;
    }
  }

  IconData get _statusIcon {
    switch (order.status) {
      case UserOrderApiStatus.active:
        return _isShop ? Icons.autorenew_rounded : Icons.hourglass_top_rounded;
      case UserOrderApiStatus.accepted:
        return Icons.mail_rounded;
      case UserOrderApiStatus.completed:
        return Icons.check_circle_rounded;
      case UserOrderApiStatus.cancelled:
        return Icons.cancel_outlined;
      case UserOrderApiStatus.unknown:
        return Icons.help_outline_rounded;
    }
  }

  String _formatDate(String iso) {
    if (iso.isEmpty) return '—';
    try {
      final dt = DateTime.parse(iso).toLocal();
      return '${dt.year}/${dt.month.toString().padLeft(2, '0')}/${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }

  // ── build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14,
          vertical: ManagerHeight.h14,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── 1. Order-type badge ───────────────────────────────────
            _TypeBadge(label: _badgeLabel, icon: _badgeIcon),

            SizedBox(height: ManagerHeight.h4),

            // ── 2. Order number ───────────────────────────────────────
            _OrderNumberBlock(
              orderId: order.orderNumber.isNotEmpty ? order.orderNumber : order.id,
            ),

            SizedBox(height: ManagerHeight.h6),

            // ── 3. Status section ─────────────────────────────────────
            _StatusSection(
              statusLabel: _statusLabel,
              statusIcon: _statusIcon,
              completedStages: order.completedStages,
              totalStages: order.totalStages,
            ),

            SizedBox(height: ManagerHeight.h8),

            // ── 4. Date row ───────────────────────────────────────────
            _DatesRow(orderDate: _formatDate(order.createdAt)),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

/// Blue pill badge centred at top — icon + label.
class _TypeBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _TypeBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1D4ED8).withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ManagerFontSize.s13,
            color: const Color(0xFF1D4ED8),
          ),
          SizedBox(width: ManagerWidth.w6),
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: const Color(0xFF1D4ED8),
            ),
          ),
        ],
      ),
    );
  }
}

/// "طلب رقم" small label + "ORD-2024-002" large bold — start-aligned.
class _OrderNumberBlock extends StatelessWidget {
  final String orderId;
  const _OrderNumberBlock({required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            ManagerStrings.orderDetailsOrderIdLabel,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ),
        SizedBox(height: ManagerHeight.h4),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            orderId,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s20,
              color: ManagerColors.black,
            ),
          ),
        ),
      ],
    );
  }
}

/// Mint-background container: status chip + stages progress.
class _StatusSection extends StatelessWidget {
  final String statusLabel;
  final IconData statusIcon;
  final int completedStages;
  final int totalStages;

  const _StatusSection({
    required this.statusLabel,
    required this.statusIcon,
    required this.completedStages,
    required this.totalStages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.04),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Row(
        children: [
          Text(
            ManagerStrings.orderDetailsCurrentStatus,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.primaryColor,
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h6,
            ),
            decoration: BoxDecoration(
              color: kOdStatusChipBg,
              borderRadius: BorderRadius.circular(ManagerRadius.r24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  statusIcon,
                  size: ManagerFontSize.s14,
                  color: kOdStatusChipText,
                ),
                SizedBox(width: ManagerWidth.w4),
                Text(
                  statusLabel,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: kOdStatusChipText,
                  ),
                ),
                if (totalStages > 0) ...[
                  SizedBox(width: ManagerWidth.w6),
                  Text(
                    '$completedStages/$totalStages',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: kOdStatusChipText.withOpacity(0.75),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Calendar icon + creation date.
class _DatesRow extends StatelessWidget {
  final String orderDate;
  const _DatesRow({required this.orderDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: ManagerFontSize.s13,
          color: ManagerColors.greyWhiteColor,
        ),
        SizedBox(width: ManagerWidth.w4),
        Text(
          '${ManagerStrings.orderDetailsOrderDate} $orderDate',
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }
}
