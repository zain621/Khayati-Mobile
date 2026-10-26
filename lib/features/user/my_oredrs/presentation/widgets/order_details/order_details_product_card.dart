import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/order_details_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsProductCard
// Section header inside card · product image + info · fabric · size ·
// description · price footer with payment badge
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsProductCard extends StatelessWidget {
  final OrderProduct product;
  const OrderDetailsProductCard({super.key, required this.product});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Section header inside card ────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
              top: ManagerHeight.h14,
              right: ManagerWidth.w14,
              left: ManagerWidth.w14,
            ),
            child: _SectionHeaderInCard(
              icon: Icons.shopping_bag_outlined,
              title: ManagerStrings.orderDetailsProductSection,
            ),
          ),

          SizedBox(height: ManagerHeight.h12),

          // ── Product name + image row ──────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image

                _ProductImage(imageUrl: product.imageUrl),
                SizedBox(width: ManagerWidth.w12),

                // Product info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: ManagerHeight.h12),
                      _DetailRow(
                        icon: Icons.circle,
                        iconColor: ManagerColors.primaryColor,
                        label: ManagerStrings.orderDetailsFabricLabel,
                        value: product.fabric,
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      _DetailRow(
                        icon: Icons.edit_outlined,
                        iconColor: ManagerColors.primaryColor,
                        label: ManagerStrings.orderDetailsMeasurementsLabel,
                        value: product.measurements,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ── Order description (text details) ─────────────────────────
          if (product.description != null &&
              product.description!.isNotEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w14,
                vertical: ManagerHeight.h10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: ManagerColors.greyWhiteColor.withOpacity(0.2),
                    height: 1,
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  Row(
                    children: [
                      Icon(
                        Icons.description_outlined,
                        size: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                      SizedBox(width: ManagerWidth.w6),
                      Text(
                        ManagerStrings.orderDetailsDescriptionLabel,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Text(
                    product.description!,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.greyWhiteColor,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],

          // ── Price footer ──────────────────────────────────────────────
          _PriceFooter(product: product),
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

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  const _DetailRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: icon == Icons.circle ? ManagerFontSize.s8 : ManagerFontSize.s14,
          color: iconColor,
        ),
        SizedBox(width: ManagerWidth.w6),
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.primaryColor,
          ),
        ),
        SizedBox(width: ManagerWidth.w4),
        Expanded(
          child: Text(
            value,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imageUrl;
  const _ProductImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        child: Container(
          width: ManagerWidth.w96,
          height: ManagerHeight.h128,
          color: ManagerColors.greyWhiteColor.withOpacity(0.12),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: ManagerColors.greyWhiteColor,
            size: 32,
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(ManagerRadius.r12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: ManagerWidth.w96,
        height: ManagerHeight.h128,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(
          width: ManagerWidth.w96,
          height: ManagerHeight.h128,
          color: ManagerColors.greyWhiteColor.withOpacity(0.12),
        ),
        errorWidget: (_, __, ___) => Container(
          width: ManagerWidth.w96,
          height: ManagerHeight.h128,
          color: ManagerColors.greyWhiteColor.withOpacity(0.12),
          child: Icon(Icons.image_not_supported_outlined,
              color: ManagerColors.greyWhiteColor),
        ),
      ),
    );
  }
}

class _PriceFooter extends StatelessWidget {
  final OrderProduct product;
  const _PriceFooter({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kOdSectionBg,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(ManagerRadius.r16),
          bottomRight: Radius.circular(ManagerRadius.r16),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── Price section ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ManagerStrings.orderDetailsTotalPriceLabel,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
              SizedBox(height: ManagerHeight.h4),
              Text(
                '${product.totalPrice.toInt()} ${ManagerStrings.orderDetailsCurrency}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          // ── Paid badge ──
          if (product.isPaid) _PaidChip(),
        ],
      ),
    );
  }
}

class _PaidChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: kOdPaidBg,
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_rounded,
              size: ManagerFontSize.s13, color: kOdSuccessText),
          SizedBox(width: ManagerWidth.w5),
          Text(
            ManagerStrings.orderDetailsPaid,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: kOdSuccessText,
            ),
          ),
        ],
      ),
    );
  }
}
