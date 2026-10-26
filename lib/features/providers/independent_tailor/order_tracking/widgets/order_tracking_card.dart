import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/domain/model/order_tracking_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderTrackingCard extends StatelessWidget {
  final OrderTrackingItemModel order;
  final VoidCallback? onChat;
  final VoidCallback? onDetails;
  final VoidCallback? onActionButton;
  final String? actionLabel;

  const OrderTrackingCard({
    super.key,
    required this.order,
    this.onChat,
    this.onDetails,
    this.onActionButton,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final statusConfig = _statusConfig(order.status);
    final isPaid = order.statusPayment.toLowerCase() == 'paid';

    return Directionality(
      textDirection: Directionality.of(context),
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
              color: ManagerColors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            _buildHeaderRow(statusConfig, isPaid),
            SizedBox(height: ManagerHeight.h4),
            _buildCustomerRow(),
            SizedBox(height: ManagerHeight.h6),
            _buildProgressRow(),
            SizedBox(height: ManagerHeight.h8),
            _buildDatesRow(),
            SizedBox(height: ManagerHeight.h8),
            _buildActionsRow(),
            SizedBox(height: ManagerHeight.h10),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow(_StatusConfig config, bool isPaid) {
    return Container(
      decoration: BoxDecoration(
        color: config.bgColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ManagerRadius.r16),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h10,
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(
                  config.icon,
                  size: ManagerFontSize.s18,
                  color: config.textColor,
                ),
                SizedBox(width: ManagerWidth.w6),
                Expanded(
                  child: Text(
                    config.label,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: config.textColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w6),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h4,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(ManagerRadius.r20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPaid
                      ? Icons.check_circle_outline_rounded
                      : Icons.info_outline_rounded,
                  size: ManagerFontSize.s14,
                  color: isPaid
                      ? ManagerColors.primaryColor
                      : ManagerColors.redNew,
                ),
                SizedBox(width: ManagerWidth.w4),
                Text(
                  isPaid
                      ? ManagerStrings.orderTrackingPaid
                      : ManagerStrings.orderTrackingUnpaid,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: isPaid
                        ? ManagerColors.primaryColor
                        : ManagerColors.redNew,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w6),
          InkWell(
            onTap: onDetails,
            borderRadius: BorderRadius.circular(ManagerRadius.r6),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w8,
                vertical: ManagerHeight.h5,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ManagerStrings.orderTrackingDetails,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s10,
                      color: config.textColor,
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w4),
                  CustomSvgImage(
                    path: ManagerIcons.customOrderIcon,
                    width: ManagerWidth.w10,
                    height: ManagerHeight.h10,
                    color: config.textColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerRow() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CustomerAvatar(imageUrl: order.userImage),
          SizedBox(width: ManagerWidth.w8),
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
                SizedBox(height: ManagerHeight.h4),
                Text(
                  order.orderNumber,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                SizedBox(height: ManagerHeight.h2),
                Text(
                  order.orderId,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w8),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w8,
              vertical: ManagerHeight.h6,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
            child: Text(
              '${order.formattedPrice} ${ManagerStrings.orderTrackingCurrency}',
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s18,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressRow() {
    final total = order.stagesSummary.totalStages;
    final completed = order.stagesSummary.completedStagesCount;
    final progress = total > 0 ? completed / total : 0.0;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundTabBar.withOpacity(0.8),
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                ManagerStrings.orderTrackingProgressLabel,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.primaryColor,
                ),
              ),
              const Spacer(),
              Text(
                '$completed/$total',
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h8),
          ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r24),
            child: LinearProgressIndicator(
              minHeight: ManagerHeight.h8,
              value: progress,
              backgroundColor: ManagerColors.greyWhiteColor.withOpacity(0.25),
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatesRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
      child: Container(
        decoration: BoxDecoration(
          color: ManagerColors.backgroundTabBar.withOpacity(0.5),
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w14,
          vertical: ManagerHeight.h12,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    ManagerStrings.orderTrackingOrderDate,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Text(
                    _formatDate(order.orderDate),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1,
              height: ManagerHeight.h34,
              color: ManagerColors.greyWhiteColor.withOpacity(0.25),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    ManagerStrings.orderTrackingDeadline,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Text(
                    _formatDate(order.deliveryDeadline),
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsRow() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
      child: Row(
        children: [
          Expanded(
            child: _ChatButton(onTap: onChat),
          ),
          SizedBox(width: ManagerWidth.w10),
          Expanded(
            child: _ActionButton(
              label: actionLabel,
              onTap: onActionButton,
            ),
          ),
        ],
      ),
    );
  }

  _StatusConfig _statusConfig(OrderTrackingStatus status) {
    switch (status) {
      case OrderTrackingStatus.accepted:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingStatusAccepted,
          icon: Icons.verified_rounded,
          textColor: ManagerColors.primaryColor,
          bgColor: ManagerColors.primaryColor.withOpacity(0.10),
        );
      case OrderTrackingStatus.inProgress:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingStatusInProgress,
          icon: Icons.content_cut_rounded,
          textColor: ManagerColors.secondaryColor,
          bgColor: ManagerColors.secondaryColor.withOpacity(0.15),
        );
      case OrderTrackingStatus.ready:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingStatusReady,
          icon: Icons.check_circle_outline_rounded,
          textColor: ManagerColors.primaryColor,
          bgColor: ManagerColors.primaryColor.withOpacity(0.10),
        );
      case OrderTrackingStatus.readyForDelivery:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingStatusReadyForDelivery,
          icon: Icons.local_shipping_outlined,
          textColor: ManagerColors.primaryColor,
          bgColor: ManagerColors.primaryColor.withOpacity(0.10),
        );
      case OrderTrackingStatus.completed:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingStatusCompleted,
          icon: Icons.done_all_rounded,
          textColor: ManagerColors.primaryColor,
          bgColor: ManagerColors.primaryColor.withOpacity(0.14),
        );
      case OrderTrackingStatus.unknown:
        return _StatusConfig(
          label: ManagerStrings.orderTrackingFilterAll,
          icon: Icons.hourglass_empty_rounded,
          textColor: ManagerColors.greyWhiteColor,
          bgColor: ManagerColors.backgroundTabBar,
        );
    }
  }

  String _formatDate(String raw) {
    if (raw.isEmpty) return '-';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }
}

class _StatusConfig {
  final String label;
  final IconData icon;
  final Color textColor;
  final Color bgColor;

  const _StatusConfig({
    required this.label,
    required this.icon,
    required this.textColor,
    required this.bgColor,
  });
}

class _CustomerAvatar extends StatelessWidget {
  final String? imageUrl;

  const _CustomerAvatar({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ManagerWidth.w48,
      height: ManagerHeight.h48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ManagerColors.backgroundTabBar,
        border: Border.all(
          color: ManagerColors.white,
          width: 1,
        ),
      ),
      child: ClipOval(
        child: (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.person,
                  color: ManagerColors.greyWhiteColor,
                  size: ManagerFontSize.s20,
                ),
              )
            : Icon(
                Icons.person,
                color: ManagerColors.greyWhiteColor,
                size: ManagerFontSize.s20,
              ),
      ),
    );
  }
}

class _ChatButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _ChatButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r10),
      child: Container(
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          color: ManagerColors.backgroundTabBar.withOpacity(0.6),
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomSvgImage(
              path: ManagerIcons.messagesBottomIcon,
              height: ManagerHeight.h16,
              width: ManagerWidth.w16,
              color: ManagerColors.primaryColor,
            ),
            SizedBox(width: ManagerWidth.w6),
            Text(
              ManagerStrings.orderTrackingChat,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = label != null && label!.isNotEmpty && onTap != null;

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(ManagerRadius.r10),
      child: Container(
        height: ManagerHeight.h40,
        decoration: BoxDecoration(
          color: isEnabled
              ? ManagerColors.primaryColor
              : ManagerColors.greyWhiteColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.update_rounded,
              size: ManagerFontSize.s16,
              color: ManagerColors.white,
            ),
            SizedBox(width: ManagerWidth.w6),
            Flexible(
              child: Text(
                label ?? '',
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
