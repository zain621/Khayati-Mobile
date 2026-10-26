import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/all_products/domain/model/product_list_item_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AllProductsShimmer  —  grid of skeleton cards while loading
// ─────────────────────────────────────────────────────────────────────────────

class AllProductsShimmer extends StatelessWidget {
  const AllProductsShimmer({super.key});

  static const _kBase = Color(0xFFE8E8E8);
  static const _kHighlight = Color(0xFFF6F6F6);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: ManagerWidth.w10,
          mainAxisSpacing: ManagerHeight.h10,
          childAspectRatio: 0.54,
        ),
        itemCount: 8,
        itemBuilder: (_, __) => const _ProductShimmerCard(),
      ),
    );
  }
}

class _ProductShimmerCard extends StatelessWidget {
  const _ProductShimmerCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(ManagerRadius.r16),
                    ),
                  ),
                ),
                Positioned(
                  top: ManagerHeight.h8,
                  right: ManagerWidth.w8,
                  child: _SBox(w: ManagerWidth.w58, h: ManagerHeight.h22),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SBox(w: double.infinity, h: ManagerHeight.h13),
                  SizedBox(height: ManagerHeight.h8),
                  _SBox(w: ManagerWidth.w70, h: ManagerHeight.h11),
                  const Spacer(),
                  Row(
                    children: [
                      _SBox(w: ManagerWidth.w66, h: ManagerHeight.h14),
                      const Spacer(),
                      _SBox(w: ManagerWidth.w28, h: ManagerWidth.w28),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SBox extends StatelessWidget {
  final double w, h;
  const _SBox({required this.w, required this.h});

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r4),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// AnimatedProductCard  —  staggered entrance animation wrapper
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedProductCard extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedProductCard({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<AnimatedProductCard> createState() => _AnimatedProductCardState();
}

class _AnimatedProductCardState extends State<AnimatedProductCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _scale = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutBack),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );

    Future.delayed(
      Duration(milliseconds: (widget.index * 50).clamp(0, 250)),
      () {
        if (mounted) _ctrl.forward();
      },
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: widget.child),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllProductCard  —  professional vertical grid card
// ─────────────────────────────────────────────────────────────────────────────

class AllProductCard extends StatelessWidget {
  final ProductListItemModel product;
  final VoidCallback? onTap;

  const AllProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ManagerColors.white,
      borderRadius: BorderRadius.circular(ManagerRadius.r16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.09),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        splashColor: ManagerColors.primaryColor.withOpacity(0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Product image ──────────────────────────────────────────
            Expanded(
              flex: 5,
              child: _ProductImage(
                imageUrl: product.imageUrl,
                isBestSelling: product.isBestSelling,
                hasDiscount: product.hasDiscount,
              ),
            ),
            // ── Product info ──────────────────────────────────────────
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  ManagerWidth.w10,
                  ManagerHeight.h8,
                  ManagerWidth.w10,
                  ManagerHeight.h10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    Text(
                      product.name,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ManagerHeight.h3),
                    // Shop name
                    if (product.shopName.isNotEmpty)
                      Text(
                        product.shopName,
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.greyWhiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const Spacer(),
                    // Price row
                    _PriceRow(product: product),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String? imageUrl;
  final bool isBestSelling;
  final bool hasDiscount;

  const _ProductImage({
    this.imageUrl,
    required this.isBestSelling,
    required this.hasDiscount,
  });

  @override
  Widget build(BuildContext context) {
    final safeUrl = _safeImageUrl(imageUrl);

    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ManagerRadius.r16),
          ),
          child: (safeUrl != null)
              ? CachedNetworkImage(
                  imageUrl: safeUrl,
                  fit: BoxFit.cover,
                  fadeInDuration: const Duration(milliseconds: 220),
                  placeholder: (_, __) => const _ImageLoadingPlaceholder(),
                  errorWidget: (_, __, ___) => const _ImagePlaceholder(),
                )
              : const _ImagePlaceholder(),
        ),
        // Best selling badge
        if (isBestSelling)
          Positioned(
            top: ManagerHeight.h8,
            right: ManagerWidth.w8,
            child: _BestSellingBadge(),
          ),
        // Discount badge
        if (hasDiscount)
          Positioned(
            top: ManagerHeight.h8,
            left: ManagerWidth.w8,
            child: _DiscountBadge(),
          ),
      ],
    );
  }
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
        padding: EdgeInsets.all(ManagerWidth.w14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ManagerWidth.w44,
              height: ManagerWidth.w44,
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r14),
              ),
            ),
            SizedBox(height: ManagerHeight.h14),
            Container(
              width: ManagerWidth.w82,
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

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F0FF),
      child: Center(
        child: Icon(
          Icons.shopping_bag_outlined,
          color: ManagerColors.primaryColor.withOpacity(0.4),
          size: ManagerWidth.w38,
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

class _BestSellingBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w7,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: Colors.white, size: ManagerWidth.w10),
          SizedBox(width: ManagerWidth.w3),
          Text(
            ManagerStrings.allProductsBestSelling,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s9,
              color: ManagerColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w6,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor,
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Text(
        ManagerStrings.allProductsDiscount,
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s9,
          color: ManagerColors.white,
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final ProductListItemModel product;

  const _PriceRow({required this.product});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Text(
            '${product.price.toStringAsFixed(0)} ${ManagerStrings.allProductsCurrency}',
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.primaryColor,
            ),
          ),
          if (product.hasDiscount) ...[
            SizedBox(width: ManagerWidth.w5),
            Text(
              '${product.priceBeforeDiscount!.toStringAsFixed(0)}',
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ).copyWith(
                decoration: TextDecoration.lineThrough,
                decorationColor: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllProductsEmptyState
// ─────────────────────────────────────────────────────────────────────────────

class AllProductsEmptyState extends StatelessWidget {
  const AllProductsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ManagerWidth.w90,
            height: ManagerWidth.w90,
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              size: ManagerWidth.w44,
              color: ManagerColors.primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: ManagerHeight.h20),
          Text(
            ManagerStrings.allProductsEmptyTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s18,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
            child: Text(
              ManagerStrings.allProductsEmptySubtitle,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllProductsErrorState
// ─────────────────────────────────────────────────────────────────────────────

class AllProductsErrorState extends StatelessWidget {
  final VoidCallback? onRetry;

  const AllProductsErrorState({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: ManagerWidth.w56,
            color: ManagerColors.greyWhiteColor,
          ),
          SizedBox(height: ManagerHeight.h16),
          Text(
            ManagerStrings.allProductsLoadError,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h20),
          GestureDetector(
            onTap: onRetry,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w24,
                vertical: ManagerHeight.h12,
              ),
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
              child: Text(
                ManagerStrings.retry,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllProductsLoadMoreIndicator
// ─────────────────────────────────────────────────────────────────────────────

class AllProductsLoadMoreIndicator extends StatelessWidget {
  const AllProductsLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ManagerHeight.h20),
      child: Center(
        child: SizedBox(
          width: ManagerWidth.w24,
          height: ManagerWidth.w24,
          child: const CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(
              ManagerColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
