import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/domain/model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Simple and clean product card widget.
class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onEdit;
  final VoidCallback? onPause;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const ProductCard({
    super.key,
    required this.product,
    this.onEdit,
    this.onPause,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h8,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        child: Padding(
          padding: EdgeInsets.all(ManagerWidth.w12),
          child: Column(
            children: [
              /// Product Info Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Product Image
                  _buildImage(),

                  SizedBox(width: ManagerWidth.w12),

                  /// Product Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Status Chip
                        _buildStatusChip(),

                        SizedBox(height: ManagerHeight.h8),

                        /// Product Name
                        Text(
                          product.name,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s15,
                            color: ManagerColors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        SizedBox(height: ManagerHeight.h4),

                        /// Category
                        Text(
                          product.category.name,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.greyWhiteColor,
                          ),
                        ),

                        SizedBox(height: ManagerHeight.h8),

                        /// Price
                        _buildPrice(),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: ManagerHeight.h12),

              /// Stats Row
              _buildStatsRow(),

              SizedBox(height: ManagerHeight.h12),

              /// Action Buttons
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  /// Product image with discount badge
  Widget _buildImage() {
    return Stack(
      children: [
        Container(
          width: ManagerWidth.w90,
          height: ManagerHeight.h90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            color: const Color(0xFFF8F8F8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            child: product.imageUrl.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: product.imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: ManagerColors.greyWhiteColor.withOpacity(0.5),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        Icons.image_outlined,
                        color: ManagerColors.greyWhiteColor.withOpacity(0.5),
                        size: ManagerFontSize.s32,
                      ),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: ManagerColors.greyWhiteColor.withOpacity(0.5),
                      size: ManagerFontSize.s32,
                    ),
                  ),
          ),
        ),

        /// Discount Badge
        if (product.hasDiscount)
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w6,
                vertical: ManagerHeight.h3,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFE53935),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ManagerRadius.r10),
                  bottomRight: Radius.circular(ManagerRadius.r8),
                ),
              ),
              child: Text(
                '-${product.discountPercent}%',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s10,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Status chip
  Widget _buildStatusChip() {
    final config = _getStatusConfig();

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(ManagerRadius.r4),
      ),
      child: Text(
        config.label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s10,
          color: config.textColor,
        ),
      ),
    );
  }

  /// Price display
  Widget _buildPrice() {
    return Row(
      children: [
        Text(
          '${product.formattedPrice} ${ManagerStrings.orderTrackingCurrency}',
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s18,
            color: ManagerColors.primaryColor,
          ),
        ),
        if (product.hasDiscount) ...[
          SizedBox(width: ManagerWidth.w8),
          Text(
            '${product.formattedOriginalPrice}',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.greyWhiteColor,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ],
    );
  }

  /// Stats row: Stock, Orders, Sizes, Colors
  Widget _buildStatsRow() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w12,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStatItem(
            label: ManagerStrings.managerProductsStock,
            value: '${product.stockCount}',
            isWarning: product.stockCount == 0,
          ),
          _buildDivider(),
          _buildStatItem(
            label: ManagerStrings.managerProductsDelivery,
            value: '${product.deliveryTimeMin}-${product.deliveryTimeMax}',
          ),
          _buildDivider(),
          _buildStatItem(
            label: ManagerStrings.managerProductsSizes,
            value: product.uniqueSizes.isNotEmpty ? product.uniqueSizes.join(', ') : '-',
          ),
          _buildDivider(),
          _buildColorCircles(),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    bool isWarning = false,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s13,
            color: isWarning ? const Color(0xFFE53935) : ManagerColors.black,
          ),
        ),
        SizedBox(height: ManagerHeight.h2),
        Text(
          label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s10,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  /// Color circles widget
  Widget _buildColorCircles() {
    final colors = product.uniqueColors;
    return Column(
      children: [
        if (colors.isEmpty)
          Text(
            '-',
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...colors.take(4).map((variant) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w2),
                  width: ManagerWidth.w18,
                  height: ManagerWidth.w18,
                  decoration: BoxDecoration(
                    color: _hexToColor(variant.hexCode),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                );
              }),
              if (colors.length > 4)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w2),
                  width: ManagerWidth.w18,
                  height: ManagerWidth.w18,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '+${colors.length - 4}',
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s8,
                        color: ManagerColors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        SizedBox(height: ManagerHeight.h2),
        Text(
          ManagerStrings.managerProductsColors,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s10,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  /// Convert hex string to Color
  Color _hexToColor(String hexCode) {
    try {
      final hex = hexCode.replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (e) {
      return ManagerColors.greyWhiteColor;
    }
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: ManagerHeight.h30,
      color: ManagerColors.greyWhiteColor.withOpacity(0.2),
    );
  }

  /// Action buttons
  Widget _buildActions() {
    return Row(
      children: [
        /// Edit Button
        Expanded(
          child: _buildButton(
            label: ManagerStrings.managerProductsEdit,
            icon: Icons.edit_outlined,
            color: ManagerColors.primaryColor,
            onTap: onEdit,
          ),
        ),

        SizedBox(width: ManagerWidth.w8),

        /// Pause/Resume Button
        Expanded(
          child: _buildButton(
            label: product.status == ProductStatus.active
                ? ManagerStrings.managerProductsPause
                : ManagerStrings.managerProductsResume,
            icon: product.status == ProductStatus.active
                ? Icons.pause_outlined
                : Icons.play_arrow_outlined,
            color: product.status == ProductStatus.active
                ? const Color(0xFFFFA000)
                : const Color(0xFF2E7D32),
            onTap: onPause,
          ),
        ),

        SizedBox(width: ManagerWidth.w8),

        /// Delete Button
        Expanded(
          child: _buildButton(
            label: ManagerStrings.managerProductsDelete,
            icon: Icons.delete_outline,
            color: const Color(0xFFE53935),
            onTap: onDelete,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required IconData icon,
    required Color color,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(ManagerRadius.r8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: ManagerFontSize.s16,
              color: color,
            ),
            SizedBox(width: ManagerWidth.w4),
            Text(
              label,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s12,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _StatusConfig _getStatusConfig() {
    switch (product.status) {
      case ProductStatus.active:
        return _StatusConfig(
          label: ManagerStrings.managerProductsStatusActive,
          textColor: const Color(0xFF2E7D32),
          backgroundColor: const Color(0xFFE8F5E9),
        );
      case ProductStatus.inactive:
        return _StatusConfig(
          label: ManagerStrings.managerProductsStatusInactive,
          textColor: const Color(0xFFE65100),
          backgroundColor: const Color(0xFFFFF3E0),
        );
      case ProductStatus.outOfStock:
        return _StatusConfig(
          label: ManagerStrings.managerProductsStatusOutOfStock,
          textColor: const Color(0xFFC62828),
          backgroundColor: const Color(0xFFFFEBEE),
        );
    }
  }
}

class _StatusConfig {
  final String label;
  final Color textColor;
  final Color backgroundColor;

  const _StatusConfig({
    required this.label,
    required this.textColor,
    required this.backgroundColor,
  });
}
