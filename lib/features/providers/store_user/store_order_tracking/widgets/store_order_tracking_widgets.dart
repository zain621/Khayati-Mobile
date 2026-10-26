import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../domain/model/shop_owner_order_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Internal helpers
// ─────────────────────────────────────────────────────────────────────────────

String _formatDate(String isoDate) {
  try {
    final dt = DateTime.parse(isoDate).toLocal();
    final y  = dt.year;
    final mo = dt.month.toString().padLeft(2, '0');
    final d  = dt.day.toString().padLeft(2, '0');
    final h  = dt.hour.toString().padLeft(2, '0');
    final mi = dt.minute.toString().padLeft(2, '0');
    return '$y-$mo-$d  $h:$mi';
  } catch (_) {
    return isoDate;
  }
}

class _StageStyle {
  final String label;
  final Color background;
  final Color textColor;

  const _StageStyle({
    required this.label,
    required this.background,
    required this.textColor,
  });
}

_StageStyle _stageStyleFor(ShopOrderCurrentStage stage) {
  switch (stage) {
    case ShopOrderCurrentStage.newOrder:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusNew,
        background: const Color(0xFFE3F2FD),
        textColor: const Color(0xFF1565C0),
      );
    case ShopOrderCurrentStage.inPreparation:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusInPrep,
        background: const Color(0xFFFFF3E0),
        textColor: const Color(0xFFE65100),
      );
    case ShopOrderCurrentStage.readyToShip:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusReady,
        background: const Color(0xFFE8F5E9),
        textColor: const Color(0xFF2E7D32),
      );
    case ShopOrderCurrentStage.shipped:
      return _StageStyle(
        label: ManagerStrings.storeOrderActionMarkReady,
        background: const Color(0xFFE0F2F1),
        textColor: const Color(0xFF00695C),
      );
    case ShopOrderCurrentStage.inDelivery:
      return _StageStyle(
        label: ManagerStrings.storeOrderAllCompleted,
        background: const Color(0xFFEDE7F6),
        textColor: const Color(0xFF4527A0),
      );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STORE ORDER CARD
// ─────────────────────────────────────────────────────────────────────────────

/// A card in the order tracking list for the store tailor.
class StoreOrderCard extends StatelessWidget {
  final ShopOwnerOrderModel order;
  final VoidCallback onViewDetails;
  final VoidCallback onCall;
  final VoidCallback onPrimaryAction;
  final bool isUpdatingStage;

  const StoreOrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
    required this.onCall,
    required this.onPrimaryAction,
    this.isUpdatingStage = false,
  });

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final style     = _stageStyleFor(order.currentStage);
    final nextLabel = order.nextStageLabel;
    final allDone   = nextLabel == null;

    return Container(
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
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(style),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: ManagerHeight.h10),
                _buildItemsList(),
                SizedBox(height: ManagerHeight.h10),
                _buildDateTotalRow(),
                SizedBox(height: ManagerHeight.h10),
                _buildActionsRow(context, nextLabel, allDone),
                SizedBox(height: ManagerHeight.h12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Header: customer avatar + name + order number + status badge ──────────

  Widget _buildHeader(_StageStyle style) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: style.background.withOpacity(0.45),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r16),
        ),
      ),
      child: Row(
        children: [
          _BuyerAvatar(imageUrl: order.buyer.imageUrl, radius: ManagerWidth.w22),
          SizedBox(width: ManagerWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.buyer.fullName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h2),
                Text(
                  order.orderNumber,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w10,
              vertical: ManagerHeight.h4,
            ),
            decoration: BoxDecoration(
              color: style.background,
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
              border: Border.all(color: style.textColor.withOpacity(0.3)),
            ),
            child: Text(
              style.label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s11,
                color: style.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Items list (max 2 shown) ──────────────────────────────────────────────

  Widget _buildItemsList() {
    final displayItems =
        order.items.length > 2 ? order.items.sublist(0, 2) : order.items;
    return Column(
      children: displayItems.map((item) => _buildItemRow(item)).toList(),
    );
  }

  Widget _buildItemRow(ShopOrderItemModel item) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h4),
                Wrap(
                  spacing: ManagerWidth.w6,
                  runSpacing: ManagerHeight.h4,
                  children: [
                    _InfoChip(label: item.size),
                    _InfoChip(label: item.color),
                    _InfoChip(
                        label:
                            '${ManagerStrings.storeOrderQuantity} ${item.quantity}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          Text(
            item.formattedTotalPrice,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Date + Total row ──────────────────────────────────────────────────────

  Widget _buildDateTotalRow() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ManagerStrings.storeOrderDate,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            Text(
              _formatDate(order.createdAt),
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.black,
              ),
            ),
          ],
        ),

        const Spacer(),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              ManagerStrings.storeOrderTotalLabel,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            Text(
              order.formattedTotal,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Action row ────────────────────────────────────────────────────────────

  Widget _buildActionsRow(
      BuildContext context, String? nextLabel, bool allDone) {
    return Row(
      children: [
        SizedBox(
          height: ManagerHeight.h40,
          child: OutlinedButton.icon(
            onPressed: onViewDetails,
            icon: Icon(
              Icons.receipt_long_outlined,
              size: ManagerFontSize.s14,
              color: ManagerColors.primaryColor,
            ),
            label: Text(
              ManagerStrings.storeOrderViewDetails,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: ManagerColors.primaryColor.withOpacity(0.4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w10),
            ),
          ),
        ),

        SizedBox(width: ManagerWidth.w10),

        Expanded(
          child: SizedBox(
            height: ManagerHeight.h40,
            child: ElevatedButton(
              onPressed: allDone || isUpdatingStage ? null : onPrimaryAction,
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor,
                disabledBackgroundColor:
                    ManagerColors.primaryColor.withOpacity(0.35),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                ),
                elevation: 0,
              ),
              child: isUpdatingStage
                  ? SizedBox(
                      width: ManagerWidth.w18,
                      height: ManagerHeight.h18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          ManagerColors.white.withOpacity(0.8),
                        ),
                      ),
                    )
                  : Text(
                      allDone
                          ? ManagerStrings.storeOrderAllCompleted
                          : nextLabel ?? '',
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.white,
                      ),
                    ),
            ),
          ),
        ),

        SizedBox(width: ManagerWidth.w10),

        _CircleIconButton(icon: Icons.phone_outlined, onTap: onCall),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// STORE ORDER DETAIL BOTTOM SHEET
// ─────────────────────────────────────────────────────────────────────────────

/// Bottom sheet showing full order details + status update action.
class StoreOrderDetailSheet extends StatelessWidget {
  final ShopOwnerOrderModel order;
  final VoidCallback? onUpdateStatus;
  final VoidCallback? onCall;
  final VoidCallback? onChat;
  final bool isUpdatingStage;

  const StoreOrderDetailSheet({
    super.key,
    required this.order,
    this.onUpdateStatus,
    this.onCall,
    this.onChat,
    this.isUpdatingStage = false,
  });

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final nextLabel  = order.nextStageLabel;

    return Directionality(
      textDirection: Directionality.of(context),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        snap: true,
        expand: false,
        builder: (_, scrollCtrl) => SafeArea(
          top: false,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ManagerRadius.r20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildSheetHeader(context),
                Divider(height: 1, color: Colors.grey.shade100),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollCtrl,
                    padding: EdgeInsets.fromLTRB(
                      ManagerWidth.w20,
                      ManagerHeight.h16,
                      ManagerWidth.w20,
                      ManagerHeight.h20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildCustomerSection(),
                        SizedBox(height: ManagerHeight.h16),
                        _buildProductsSection(),
                        SizedBox(height: ManagerHeight.h16),
                        _buildTotalAndPaymentRow(),
                        SizedBox(height: ManagerHeight.h16),
                        _buildStagesSection(),
                        SizedBox(height: ManagerHeight.h24),
                        if (nextLabel != null) ...[
                          _buildUpdateStatusButton(nextLabel),
                          SizedBox(height: ManagerHeight.h10),
                        ],
                        _buildChatButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Sheet header: drag handle + title row + order number ─────────────────

  Widget _buildSheetHeader(BuildContext context) {
    final style = _stageStyleFor(order.currentStage);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            margin: EdgeInsets.only(
                top: ManagerHeight.h10, bottom: ManagerHeight.h8),
            width: ManagerWidth.w40,
            height: ManagerHeight.h4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
          ),
        ),
        // Title row
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16, vertical: ManagerHeight.h8),
          child: Row(
            children: [
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w10,
                  vertical: ManagerHeight.h4,
                ),
                decoration: BoxDecoration(
                  color: style.background,
                  borderRadius: BorderRadius.circular(ManagerRadius.r20),
                  border:
                      Border.all(color: style.textColor.withOpacity(0.3)),
                ),
                child: Text(
                  style.label,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: style.textColor,
                  ),
                ),
              ),
              const Spacer(),
              // Title
              Text(
                ManagerStrings.storeOrderDetailTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              const Spacer(),
              // Close
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: ManagerWidth.w32,
                  height: ManagerHeight.h32,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close_rounded,
                      size: ManagerFontSize.s18,
                      color: ManagerColors.greyWhiteColor),
                ),
              ),
            ],
          ),
        ),
        // Order ID + date row
        Padding(
          padding: EdgeInsets.only(
            right: ManagerWidth.w16,
            left: ManagerWidth.w16,
            bottom: ManagerHeight.h10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                order.orderNumber,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
              ),
              Text(
                _formatDate(order.createdAt),
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Customer section ──────────────────────────────────────────────────────

  Widget _buildCustomerSection() {
    return _SectionCard(
      title: ManagerStrings.storeOrderCustomerSection,
      titleIcon: Icons.person_outline_rounded,
      child: Row(
        children: [
          _BuyerAvatar(imageUrl: order.buyer.imageUrl, radius: ManagerWidth.w24),
          SizedBox(width: ManagerWidth.w12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.buyer.fullName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(height: ManagerHeight.h2),
                Text(
                  order.buyer.phoneNumber,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onCall,
            child: Container(
              padding: EdgeInsets.all(ManagerWidth.w10),
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.phone_outlined,
                color: ManagerColors.primaryColor,
                size: ManagerFontSize.s20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Products section ──────────────────────────────────────────────────────

  Widget _buildProductsSection() {
    return _SectionCard(
      title: ManagerStrings.storeOrderProductsSection,
      titleIcon: Icons.shopping_bag_outlined,
      child: Column(
        children: List.generate(order.items.length, (i) {
          final item   = order.items[i];
          final isLast = i == order.items.length - 1;
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.productName,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h6),
                        Wrap(
                          spacing: ManagerWidth.w6,
                          runSpacing: ManagerHeight.h4,
                          children: [
                            _InfoChip(label: item.size),
                            _InfoChip(label: item.color),
                            _InfoChip(
                                label:
                                    '${ManagerStrings.storeOrderQuantity} ${item.quantity}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        item.formattedTotalPrice,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h2),
                      Text(
                        item.formattedUnitPrice,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (!isLast) ...[
                SizedBox(height: ManagerHeight.h10),
                Divider(color: Colors.grey.shade100, height: 1),
                SizedBox(height: ManagerHeight.h10),
              ],
            ],
          );
        }),
      ),
    );
  }

  // ── Total + payment row ──────────────────────────────────────────────────

  Widget _buildTotalAndPaymentRow() {
    final paymentLabel = order.isPaid
        ? ManagerStrings.storeOrderPaymentPaid
        : ManagerStrings.storeOrderPaymentUnpaid;
    final paymentColor = order.isPaid
        ? const Color(0xFF2E7D32)
        : const Color(0xFFE65100);
    final paymentBg = order.isPaid
        ? const Color(0xFFE8F5E9)
        : const Color(0xFFFFF3E0);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h14,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
            color: ManagerColors.primaryColor.withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            color: ManagerColors.primaryColor,
            size: ManagerFontSize.s18,
          ),
          SizedBox(width: ManagerWidth.w8),
          Text(
            ManagerStrings.storeOrderTotalLabel,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
          ),
          const Spacer(),
          Container(
            margin: EdgeInsetsDirectional.only(end: ManagerWidth.w10),
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h3,
            ),
            decoration: BoxDecoration(
              color: paymentBg,
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
            ),
            child: Text(
              paymentLabel,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s10,
                color: paymentColor,
              ),
            ),
          ),
          Text(
            order.formattedTotal,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s18,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Stages section ────────────────────────────────────────────────────────

  Widget _buildStagesSection() {
    return _SectionCard(
      title: ManagerStrings.storeOrderStagesSection,
      titleIcon: Icons.timeline_outlined,
      child: Column(
        children: List.generate(order.stages.length, (i) {
          final stage  = order.stages[i];
          final isLast = i == order.stages.length - 1;
          return _StageRow(stage: stage, isLast: isLast);
        }),
      ),
    );
  }

  // ── Update status button ──────────────────────────────────────────────────

  Widget _buildUpdateStatusButton(String nextLabel) {
    return SizedBox(
      width: double.infinity,
      height: ManagerHeight.h52,
      child: ElevatedButton(
        onPressed: isUpdatingStage ? null : onUpdateStatus,
        style: ElevatedButton.styleFrom(
          backgroundColor: ManagerColors.primaryColor,
          disabledBackgroundColor:
              ManagerColors.primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r14),
          ),
          elevation: 0,
        ),
        child: isUpdatingStage
            ? SizedBox(
                width: ManagerWidth.w22,
                height: ManagerHeight.h22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      ManagerColors.white.withOpacity(0.8)),
                ),
              )
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${ManagerStrings.storeOrderUpdateStatusTo} ',
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.white,
                      ),
                    ),
                    TextSpan(
                      text: nextLabel,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.white,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  // ── Chat button ───────────────────────────────────────────────────────────

  Widget _buildChatButton() {
    return SizedBox(
      width: double.infinity,
      height: ManagerHeight.h52,
      child: OutlinedButton.icon(
        onPressed: onChat,
        icon: Icon(
          Icons.chat_bubble_outline_rounded,
          size: ManagerFontSize.s18,
          color: ManagerColors.primaryColor,
        ),
        label: Text(
          ManagerStrings.storeOrderChat,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.primaryColor,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: ManagerColors.primaryColor.withOpacity(0.4)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r14),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PRIVATE SHARED WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

/// Small pill-shaped info chip (color / size / quantity).
class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Text(
        label,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s10,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

/// Circular icon button (phone).
class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w40,
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: ManagerColors.primaryColor.withOpacity(0.35)),
          color: ManagerColors.primaryColor.withOpacity(0.06),
        ),
        child: Icon(
          icon,
          color: ManagerColors.primaryColor,
          size: ManagerFontSize.s20,
        ),
      ),
    );
  }
}

/// Titled section card used in the detail sheet.
class _SectionCard extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.titleIcon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section title
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                titleIcon,
                size: ManagerFontSize.s16,
                color: ManagerColors.primaryColor,
              ),
              SizedBox(width: ManagerWidth.w6),
              Text(
                title,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h12),
          child,
        ],
      ),
    );
  }
}

/// Buyer/customer avatar with network image fallback.
class _BuyerAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const _BuyerAvatar({required this.imageUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: ManagerColors.primaryColor.withOpacity(0.08),
        backgroundImage: CachedNetworkImageProvider(imageUrl!),
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: ManagerColors.primaryColor.withOpacity(0.1),
      child: Icon(
        Icons.person,
        color: ManagerColors.primaryColor,
        size: radius,
      ),
    );
  }
}

/// Single stage row used in the stages timeline section.
class _StageRow extends StatelessWidget {
  final ShopOrderStageModel stage;
  final bool isLast;

  const _StageRow({required this.stage, required this.isLast});

  @override
  Widget build(BuildContext context) {
    final completed  = stage.completed;
    final lineColor  = completed ? ManagerColors.primaryColor : Colors.grey.shade200;
    final labelColor = completed ? ManagerColors.black : ManagerColors.greyWhiteColor;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: ManagerWidth.w24,
            child: Column(
              children: [
                Container(
                  width: ManagerWidth.w20,
                  height: ManagerHeight.h20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: completed
                        ? ManagerColors.primaryColor
                        : Colors.grey.shade200,
                  ),
                  child: Icon(
                    completed ? Icons.check : Icons.radio_button_unchecked,
                    size: ManagerFontSize.s12,
                    color: completed ? ManagerColors.white : Colors.grey.shade400,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 2, color: lineColor),
                  ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : ManagerHeight.h14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    stage.label,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: labelColor,
                    ),
                  ),
                  if (stage.statusDate != null) ...[
                    SizedBox(height: ManagerHeight.h2),
                    Text(
                      _formatDate(stage.statusDate!),
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s11,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHIMMER WIDGET
// ─────────────────────────────────────────────────────────────────────────────

class StoreOrderTrackingShimmer extends StatelessWidget {
  const StoreOrderTrackingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.25),
      highlightColor: ManagerColors.white,
      child: Column(
        children: [
          _buildHeaderShimmer(),
          Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
              itemCount: 4,
              separatorBuilder: (_, __) => SizedBox(height: ManagerHeight.h8),
              itemBuilder: (_, __) => _buildCardShimmer(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderShimmer() {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
          top: ManagerHeight.h16, bottom: ManagerHeight.h12),
      child: Column(
        children: [
          Center(
            child: Container(
              width: ManagerWidth.w150,
              height: ManagerHeight.h20,
              decoration: BoxDecoration(
                color: ManagerColors.white.withOpacity(0.35),
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
              ),
            ),
          ),
          SizedBox(height: ManagerHeight.h12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsetsDirectional.only(
                start: ManagerWidth.w16, end: ManagerWidth.w16),
            child: Row(
              children: List.generate(
                4,
                (i) => Padding(
                  padding: EdgeInsetsDirectional.only(end: ManagerWidth.w8),
                  child: Container(
                    width: ManagerWidth.w80,
                    height: ManagerHeight.h32,
                    decoration: BoxDecoration(
                      color: ManagerColors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(ManagerRadius.r24),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
        ],
      ),
    );
  }

  Widget _buildCardShimmer() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(w: 44, h: 44, radius: 22),
              SizedBox(width: ManagerWidth.w10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _shimmerBox(w: 120, h: 14),
                  SizedBox(height: ManagerHeight.h6),
                  _shimmerBox(w: 80, h: 11),
                ],
              ),
              const Spacer(),
              _shimmerBox(w: 70, h: 24, radius: 12),
            ],
          ),
          SizedBox(height: ManagerHeight.h14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(w: 140, h: 13),
                    SizedBox(height: ManagerHeight.h8),
                    Row(
                      children: [
                        _shimmerBox(w: 40, h: 20, radius: 10),
                        SizedBox(width: ManagerWidth.w6),
                        _shimmerBox(w: 50, h: 20, radius: 10),
                      ],
                    ),
                  ],
                ),
              ),
              _shimmerBox(w: 54, h: 18),
            ],
          ),
          SizedBox(height: ManagerHeight.h14),
          Row(
            children: [
              _shimmerBox(w: 90, h: 28),
              const Spacer(),
              _shimmerBox(w: 70, h: 28),
            ],
          ),
          SizedBox(height: ManagerHeight.h12),
          Row(
            children: [
              _shimmerBox(w: 100, h: 36, radius: ManagerRadius.r10),
              SizedBox(width: ManagerWidth.w10),
              Expanded(child: _shimmerBox(h: 36, radius: ManagerRadius.r10)),
              SizedBox(width: ManagerWidth.w10),
              _shimmerBox(w: 40, h: 40, radius: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({double? w, double h = 14, double? radius}) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(radius ?? ManagerRadius.r6),
      ),
    );
  }
}