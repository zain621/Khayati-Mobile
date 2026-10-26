import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/domain/model/comprehensive_order_tracking_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Internal helpers
// ─────────────────────────────────────────────────────────────────────────────

String _formatDate(String isoDate) {
  try {
    final dt = DateTime.parse(isoDate).toLocal();
    final y = dt.year;
    final mo = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
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
  const _StageStyle(
      {required this.label, required this.background, required this.textColor});
}

_StageStyle _stageStyleForCT(ComprehensiveShopOrderStage stage) {
  switch (stage) {
    case ComprehensiveShopOrderStage.newOrder:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusNew,
        background: const Color(0xFFE3F2FD),
        textColor: const Color(0xFF1565C0),
      );
    case ComprehensiveShopOrderStage.inPreparation:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusInPrep,
        background: const Color(0xFFFFF3E0),
        textColor: const Color(0xFFE65100),
      );
    case ComprehensiveShopOrderStage.readyToShip:
      return _StageStyle(
        label: ManagerStrings.storeOrderStatusReady,
        background: const Color(0xFFE8F5E9),
        textColor: const Color(0xFF2E7D32),
      );
    case ComprehensiveShopOrderStage.shipped:
      return _StageStyle(
        label: ManagerStrings.storeOrderActionMarkReady,
        background: const Color(0xFFE0F2F1),
        textColor: const Color(0xFF00695C),
      );
    case ComprehensiveShopOrderStage.inDelivery:
      return _StageStyle(
        label: ManagerStrings.storeOrderAllCompleted,
        background: const Color(0xFFEDE7F6),
        textColor: const Color(0xFF4527A0),
      );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPREHENSIVE SHOP ORDER CARD
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveShopOrderCard extends StatelessWidget {
  final ComprehensiveShopOrderModel order;
  final VoidCallback onViewDetails;
  final VoidCallback? onChat;
  final VoidCallback onCall;
  final VoidCallback onPrimaryAction;
  final bool isUpdatingStage;

  const ComprehensiveShopOrderCard({
    super.key,
    required this.order,
    required this.onViewDetails,
    this.onChat,
    required this.onCall,
    required this.onPrimaryAction,
    this.isUpdatingStage = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = _stageStyleForCT(order.currentStage);
    final nextLabel = order.nextStageLabel;
    final allDone = nextLabel == null;

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
          _AvatarWidget(
              imageUrl: order.buyer.imageUrl, radius: ManagerWidth.w22),
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

  Widget _buildItemsList() {
    final displayItems =
        order.items.length > 2 ? order.items.sublist(0, 2) : order.items;
    return Column(
      children: displayItems.map((item) => _buildItemRow(item)).toList(),
    );
  }

  Widget _buildItemRow(ComprehensiveShopItemModel item) {
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

  Widget _buildActionsRow(
      BuildContext context, String? nextLabel, bool allDone) {
    return Row(
      children: [
        // Chat icon button
        SizedBox(
          height: ManagerHeight.h44,
          width: ManagerWidth.w44,
          child: OutlinedButton(
            onPressed: onChat,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: ManagerColors.primaryColor.withOpacity(0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: ManagerFontSize.s18,
              color: ManagerColors.primaryColor,
            ),
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        // View Details button
        SizedBox(
          height: ManagerHeight.h44,
          child: OutlinedButton.icon(
            onPressed: onViewDetails,
            icon: Icon(
              Icons.receipt_long_outlined,
              size: ManagerFontSize.s14,
              color: ManagerColors.primaryColor,
            ),
            label: Text(
              ManagerStrings.orderTrackingDetails,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: ManagerColors.primaryColor.withOpacity(0.3),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w10),
            ),
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        // Update Stage button (Primary action)
        Expanded(
          child: SizedBox(
            height: ManagerHeight.h44,
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
                          ? ManagerStrings.ctOrderZoqakCompleted
                          : (nextLabel ?? ManagerStrings.ctOrderZoqakContinue),
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPREHENSIVE SHOP ORDER DETAIL SHEET
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveShopOrderDetailSheet extends StatelessWidget {
  final ComprehensiveShopOrderModel order;
  final VoidCallback? onUpdateStatus;
  final VoidCallback? onCall;
  final VoidCallback? onChat;
  final bool isUpdatingStage;

  const ComprehensiveShopOrderDetailSheet({
    super.key,
    required this.order,
    this.onUpdateStatus,
    this.onCall,
    this.onChat,
    this.isUpdatingStage = false,
  });

  @override
  Widget build(BuildContext context) {
    final nextLabel = order.nextStageLabel;
    final style = _stageStyleForCT(order.currentStage);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r20),
          ),
        ),
        child: Column(
          children: [
            // ── Drag handle ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(top: ManagerHeight.h12),
              child: Container(
                width: ManagerWidth.w40,
                height: ManagerHeight.h4,
                decoration: BoxDecoration(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(ManagerRadius.r4),
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h16),

            // ── Buyer info + status badge ──────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: Row(
                children: [
                  _AvatarWidget(
                    imageUrl: order.buyer.imageUrl,
                    radius: ManagerWidth.w26,
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.buyer.fullName,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h2),
                        Text(
                          order.orderNumber,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w10,
                      vertical: ManagerHeight.h5,
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
                        fontSize: ManagerFontSize.s12,
                        color: style.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h14),

            // ── Contact buttons ────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: Row(
                children: [
                  // Phone — icon-only square button
                  SizedBox(
                    height: ManagerHeight.h48,
                    width: ManagerWidth.w48,
                    child: OutlinedButton(
                      onPressed: onCall,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: ManagerColors.primaryColor.withOpacity(0.3),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Icon(
                        Icons.phone_outlined,
                        color: ManagerColors.primaryColor,
                        size: ManagerFontSize.s22,
                      ),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w10),
                  // Chat — full-width labeled button
                  Expanded(
                    child: SizedBox(
                      height: ManagerHeight.h48,
                      child: OutlinedButton.icon(
                        onPressed: onChat,
                        icon: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: ManagerFontSize.s18,
                          color: ManagerColors.primaryColor,
                        ),
                        label: Text(
                          ManagerStrings.ctOrderShopChat,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.primaryColor,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: ManagerColors.primaryColor.withOpacity(0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h12),
            const Divider(height: 1),

            // ── Scrollable content ─────────────────────────────────────
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h16,
                ),
                children: [
                  // Order info card
                  _OrderInfoCard(order: order),
                  SizedBox(height: ManagerHeight.h20),

                  // Products section
                  _SectionHeader(
                    title: ManagerStrings.storeOrderProductsSection,
                    count: order.items.length,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  ...order.items.map((item) => _DetailItemRow(item: item)),
                  SizedBox(height: ManagerHeight.h20),

                  // Stages section
                  _SectionHeader(
                    title: ManagerStrings.storeOrderStagesSection,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  ...order.stages.map((s) => _StageRow(stage: s)),
                  SizedBox(height: ManagerHeight.h80),
                ],
              ),
            ),

            // ── Primary action button ──────────────────────────────────
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h14,
                ),
                child: SizedBox(
                  height: ManagerHeight.h52,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: nextLabel == null || isUpdatingStage
                        ? null
                        : onUpdateStatus,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ManagerColors.primaryColor,
                      disabledBackgroundColor:
                          ManagerColors.primaryColor.withOpacity(0.35),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ManagerRadius.r12),
                      ),
                      elevation: 0,
                    ),
                    child: isUpdatingStage
                        ? const CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          )
                        : Text(
                            nextLabel ?? ManagerStrings.ctOrderZoqakCompleted,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s15,
                              color: ManagerColors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPREHENSIVE ZOQAK ORDER DETAIL SHEET
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveZoqakOrderDetailSheet extends StatelessWidget {
  final ComprehensiveZoqakOrderModel order;
  final VoidCallback? onChat;

  const ComprehensiveZoqakOrderDetailSheet({
    super.key,
    required this.order,
    this.onChat,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _zoqakStatusConfig(order.status);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r20),
          ),
        ),
        child: Column(
          children: [
            // ── Drag handle ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(top: ManagerHeight.h12),
              child: Container(
                width: ManagerWidth.w40,
                height: ManagerHeight.h4,
                decoration: BoxDecoration(
                  color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(ManagerRadius.r4),
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h16),

            // ── User info + status badge ───────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: Row(
                children: [
                  _AvatarWidget(
                    imageUrl: order.userImage,
                    radius: ManagerWidth.w26,
                  ),
                  SizedBox(width: ManagerWidth.w12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.userName,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.black,
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h2),
                        Text(
                          order.orderNumber,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w10,
                      vertical: ManagerHeight.h5,
                    ),
                    decoration: BoxDecoration(
                      color: statusConfig.background,
                      borderRadius: BorderRadius.circular(ManagerRadius.r20),
                      border: Border.all(
                        color: statusConfig.textColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      statusConfig.label,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: statusConfig.textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h14),

            // ── Chat button ────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: SizedBox(
                height: ManagerHeight.h48,
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: onChat,
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: ManagerFontSize.s18,
                    color: ManagerColors.primaryColor,
                  ),
                  label: Text(
                    ManagerStrings.ctOrderZoqakChatWithClient,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: ManagerColors.primaryColor.withOpacity(0.3),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h12),
            const Divider(height: 1),

            // ── Scrollable content ─────────────────────────────────────
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h16,
                ),
                children: [
                  // Info card (date, budget, delivery)
                  _ZoqakInfoCard(order: order),
                  SizedBox(height: ManagerHeight.h20),

                  // Request details section
                  _SectionHeader(
                    title: ManagerStrings.orderDetailsZoqakRequestTitle,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  _DetailRow(
                    label: ManagerStrings.orderDetailsZoqakProductNameLabel,
                    value: order.productName,
                  ),
                  if (order.fabricType != null &&
                      order.fabricType!.isNotEmpty) ...[
                    SizedBox(height: ManagerHeight.h8),
                    _DetailRow(
                      label: ManagerStrings.orderDetailsFabricLabel,
                      value: order.fabricType!,
                    ),
                  ],
                  if (order.description != null &&
                      order.description!.isNotEmpty) ...[
                    SizedBox(height: ManagerHeight.h8),
                    _LabeledText(
                      label: ManagerStrings.orderDetailsDescriptionLabel,
                      value: order.description!,
                    ),
                  ],
                  if (order.specialRequests != null &&
                      order.specialRequests!.isNotEmpty) ...[
                    SizedBox(height: ManagerHeight.h8),
                    _LabeledText(
                      label: ManagerStrings.orderDetailSpecialRequests,
                      value: order.specialRequests!,
                    ),
                  ],

                  // Similar images section
                  if (order.similarImages.isNotEmpty) ...[
                    SizedBox(height: ManagerHeight.h20),
                    _SectionHeader(
                      title: ManagerStrings.orderDetailsZoqakImagesTitle,
                      count: order.similarImages.length,
                    ),
                    SizedBox(height: ManagerHeight.h10),
                    _SimilarImagesRow(images: order.similarImages),
                  ],

                  SizedBox(height: ManagerHeight.h80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// COMPREHENSIVE ZOQAK ORDER CARD
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveZoqakOrderCard extends StatelessWidget {
  final ComprehensiveZoqakOrderModel order;
  final VoidCallback? onChat;
  final VoidCallback? onViewOffer;
  final VoidCallback? onUpdateStatus;
  final String? statusActionLabel;
  final bool isUpdatingStatus;

  const ComprehensiveZoqakOrderCard({
    super.key,
    required this.order,
    this.onChat,
    this.onViewOffer,
    this.onUpdateStatus,
    this.statusActionLabel,
    this.isUpdatingStatus = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _zoqakStatusConfig(order.status);
    final actionLabel = statusActionLabel;

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
            blurRadius: 18,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Client header ─────────────────────────────────────────────
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w14,
              vertical: ManagerHeight.h12,
            ),
            decoration: BoxDecoration(
              color: statusConfig.background.withOpacity(0.35),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ManagerRadius.r16),
              ),
            ),
            child: Row(
              children: [
                _AvatarWidget(
                    imageUrl: order.userImage, radius: ManagerWidth.w22),
                SizedBox(width: ManagerWidth.w10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.userName,
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
                    color: statusConfig.background,
                    borderRadius: BorderRadius.circular(ManagerRadius.r20),
                    border: Border.all(
                      color: statusConfig.textColor.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    statusConfig.label,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: statusConfig.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Order body ───────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(ManagerWidth.w14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product name (prominent)
                Text(
                  order.productName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s15,
                    color: ManagerColors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h10),

                // Budget + Delivery date row
                Row(
                  children: [
                    Icon(
                      Icons.attach_money_rounded,
                      size: ManagerFontSize.s15,
                      color: ManagerColors.primaryColor,
                    ),
                    SizedBox(width: ManagerWidth.w4),
                    Expanded(
                      child: Text(
                        order.budgetRange,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (order.deliveryDate != null &&
                        order.deliveryDate!.isNotEmpty) ...[
                      SizedBox(width: ManagerWidth.w8),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      SizedBox(width: ManagerWidth.w4),
                      Flexible(
                        child: Text(
                          order.deliveryDate!,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s11,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ],
                ),

                // Fabric type chip
                if (order.fabricType != null &&
                    order.fabricType!.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h8),
                  Row(
                    children: [
                      Icon(
                        Icons.texture_rounded,
                        size: ManagerFontSize.s13,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      SizedBox(width: ManagerWidth.w6),
                      Flexible(
                        child: Text(
                          order.fabricType!,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],

                // Description preview (2 lines)
                if (order.description != null &&
                    order.description!.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: ManagerHeight.h2),
                        child: Icon(
                          Icons.description_outlined,
                          size: ManagerFontSize.s13,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w6),
                      Expanded(
                        child: Text(
                          order.description!,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],

                // Similar images strip
                if (order.similarImages.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h10),
                  SizedBox(
                    height: ManagerHeight.h72,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: order.similarImages.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: ManagerWidth.w6),
                      itemBuilder: (_, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                        child: CachedNetworkImage(
                          imageUrl: order.similarImages[i],
                          width: ManagerWidth.w72,
                          height: ManagerHeight.h72,
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) => Container(
                            width: ManagerWidth.w72,
                            height: ManagerHeight.h72,
                            decoration: BoxDecoration(
                              color: ManagerColors.greyWhiteColor
                                  .withOpacity(0.1),
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r8),
                            ),
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              size: ManagerFontSize.s20,
                              color: ManagerColors.greyWhiteColor
                                  .withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                // Divider
                SizedBox(height: ManagerHeight.h10),
                Divider(
                  height: 1,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                ),
                SizedBox(height: ManagerHeight.h10),

                // Bottom actions row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Offers count badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w10,
                        vertical: ManagerHeight.h4,
                      ),
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.format_list_bulleted_rounded,
                            size: ManagerFontSize.s13,
                            color: ManagerColors.primaryColor,
                          ),
                          SizedBox(width: ManagerWidth.w4),
                          Text(
                            '${order.offersCount}',
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s13,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),

                    // Status action button
                    if (onUpdateStatus != null && actionLabel != null) ...[
                      SizedBox(
                        height: ManagerHeight.h40,
                        child: ElevatedButton.icon(
                          onPressed: isUpdatingStatus ? null : onUpdateStatus,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ManagerColors.secondaryColor,
                            disabledBackgroundColor:
                                ManagerColors.secondaryColor.withOpacity(0.35),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w10),
                            elevation: 0,
                          ),
                          icon: isUpdatingStatus
                              ? SizedBox(
                                  width: ManagerWidth.w14,
                                  height: ManagerHeight.h14,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.sync_rounded,
                                  size: ManagerFontSize.s15,
                                  color: ManagerColors.white,
                                ),
                          label: Text(
                            actionLabel,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w8),
                    ],

                    // Your offer button
                    if (onViewOffer != null) ...[
                      SizedBox(
                        height: ManagerHeight.h40,
                        child: ElevatedButton(
                          onPressed: onViewOffer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ManagerColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(ManagerRadius.r10),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w12),
                            elevation: 0,
                          ),
                          child: Text(
                            ManagerStrings.ctOrderZoqakYourOffer,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w8),
                    ],

                    // Chat icon button
                    SizedBox(
                      height: ManagerHeight.h40,
                      width: ManagerWidth.w40,
                      child: OutlinedButton(
                        onPressed: onChat,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: ManagerColors.primaryColor.withOpacity(0.35),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r10),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: ManagerFontSize.s17,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SHIMMER
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveOrderTrackingShimmer extends StatelessWidget {
  const ComprehensiveOrderTrackingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.15),
      highlightColor: ManagerColors.greyWhiteColor.withOpacity(0.05),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
        itemCount: 4,
        itemBuilder: (_, __) => Container(
          height: ManagerHeight.h140,
          margin: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16,
            vertical: ManagerHeight.h6,
          ),
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r16),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Private helpers
// ─────────────────────────────────────────────────────────────────────────────

class _OrderInfoCard extends StatelessWidget {
  final ComprehensiveShopOrderModel order;

  const _OrderInfoCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h14,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          _DetailRow(
            label: ManagerStrings.storeOrderDate,
            value: _formatDate(order.createdAt),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
            child: Divider(
              height: 1,
              color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            ),
          ),
          _DetailRow(
            label: ManagerStrings.storeOrderPaymentStatusLabel,
            value: order.isPaid
                ? ManagerStrings.storeOrderPaymentPaid
                : ManagerStrings.storeOrderPaymentUnpaid,
            valueColor: order.isPaid
                ? ManagerColors.primaryColor
                : ManagerColors.redNew,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
            child: Divider(
              height: 1,
              color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            ),
          ),
          _DetailRow(
            label: ManagerStrings.storeOrderTotalLabel,
            value: order.formattedTotal,
            valueColor: ManagerColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final int? count;

  const _SectionHeader({required this.title, this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.black,
          ),
        ),
        if (count != null) ...[
          SizedBox(width: ManagerWidth.w8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h2,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
            ),
            child: Text(
              '$count',
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ZoqakInfoCard extends StatelessWidget {
  final ComprehensiveZoqakOrderModel order;

  const _ZoqakInfoCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h14,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          _DetailRow(
            label: ManagerStrings.storeOrderDate,
            value: _formatDate(order.createdAt),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
            child: Divider(
              height: 1,
              color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            ),
          ),
          _DetailRow(
            label: ManagerStrings.orderDetailsZoqakBudgetLabel,
            value: order.budgetRange,
            valueColor: ManagerColors.primaryColor,
          ),
          if (order.deliveryDate != null && order.deliveryDate!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
              child: Divider(
                height: 1,
                color: ManagerColors.greyWhiteColor.withOpacity(0.2),
              ),
            ),
            _DetailRow(
              label: ManagerStrings.orderDetailsDeliveryDate,
              value: order.deliveryDate!,
            ),
          ],
        ],
      ),
    );
  }
}

class _SimilarImagesRow extends StatelessWidget {
  final List<String> images;

  const _SimilarImagesRow({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ManagerHeight.h80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w8),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          child: CachedNetworkImage(
            imageUrl: images[i],
            width: ManagerWidth.w80,
            height: ManagerHeight.h80,
            fit: BoxFit.cover,
            errorWidget: (_, __, ___) => Container(
              width: ManagerWidth.w80,
              height: ManagerHeight.h80,
              color: ManagerColors.greyWhiteColor.withOpacity(0.1),
              child: Icon(
                Icons.image_not_supported_outlined,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _LabeledText extends StatelessWidget {
  final String label;
  final String value;

  const _LabeledText({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h4),
        Text(
          value,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double radius;

  const _AvatarWidget({required this.imageUrl, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ManagerColors.greyWhiteColor.withOpacity(0.15),
      backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
          ? CachedNetworkImageProvider(imageUrl!)
          : null,
      child: imageUrl == null || imageUrl!.isEmpty
          ? Icon(
              Icons.person_outline_rounded,
              color: ManagerColors.greyWhiteColor,
              size: radius,
            )
          : null,
    );
  }
}

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
        color: ManagerColors.greyWhiteColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ManagerRadius.r6),
      ),
      child: Text(
        label,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s11,
          color: ManagerColors.greyWhiteColor,
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _CircleIconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r20),
      child: Container(
        width: ManagerWidth.w40,
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ManagerColors.primaryColor.withOpacity(0.08),
        ),
        child: Icon(
          icon,
          size: ManagerFontSize.s18,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        Text(
          value,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: valueColor ?? ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

class _DetailItemRow extends StatelessWidget {
  final ComprehensiveShopItemModel item;

  const _DetailItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h10),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.formattedUnitPrice,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
              Text(
                item.formattedTotalPrice,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StageRow extends StatelessWidget {
  final ComprehensiveStageModel stage;

  const _StageRow({required this.stage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h8),
      child: Row(
        children: [
          Icon(
            stage.completed
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            size: ManagerFontSize.s18,
            color: stage.completed
                ? ManagerColors.primaryColor
                : ManagerColors.greyWhiteColor.withOpacity(0.5),
          ),
          SizedBox(width: ManagerWidth.w10),
          Expanded(
            child: Text(
              stage.label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: stage.completed
                    ? ManagerColors.black
                    : ManagerColors.greyWhiteColor,
              ),
            ),
          ),
          if (stage.completed && stage.statusDate != null)
            Text(
              _formatDate(stage.statusDate!),
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak status config
// ─────────────────────────────────────────────────────────────────────────────

class _ZoqakStatusConfig {
  final String label;
  final Color background;
  final Color textColor;
  const _ZoqakStatusConfig(
      {required this.label, required this.background, required this.textColor});
}

_ZoqakStatusConfig _zoqakStatusConfig(ComprehensiveZoqakStatus status) {
  switch (status) {
    case ComprehensiveZoqakStatus.pending:
      return _ZoqakStatusConfig(
        label: ManagerStrings.ctZoqakStatusPending,
        background: const Color(0xFFFFF3E0),
        textColor: const Color(0xFFE65100),
      );
    case ComprehensiveZoqakStatus.accepted:
      return _ZoqakStatusConfig(
        label: ManagerStrings.ctZoqakStatusAccepted,
        background: const Color(0xFFE8F5E9),
        textColor: const Color(0xFF2E7D32),
      );
    case ComprehensiveZoqakStatus.completed:
      return _ZoqakStatusConfig(
        label: ManagerStrings.ctZoqakStatusCompleted,
        background: const Color(0xFFEDE7F6),
        textColor: const Color(0xFF4527A0),
      );
    case ComprehensiveZoqakStatus.cancelled:
      return _ZoqakStatusConfig(
        label: ManagerStrings.ctZoqakStatusCancelled,
        background: const Color(0xFFFFEBEE),
        textColor: const Color(0xFFC62828),
      );
    case ComprehensiveZoqakStatus.unknown:
      return _ZoqakStatusConfig(
        label: ManagerStrings.ctZoqakStatusUnknown,
        background: const Color(0xFFF5F5F5),
        textColor: ManagerColors.greyWhiteColor,
      );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak Offer Detail Bottom Sheet
// ─────────────────────────────────────────────────────────────────────────────

class ComprehensiveZoqakOfferDetailSheet extends StatelessWidget {
  final ZoqakOfferDetailModel detail;

  const ComprehensiveZoqakOfferDetailSheet({
    super.key,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final order = detail.order;
    final offer = detail.offer;
    final timeline = detail.timeline;
    final statusConfig = _zoqakStatusConfig(order.status);

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      snap: true,
      expand: false,
      builder: (_, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r20),
          ),
        ),
        child: Column(
          children: [
            // ── Header with drag handle ────────────────────────────────────
            Padding(
              padding: EdgeInsets.only(top: ManagerHeight.h12),
              child: Column(
                children: [
                  Container(
                    width: ManagerWidth.w40,
                    height: ManagerHeight.h4,
                    decoration: BoxDecoration(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h16),
                  // Order and offer status header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Order title
                        Text(
                          order.productName,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s18,
                            color: ManagerColors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: ManagerHeight.h8),
                        // Order number and status
                        Row(
                          children: [
                            Text(
                              order.orderNumber,
                              style: getRegularTextStyle(
                                fontSize: ManagerFontSize.s12,
                                color: ManagerColors.greyWhiteColor,
                              ),
                            ),
                            SizedBox(width: ManagerWidth.w12),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ManagerWidth.w10,
                                vertical: ManagerHeight.h4,
                              ),
                              decoration: BoxDecoration(
                                color: statusConfig.background,
                                borderRadius:
                                    BorderRadius.circular(ManagerRadius.r20),
                                border: Border.all(
                                  color:
                                      statusConfig.textColor.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                statusConfig.label,
                                style: getMediumTextStyle(
                                  fontSize: ManagerFontSize.s11,
                                  color: statusConfig.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ManagerHeight.h16),
            const Divider(height: 1),

            // ── Scrollable content ─────────────────────────────────────────
            Expanded(
              child: ListView(
                controller: scrollCtrl,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h16,
                ),
                children: [
                  // ── Offer card ───────────────────────────────────────────
                  _OfferCard(offer: offer),
                  SizedBox(height: ManagerHeight.h20),

                  // ── Order details ────────────────────────────────────────
                  _SectionHeader(
                    title: ManagerStrings.orderDetailsZoqakRequestTitle,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  _ZoqakOrderDetailsCard(order: order),
                  SizedBox(height: ManagerHeight.h20),

                  _SectionHeader(
                    title: ManagerStrings.ctOrderZoqakClientSection,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  _ClientDetailsCard(order: order),
                  SizedBox(height: ManagerHeight.h20),

                  // ── Timeline ─────────────────────────────────────────────
                  _SectionHeader(
                    title: ManagerStrings.ctOrderZoqakTimelineSection,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  ...timeline.map((event) => _TimelineEvent(event: event)),
                  SizedBox(height: ManagerHeight.h20),

                  // ── Similar images if available ──────────────────────────
                  if (order.similarImages.isNotEmpty) ...[
                    _SectionHeader(
                      title: ManagerStrings.ctOrderZoqakRefImagesSection,
                      count: order.similarImages.length,
                    ),
                    SizedBox(height: ManagerHeight.h10),
                    _SimilarImagesRow(images: order.similarImages),
                    SizedBox(height: ManagerHeight.h80),
                  ] else
                    SizedBox(height: ManagerHeight.h40),
                ],
              ),
            ),

            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ManagerWidth.w16,
                  0,
                  ManagerWidth.w16,
                  ManagerHeight.h14,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: ManagerHeight.h48,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ManagerRadius.r12),
                      ),
                    ),
                    child: Text(
                      ManagerStrings.ctOrderZoqakClose,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak Offer Detail Helper Widgets
// ─────────────────────────────────────────────────────────────────────────────

class _OfferCard extends StatelessWidget {
  final ComprehensiveZoqakOfferModel offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ManagerWidth.w14),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ManagerStrings.ctOrderZoqakYourOffer,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h12),
          // Price and execution days row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.ctOrderZoqakProposedPrice,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      offer.formattedPrice,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.ctOrderZoqakExecutionPeriod,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      offer.executionText,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (offer.details.isNotEmpty) ...[
            SizedBox(height: ManagerHeight.h12),
            Divider(
              height: 1,
              color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            ),
            SizedBox(height: ManagerHeight.h12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ManagerStrings.orderTrackingDetails,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                SizedBox(height: ManagerHeight.h6),
                Text(
                  offer.details,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.black,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ZoqakOrderDetailsCard extends StatelessWidget {
  final ZoqakOfferDetailOrderModel order;

  const _ZoqakOrderDetailsCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ManagerWidth.w14),
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
        ),
      ),
      child: Column(
        children: [
          _DetailRow(
            label: ManagerStrings.orderDetailsZoqakBudgetLabel,
            value: order.budgetRange,
            valueColor: ManagerColors.primaryColor,
          ),
          if (order.fabricType != null && order.fabricType!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
              child: Divider(
                height: 1,
                color: ManagerColors.greyWhiteColor.withOpacity(0.2),
              ),
            ),
            _DetailRow(
              label: ManagerStrings.orderTrackingDetailFabricType,
              value: order.fabricType!,
            ),
          ],
          if (order.deliveryDate != null && order.deliveryDate!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
              child: Divider(
                height: 1,
                color: ManagerColors.greyWhiteColor.withOpacity(0.2),
              ),
            ),
            _DetailRow(
              label: ManagerStrings.ctOrderZoqakDeliveryDate,
              value: order.deliveryDate!,
            ),
          ],
        ],
      ),
    );
  }
}

class _ClientDetailsCard extends StatelessWidget {
  final ZoqakOfferDetailOrderModel order;

  const _ClientDetailsCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ManagerWidth.w14),
      decoration: BoxDecoration(
        color: ManagerColors.greyWhiteColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          _AvatarWidget(
            imageUrl: order.requester.image,
            radius: ManagerWidth.w24,
          ),
          SizedBox(width: ManagerWidth.w10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.requester.fullName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(height: ManagerHeight.h4),
                Text(
                  ManagerStrings.ctOrderZoqakRequestOwner,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineEvent extends StatelessWidget {
  final ComprehensiveTimelineModel event;

  const _TimelineEvent({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: ManagerHeight.h12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: ManagerWidth.w40,
                height: ManagerHeight.h40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ManagerColors.primaryColor.withOpacity(0.1),
                ),
                child: Icon(
                  event.displayIcon,
                  size: ManagerFontSize.s18,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(width: ManagerWidth.w16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ManagerHeight.h4),
                Text(
                  event.displayLabel,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
                SizedBox(height: ManagerHeight.h4),
                Text(
                  _formatDate(event.occurredAt),
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
