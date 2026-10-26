// ignore_for_file: avoid_unused_constructor_parameters
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ══════════════════════════════════════════════════════════════════════════════
// UserOrderCard — matches the screenshots 1:1
//
// LAYOUT (RTL — image RIGHT, content LEFT):
//  ┌────────────────────────────────────────────────────────┐
//  │  [Content]                              [Image w100]   │
//  │   [Type badge pill]                     [h120]         │
//  │   Title (bold, 2 lines)                 [N badge •]    │
//  │   [Bundle row — thumbnails + count]                    │
//  │   ◆ Price  [(متوسط X د.إ للقطعة)]                     │
//  │   📅 Date                                              │
//  │   👤 Tailor name (if any)                              │
//  │                               [Inline status pill →]  │
//  ├────────────────────────────────────────────────────────┤
//  │  [   Full-width action button   ]  (hasOffers / ready) │
//  └────────────────────────────────────────────────────────┘
// ══════════════════════════════════════════════════════════════════════════════

class UserOrderCard extends StatelessWidget {
  final UserOrderModel order;
  final VoidCallback? onTap;
  final VoidCallback? onChat;

  const UserOrderCard({
    super.key,
    required this.order,
    this.onTap,
    this.onChat,
  });

  // ── Type badge config ────────────────────────────────────────────────────────

  _BadgeConfig get _typeConfig {
    switch (order.orderType) {
      case UserOrderType.custom:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersTypeCustom,
          bgColor: const Color(0xFFE8F5E9),
          textColor: const Color(0xFF2E7D32),
        );
      case UserOrderType.direct:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersTypeDirect,
          bgColor: const Color(0xFFE3F2FD),
          textColor: const Color(0xFF1565C0),
        );
      case UserOrderType.readyPieces:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersTypeReady,
          bgColor: const Color(0xFFF3E5F5),
          textColor: const Color(0xFF6A1B9A),
        );
    }
  }

  // ── Inline status pill config ────────────────────────────────────────────────

  _BadgeConfig get _statusBadge {
    switch (order.status) {
      case UserOrderStatus.waitingOffers:
      case UserOrderStatus.hasOffers:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersStatusWaiting,
          bgColor: const Color(0xFFFFF4CE),
          textColor: const Color(0xFF8A6800),
        );
      case UserOrderStatus.inProgress:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersStatusInProgress,
          bgColor: const Color(0xFFDCEEFF),
          textColor: const Color(0xFF1565C0),
        );
      case UserOrderStatus.readyForDelivery:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersStatusReady,
          bgColor: const Color(0xFFE8F5E9),
          textColor: ManagerColors.primaryColor,
        );
      case UserOrderStatus.completed:
        return _BadgeConfig(
          label: ManagerStrings.myOrdersStatusCompleted,
          bgColor: const Color(0xFFF5F5F5),
          textColor: ManagerColors.greyWhiteColor,
        );
    }
  }

  // ── Helpers ──────────────────────────────────────────────────────────────────

  bool get _hasActionButton => order.status == UserOrderStatus.hasOffers;

  bool get _isCustomOrder => order.orderType == UserOrderType.custom;

  bool get _showPiecesInfo =>
      order.orderType == UserOrderType.readyPieces &&
      order.piecesCount != null &&
      order.piecesCount! > 0;

  bool get _showTailorName =>
      !_isCustomOrder &&
      order.confirmedTailorName != null &&
      order.confirmedTailorName!.trim().isNotEmpty;
  // ── Build ─────────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h6,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.07),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(ManagerWidth.w14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Top: content + image ─────────────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // IMAGE — first child → appears on RIGHT in RTL
                  _buildImageStack(),

                  SizedBox(width: ManagerWidth.w12),

                  // CONTENT — Expanded → appears on LEFT in RTL
                  Expanded(child: _buildContent()),
                ],
              ),

              // ── Full-width action button ─────────────────────────────────
              if (_hasActionButton) ...[
                SizedBox(height: ManagerHeight.h10),
                _buildActionButton(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // IMAGE STACK — main image + optional count badge
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildImageStack() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main image
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          child: CachedNetworkImage(
            imageUrl: order.imageUrl,
            width: ManagerWidth.w96,
            height: ManagerHeight.h120,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              width: ManagerWidth.w96,
              height: ManagerHeight.h120,
              color: ManagerColors.greyWhiteColor.withOpacity(0.12),
              child: const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ),
            errorWidget: (_, __, ___) => Container(
              width: ManagerWidth.w96,
              height: ManagerHeight.h120,
              color: ManagerColors.greyWhiteColor.withOpacity(0.10),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                size: 32,
              ),
            ),
          ),
        ),

        // Piece-count badge — top corner
        if (_showPiecesInfo)
          Positioned(
            top: -6,
            left: -6,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: ManagerColors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '${order.piecesCount}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // CONTENT COLUMN — badge, title, bundle section, meta rows
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildContent() {
    final typeConf = _typeConfig;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h5,
            ),
            decoration: BoxDecoration(
              color: typeConf.bgColor,
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
            ),
            child: Text(
              typeConf.label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s11,
                color: typeConf.textColor,
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h8),

        Text(
          order.title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        SizedBox(height: ManagerHeight.h10),

        // ── Bundle piece section ────────────────────────────────────────────
        if (_showPiecesInfo) ...[
          _buildBundleSection(),
          SizedBox(height: ManagerHeight.h8),
        ],

        // ── Price ───────────────────────────────────────────────────────────
        _buildPriceRow(),

        SizedBox(height: ManagerHeight.h8),

        _buildDateAndDeadlineRow(),

        // ── Tailor / shop name ───────────────────────────────────────────────
        if (_showTailorName) ...[
          SizedBox(height: ManagerHeight.h6),
          _MetaRow(
            icon: Icons.person_outline_rounded,
            label: order.confirmedTailorName!,
            color: ManagerColors.greyWhiteColor,
          ),
        ],

        SizedBox(height: ManagerHeight.h12),
        _buildStatusPill(),
      ],
    );
  }

  // ── Bundle strip: grey bg + count label + overlapping mini thumbnails ───────

  Widget _buildBundleSection() {
    if (!_showPiecesInfo) {
      return const SizedBox.shrink();
    }

    final count = order.piecesCount!;
    final thumbCount = count.clamp(1, 3);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
      ),
      child: Row(
        children: [
          // Count label (start = right in RTL)
          Icon(Icons.layers_rounded,
              size: ManagerFontSize.s15, color: ManagerColors.greyWhiteColor),
          SizedBox(width: ManagerWidth.w4),
          Text(
            '$count ${ManagerStrings.myOrdersPiecesLabel}',
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),

          const Spacer(),

          // Overlapping circular thumbnails (end = left in RTL)
          SizedBox(
            height: 36,
            width: thumbCount * 22.0 + 14.0,
            child: Stack(
              clipBehavior: Clip.none,
              children: List.generate(thumbCount, (i) {
                return Positioned(
                  right: i * 20.0,
                  top: 2,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: ManagerColors.white, width: 1.5),
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: order.imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) => Container(
                          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                        ),
                        errorWidget: (_, __, ___) => Container(
                          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ── Price row: ◆ icon + amount + optional average note ────────────────────

  Widget _buildPriceRow() {
    final isBundle = _showPiecesInfo && order.piecesCount! > 1;
    final avgPrice =
        isBundle ? (order.price / order.piecesCount!).round() : null;

    return Wrap(
      spacing: ManagerWidth.w4,
      runSpacing: ManagerHeight.h2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(Icons.diamond_outlined,
            size: ManagerFontSize.s14, color: ManagerColors.primaryColor),
        Text(
          '${order.formattedPrice} ${ManagerStrings.myOrdersCurrency}',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.primaryColor,
          ),
        ),
        if (avgPrice != null) ...[
          Text(
            '(${ManagerStrings.perPiece} $avgPrice ${ManagerStrings.myOrdersCurrency})',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDateAndDeadlineRow() {
    return Wrap(
      spacing: ManagerWidth.w10,
      runSpacing: ManagerHeight.h6,
      children: [
        _MetaTag(
          icon: Icons.calendar_today_rounded,
          label: '${ManagerStrings.myOrdersDateLabel}: ${order.orderDate}',
        ),
        _MetaTag(
          icon: Icons.schedule_rounded,
          label: '${ManagerStrings.myOrdersDeadlineLabel}: ${order.deadline}',
        ),
      ],
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // INLINE STATUS PILL (right-aligned)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildStatusPill() {
    final badge = _statusBadge;

    final IconData icon;
    switch (order.status) {
      case UserOrderStatus.waitingOffers:
      case UserOrderStatus.hasOffers:
        icon = Icons.hourglass_top_rounded;
        break;
      case UserOrderStatus.inProgress:
        icon = Icons.content_cut_rounded;
        break;
      case UserOrderStatus.readyForDelivery:
        icon = Icons.check_circle_outline_rounded;
        break;
      case UserOrderStatus.completed:
        icon = Icons.done_all_rounded;
        break;
    }

    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w12,
          vertical: ManagerHeight.h5,
        ),
        decoration: BoxDecoration(
          color: badge.bgColor,
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: ManagerFontSize.s13, color: badge.textColor),
            SizedBox(width: ManagerWidth.w5),
            Text(
              badge.label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: badge.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ══════════════════════════════════════════════════════════════════════════════
  // FULL-WIDTH ACTION BUTTON (hasOffers & readyForDelivery only)
  // ══════════════════════════════════════════════════════════════════════════════

  Widget _buildActionButton() {
    final String label;
    final IconData icon;

    if (order.status == UserOrderStatus.hasOffers) {
      label =
          '${ManagerStrings.myOrdersStatusHasOffers} (${order.offersCount ?? 0})';
      icon = Icons.remove_red_eye;
    } else {
      label = ManagerStrings.myOrdersStatusReady;
      icon = Icons.local_shipping_rounded;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: ManagerHeight.h32,
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor,
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: ManagerFontSize.s17, color: ManagerColors.white),
            SizedBox(width: ManagerWidth.w8),
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Shared sub-widgets
// ══════════════════════════════════════════════════════════════════════════════

/// Config for a colored badge / pill.
class _BadgeConfig {
  final String label;
  final Color bgColor;
  final Color textColor;

  const _BadgeConfig({
    required this.label,
    required this.bgColor,
    required this.textColor,
  });
}

/// Icon + label meta row (price, date, tailor name…).
class _MetaRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool bold = false;

  const _MetaRow({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(icon, size: ManagerFontSize.s14, color: color),
        SizedBox(width: ManagerWidth.w5),
        Expanded(
          child: Text(
            label,
            style: bold
                ? getBoldTextStyle(fontSize: ManagerFontSize.s13, color: color)
                : getRegularTextStyle(
                    fontSize: ManagerFontSize.s12, color: color),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _MetaTag extends StatelessWidget {
  final IconData icon;
  final String label;

  const _MetaTag({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(width: ManagerWidth.w4),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 160),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
