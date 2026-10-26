import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_domain_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_colors.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_section_header.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsShopSection
//
// Details tab content for shop (قطع جاهزة) orders.
// Shows:
//   1. Shop info card  (name, payment badge, total)
//   2. Items list card (each item: name, color, size, qty, price)
//   3. Order total footer
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsShopSection extends StatelessWidget {
  final UserOrderDomainModel order;
  final VoidCallback? onChat;
  final bool isChatLoading;

  const OrderDetailsShopSection({
    super.key,
    required this.order,
    this.onChat,
    this.isChatLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? [];
    final total = order.totalAmount ?? 0.0;
    final isPaid = order.paymentStatus?.toLowerCase() == 'paid';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Shop info card ────────────────────────────────────────────
        _ShopInfoCard(
          shopName: order.shopName ?? '',
          isPaid: isPaid,
          total: total,
          onChat: onChat,
          isChatLoading: isChatLoading,
        ),

        SizedBox(height: ManagerHeight.h16),

        // ── Items list card ───────────────────────────────────────────
        _ItemsCard(items: items),

        SizedBox(height: ManagerHeight.h16),

        // ── Total footer ──────────────────────────────────────────────
        _TotalFooter(total: total, isPaid: isPaid),

        SizedBox(height: ManagerHeight.h24),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ShopInfoCard
// ─────────────────────────────────────────────────────────────────────────────

class _ShopInfoCard extends StatelessWidget {
  final String shopName;
  final bool isPaid;
  final double total;
  final VoidCallback? onChat;
  final bool isChatLoading;

  const _ShopInfoCard({
    required this.shopName,
    required this.isPaid,
    required this.total,
    this.onChat,
    this.isChatLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsSectionHeader(
            icon: Icons.store_rounded,
            title: ManagerStrings.orderDetailsShopSectionTitle,
          ),
          SizedBox(height: ManagerHeight.h12),
          Row(
            children: [
              // Shop avatar
              Container(
                width: ManagerWidth.w48,
                height: ManagerWidth.w48,
                decoration: BoxDecoration(
                  color: kOdStatusSectionBg,
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                child: Icon(
                  Icons.store_rounded,
                  color: ManagerColors.primaryColor,
                  size: ManagerFontSize.s24,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shopName,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s15,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Row(
                      children: [
                        _PaymentBadge(isPaid: isPaid),
                        SizedBox(width: ManagerWidth.w8),
                        Text(
                          '${total.toStringAsFixed(0)} ${ManagerStrings.orderDetailsCurrency}',
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (onChat != null)
                IconButton(
                  onPressed: isChatLoading ? null : onChat,
                  tooltip: ManagerStrings.orderDetailsChat,
                  icon: isChatLoading
                      ? SizedBox(
                          width: ManagerWidth.w20,
                          height: ManagerWidth.w20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ManagerColors.primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.chat_bubble_outline_rounded,
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

// ─────────────────────────────────────────────────────────────────────────────
// _ItemsCard
// ─────────────────────────────────────────────────────────────────────────────

class _ItemsCard extends StatelessWidget {
  final List<OrderItemLineDomain> items;

  const _ItemsCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsSectionHeader(
            icon: Icons.shopping_bag_outlined,
            title: ManagerStrings.orderDetailsItemsSectionTitle,
          ),
          SizedBox(height: ManagerHeight.h12),
          ...List.generate(items.length, (i) {
            final item = items[i];
            return Column(
              children: [
                _OrderItemRow(item: item),
                if (i < items.length - 1)
                  Divider(
                    height: ManagerHeight.h24,
                    thickness: 0.8,
                    color: ManagerColors.greyWhiteColor.withOpacity(0.2),
                  ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _OrderItemRow
// ─────────────────────────────────────────────────────────────────────────────

class _OrderItemRow extends StatelessWidget {
  final OrderItemLineDomain item;
  const _OrderItemRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final currency = ManagerStrings.orderDetailsCurrency;
    final hasColor = item.color != null && item.color!.isNotEmpty;
    final hasSize = item.size != null && item.size!.isNotEmpty;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Clothing icon ─────────────────────────────────────────────
        Container(
          width: ManagerWidth.w42,
          height: ManagerWidth.w42,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
          ),
          child: Icon(
            Icons.checkroom_rounded,
            color: ManagerColors.primaryColor,
            size: ManagerFontSize.s20,
          ),
        ),
        SizedBox(width: ManagerWidth.w12),

        // ── Details column ────────────────────────────────────────────
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product name
              Text(
                item.productName ?? '',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: ManagerHeight.h8),

              // ── Attribute tags row ─────────────────────────────────
              Wrap(
                spacing: ManagerWidth.w6,
                runSpacing: ManagerHeight.h4,
                children: [
                  if (hasColor)
                    _AttrTag(
                      leading: _ColorDot(colorName: item.color!),
                      label: item.color!,
                    ),
                  if (hasSize)
                    _AttrTag(
                      leading: const Icon(
                        Icons.straighten_rounded,
                        size: 11,
                        color: Color(0xFF9E9E9E),
                      ),
                      label: item.size!,
                    ),
                  _AttrTag(
                    leading: const Icon(
                      Icons.layers_outlined,
                      size: 11,
                      color: Color(0xFF9E9E9E),
                    ),
                    label: '×${item.quantity}',
                  ),
                ],
              ),

              // ── Unit price formula ─────────────────────────────────
              SizedBox(height: ManagerHeight.h6),
              Text(
                '${item.unitPrice.toStringAsFixed(0)} $currency × ${item.quantity}',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: ManagerWidth.w10),

        // ── Total ─────────────────────────────────────────────────────
        Padding(
          padding: EdgeInsets.only(top: ManagerHeight.h2),
          child: RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${item.totalPrice.toStringAsFixed(0)}\n',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: currency,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.primaryColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _TotalFooter
// ─────────────────────────────────────────────────────────────────────────────

class _TotalFooter extends StatelessWidget {
  final double total;
  final bool isPaid;

  const _TotalFooter({required this.total, required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kOdStatusSectionBg,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(color: kOdLineColor),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h14,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ManagerStrings.orderDetailsTotalPriceLabel,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          Row(
            children: [
              Text(
                '${total.toStringAsFixed(0)} ${ManagerStrings.orderDetailsCurrency}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: ManagerColors.primaryColor,
                ),
              ),
              SizedBox(width: ManagerWidth.w8),
              _PaymentBadge(isPaid: isPaid),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

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
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(ManagerWidth.w16),
      child: child,
    );
  }
}

class _PaymentBadge extends StatelessWidget {
  final bool isPaid;
  const _PaymentBadge({required this.isPaid});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: isPaid ? kOdPaidBg : const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Text(
        isPaid
            ? ManagerStrings.orderDetailsPaid
            : ManagerStrings.orderDetailsUnpaid,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s10,
          color: isPaid ? kOdSuccessText : const Color(0xFFE65100),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _AttrTag — unified slim pill for color / size / qty attributes
// ─────────────────────────────────────────────────────────────────────────────

class _AttrTag extends StatelessWidget {
  final Widget leading;
  final String label;
  const _AttrTag({required this.leading, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w7,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(ManagerRadius.r6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          SizedBox(width: ManagerWidth.w4),
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s11,
              color: const Color(0xFF424242),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ColorDot — resolves Arabic color name to an actual Color swatch
// ─────────────────────────────────────────────────────────────────────────────

class _ColorDot extends StatelessWidget {
  final String colorName;
  const _ColorDot({required this.colorName});

  static const _map = <String, Color>{
    'احمر':    Color(0xFFE53935),
    'أحمر':    Color(0xFFE53935),
    'ازرق':    Color(0xFF1E88E5),
    'أزرق':    Color(0xFF1E88E5),
    'اخضر':    Color(0xFF43A047),
    'أخضر':    Color(0xFF43A047),
    'اصفر':    Color(0xFFFDD835),
    'أصفر':    Color(0xFFFDD835),
    'ابيض':    Color(0xFFEEEEEE),
    'أبيض':    Color(0xFFEEEEEE),
    'اسود':    Color(0xFF212121),
    'أسود':    Color(0xFF212121),
    'بني':     Color(0xFF6D4C41),
    'بنفسجي':  Color(0xFF8E24AA),
    'وردي':    Color(0xFFEC407A),
    'زهري':    Color(0xFFEC407A),
    'رمادي':   Color(0xFF757575),
    'برتقالي': Color(0xFFEF6C00),
    'سماوي':   Color(0xFF00ACC1),
    'فيروزي':  Color(0xFF00BFA5),
    'ذهبي':    Color(0xFFFFB300),
    'فضي':     Color(0xFF9E9E9E),
    'بيج':     Color(0xFFD7C19A),
    'كريمي':   Color(0xFFF5F0E1),
    'زيتي':    Color(0xFF558B2F),
    'نيلي':    Color(0xFF283593),
  };

  @override
  Widget build(BuildContext context) {
    final resolved = _map[colorName.trim()];
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: resolved ?? const Color(0xFFBDBDBD),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black.withOpacity(resolved != null ? 0.12 : 0.2),
          width: 0.8,
        ),
      ),
    );
  }
}
