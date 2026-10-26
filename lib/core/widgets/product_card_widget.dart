import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Data model for a single product card.
class ProductItemModel {
  final String id;
  final String name;
  final String shopName;
  final String imageUrl;
  final double price;

  // Show "الأكثر مبيعاً" badge when true
  final bool isBestSeller;

  const ProductItemModel({
    required this.id,
    required this.name,
    required this.shopName,
    required this.imageUrl,
    required this.price,
    this.isBestSeller = false,
  });
}

class ProductCardWidget extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback? onTap;
  final VoidCallback? onAddToCart;

  const ProductCardWidget({
    super.key,
    required this.product,
    this.onTap,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product image — fills leftover space so card never overflows
            Expanded(child: _ProductImage(product: product)),

            // Product info section
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w12,
                vertical: ManagerHeight.h8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product name
                  Text(
                    product.name,
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: ManagerHeight.h4),

                  // Shop name row
                  Row(
                    children: [
                      CustomSvgImage(
                        path: ManagerIcons.shopIcon,
                        width: ManagerWidth.w12,
                        height: ManagerWidth.w12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                      SizedBox(width: ManagerWidth.w2),
                      Expanded(
                        child: Text(
                          product.shopName,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s10,
                            color: ManagerColors.greyWhiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ManagerHeight.h8),

                  // Price + add-to-cart button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Price
                      Text(
                        '${product.price.toStringAsFixed(0)} ${ManagerStrings.userHomeCurrency}',
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.black,
                        ),
                      ),

                      const Spacer(),

                      // Cart button
                      _AddToCartButton(onTap: onAddToCart),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Clipped image area with the best-seller badge overlay.
class _ProductImage extends StatelessWidget {
  final ProductItemModel product;

  const _ProductImage({required this.product});

  @override
  Widget build(BuildContext context) {
    final imageUrl = _safeImageUrl(product.imageUrl);

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(ManagerRadius.r12),
        topRight: Radius.circular(ManagerRadius.r12),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Product image — logo fallback when null/empty
          if (imageUrl == null)
            const _LogoPlaceholder()
          else
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 220),
              placeholder: (_, __) => const _ImageLoadingPlaceholder(),
              errorWidget: (_, __, ___) => const _LogoPlaceholder(),
            ),

          // Best-seller badge — top-right (start in RTL)
          if (product.isBestSeller)
            Positioned(
              top: ManagerHeight.h8,
              right: ManagerWidth.w8,
              child: const _BestSellerBadge(),
            ),
        ],
      ),
    );
    // );
  }
}

/// Teal pill badge shown on best-selling products.
class _BestSellerBadge extends StatelessWidget {
  const _BestSellerBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomSvgImage(
            path: ManagerIcons.bestSellerIcon,
            width: ManagerWidth.w12,
            height: ManagerWidth.w12,
            color: ManagerColors.primaryColor,
          ),
          SizedBox(width: ManagerWidth.w4),
          Text(
            ManagerStrings.productBestSellerLabel,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Teal square button for adding product to cart.
class _AddToCartButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _AddToCartButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w28,
        height: ManagerWidth.w28,
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor,
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
        ),
        child: Center(
          child: CustomSvgImage(
            path: ManagerIcons.cartProductIcon,
            width: ManagerWidth.w14,
            height: ManagerHeight.h14,
            color: ManagerColors.white,
          ),
        ),
      ),
    );
  }
}

String? _safeImageUrl(String? value) {
  if (value == null) return null;

  final normalized = value.trim();
  if (normalized.isEmpty || normalized.toLowerCase() == 'null') {
    return null;
  }

  final uri = Uri.tryParse(normalized);
  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
    return null;
  }

  return normalized;
}

class _ImageLoadingPlaceholder extends StatelessWidget {
  const _ImageLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE7EEE9),
      highlightColor: const Color(0xFFF8FBF9),
      child: Container(
        color: ManagerColors.white,
        padding: EdgeInsets.all(ManagerWidth.w12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ManagerWidth.w46,
              height: ManagerWidth.w46,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r14),
              ),
            ),
            SizedBox(height: ManagerHeight.h14),
            Container(
              width: ManagerWidth.w78,
              height: ManagerHeight.h8,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown when a product has no image URL or the network image fails.
/// Displays the app logo centred on a soft background.
class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.06),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ManagerWidth.w16),
          child: CustomSvgImage(
            path: ManagerImages.logo,
            width: ManagerWidth.w56,
            height: ManagerWidth.w56,
            color: ManagerColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
