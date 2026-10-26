import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/product_card_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Data Models
// ═══════════════════════════════════════════════════════════════════════════════

class BestSellingStoreModel {
  final String id;
  final String name;
  final String? imageUrl;
  final String coverImageUrl;
  final double rating;
  final int reviewCount;
  final int productCount;
  final int completedOrdersCount;
  final bool isAvailable;
  final List<String> tags;
  final List<ProductItemModel> products;

  const BestSellingStoreModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.coverImageUrl,
    required this.rating,
    required this.reviewCount,
    required this.productCount,
    this.completedOrdersCount = 0,
    this.isAvailable = true,
    required this.tags,
    required this.products,
  });
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Mock Data
// ═══════════════════════════════════════════════════════════════════════════════

final List<BestSellingStoreModel> _mockBestSellingStores = [
  BestSellingStoreModel(
    id: '1',
    name: 'دار الأناقة',
    coverImageUrl:
        'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600&q=80',
    rating: 4.9,
    reviewCount: 342,
    productCount: 24,
    completedOrdersCount: 15,
    isAvailable: true,
    tags: const ['تطريز يدوي', 'عبايات فاخرة'],
    products: const [
      ProductItemModel(
        id: 'p1',
        name: 'عباية سهرة فاخرة',
        shopName: 'دار الأناقة',
        imageUrl:
            'https://images.unsplash.com/photo-1594938298603-c8148c4b5a4a?w=400&q=80',
        price: 650,
        isBestSeller: false,
      ),
      ProductItemModel(
        id: 'p2',
        name: 'عباية كلاسيك سوداء',
        shopName: 'دار الأناقة',
        imageUrl:
            'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400&q=80',
        price: 450,
        isBestSeller: true,
      ),
      ProductItemModel(
        id: 'p3',
        name: 'عباية مطرزة ذهبية',
        shopName: 'دار الأناقة',
        imageUrl:
            'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400&q=80',
        price: 780,
        isBestSeller: false,
      ),
      ProductItemModel(
        id: 'p4',
        name: 'عباية عصرية',
        shopName: 'دار الأناقة',
        imageUrl:
            'https://images.unsplash.com/photo-1567401893414-76b7b1e5a7a5?w=400&q=80',
        price: 520,
        isBestSeller: false,
      ),
    ],
  ),
  BestSellingStoreModel(
    id: '2',
    name: 'خياطة الفاخرة',
    coverImageUrl:
        'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=400&q=80',
    rating: 4.7,
    reviewCount: 208,
    productCount: 18,
    completedOrdersCount: 9,
    isAvailable: true,
    tags: const ['عبايات فاخرة', 'تطريز يدوي'],
    products: const [
      ProductItemModel(
        id: 'p5',
        name: 'عباية كحلي لؤلؤية',
        shopName: 'خياطة الفاخرة',
        imageUrl:
            'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?w=400&q=80',
        price: 720,
        isBestSeller: true,
      ),
      ProductItemModel(
        id: 'p6',
        name: 'عباية كلاسيكية',
        shopName: 'خياطة الفاخرة',
        imageUrl:
            'https://images.unsplash.com/photo-1594938298603-c8148c4b5a4a?w=400&q=80',
        price: 380,
        isBestSeller: false,
      ),
    ],
  ),
];

// ═══════════════════════════════════════════════════════════════════════════════
// ── Main Widget
// ═══════════════════════════════════════════════════════════════════════════════

/// Home screen section — "المتاجر الأكثر مبيعاً"
///
/// Shows a vertical list of premium store cards, each with cover image, stats,
/// tags, product thumbnails with prices, and a browse-all button.
class HomeBestSellingStoresWidget extends StatelessWidget {
  final List<BestSellingStoreModel>? stores;
  final VoidCallback? onViewAll;
  final void Function(BestSellingStoreModel store)? onStoreTap;
  final void Function(BestSellingStoreModel store, ProductItemModel product)?
      onProductTap;

  const HomeBestSellingStoresWidget({
    super.key,
    this.stores,
    this.onViewAll,
    this.onStoreTap,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedStores = stores ?? _mockBestSellingStores;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Premium Section Header ─────────────────────────────────────
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Row(
            children: [
              // Gold crown badge
              Container(
                padding: EdgeInsets.all(ManagerWidth.w7),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFD700), Color(0xFFFFAA00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFAA00).withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: Colors.white,
                  size: ManagerWidth.w16,
                ),
              ),
              SizedBox(width: ManagerWidth.w10),
              // Title
              Expanded(
                child: Text(
                  ManagerStrings.bestSellingStoresTitle,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s15,
                    color: ManagerColors.black,
                  ),
                ),
              ),
              // View all
              if (onViewAll != null)
                GestureDetector(
                  onTap: onViewAll,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ManagerStrings.userHomeViewAll,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.primaryColor,
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w3),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: ManagerWidth.w12,
                        color: ManagerColors.primaryColor,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: ManagerHeight.h14),

        // ── Store Cards ────────────────────────────────────────────────
        ...resolvedStores.asMap().entries.map(
              (entry) => Padding(
                padding: EdgeInsets.only(
                  left: ManagerWidth.w16,
                  right: ManagerWidth.w16,
                  bottom: ManagerHeight.h20,
                ),
                child: _BestSellingStoreCard(
                  store: entry.value,
                  rank: entry.key + 1,
                  onStoreTap: () => onStoreTap?.call(entry.value),
                  onProductTap: (product) =>
                      onProductTap?.call(entry.value, product),
                ),
              ),
            ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Store Card
// ═══════════════════════════════════════════════════════════════════════════════

class _BestSellingStoreCard extends StatelessWidget {
  final BestSellingStoreModel store;
  final int rank;
  final VoidCallback? onStoreTap;
  final void Function(ProductItemModel product)? onProductTap;

  const _BestSellingStoreCard({
    required this.store,
    required this.rank,
    this.onStoreTap,
    this.onProductTap,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.07),
            blurRadius: 16,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Cover Image + Overlay ────────────────────────────────────
          _StoreCoverSection(store: store, rank: rank, onTap: onStoreTap),

          // ── Card Body ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats row
                _StoreStatsRow(store: store),

                if (store.tags.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h10),
                  _StoreTags(tags: store.tags),
                ],

                if (store.products.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h16),
                  _StoreProductsHeader(productCount: store.products.length),
                  SizedBox(height: ManagerHeight.h10),
                  _StoreProductThumbnails(
                    products: store.products,
                    onProductTap: onProductTap,
                  ),
                ],

                SizedBox(height: ManagerHeight.h14),
                _BrowseStoreButton(onTap: onStoreTap),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Cover Image Section with overlay info + rank badge
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreCoverSection extends StatelessWidget {
  final BestSellingStoreModel store;
  final int rank;
  final VoidCallback? onTap;

  const _StoreCoverSection({
    required this.store,
    required this.rank,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ManagerRadius.r16),
          topRight: Radius.circular(ManagerRadius.r16),
        ),
        child: SizedBox(
          width: double.infinity,
          height: ManagerHeight.h210,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background cover image ─────────────────────────────
              store.coverImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: store.coverImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => _CoverPlaceholder(),
                      errorWidget: (_, __, ___) => _CoverPlaceholder(),
                    )
                  : _CoverPlaceholder(),

              // ── Bottom gradient scrim ──────────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.20),
                      Colors.black.withOpacity(0.82),
                    ],
                    stops: const [0.35, 0.60, 1.0],
                  ),
                ),
              ),

              // ── Top: rank badge + status badge ─────────────────────
              Positioned(
                top: ManagerHeight.h12,
                right: ManagerWidth.w12,
                child: _RankBadge(rank: rank),
              ),
              Positioned(
                top: ManagerHeight.h12,
                left: ManagerWidth.w12,
                child: _StatusBadge(isAvailable: store.isAvailable),
              ),

              // ── Bottom: store name + rating ────────────────────────
              Positioned(
                bottom: ManagerHeight.h14,
                left: ManagerWidth.w16,
                right: ManagerWidth.w16,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s20,
                        color: ManagerColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ManagerHeight.h6),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: ManagerWidth.w16,
                          color: const Color(0xFFFFD700),
                        ),
                        SizedBox(width: ManagerWidth.w3),
                        Text(
                          store.rating.toStringAsFixed(1),
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.white,
                          ),
                        ),
                        SizedBox(width: ManagerWidth.w4),
                        Text(
                          '(${store.reviewCount})',
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.white.withOpacity(0.75),
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
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.08),
      child: Center(
        child: Icon(
          Icons.storefront_rounded,
          size: 52,
          color: ManagerColors.primaryColor.withOpacity(0.25),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Rank Badge  (#1 / #2 / #3 with gold gradient)
// ═══════════════════════════════════════════════════════════════════════════════

class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});

  static const _rankColors = {
    1: [Color(0xFFFFD700), Color(0xFFFF8C00)],
    2: [Color(0xFFB0BEC5), Color(0xFF78909C)],
    3: [Color(0xFFCD7F32), Color(0xFF8B4513)],
  };

  @override
  Widget build(BuildContext context) {
    final colors =
        _rankColors[rank] ?? [ManagerColors.primaryColor, ManagerColors.primaryColor];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        boxShadow: [
          BoxShadow(
            color: colors.first.withOpacity(0.40),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            rank == 1
                ? Icons.workspace_premium_rounded
                : Icons.military_tech_rounded,
            color: Colors.white,
            size: ManagerWidth.w13,
          ),
          SizedBox(width: ManagerWidth.w3),
          Text(
            '#$rank',
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s11,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Availability Status Badge
// ═══════════════════════════════════════════════════════════════════════════════

class _StatusBadge extends StatelessWidget {
  final bool isAvailable;
  const _StatusBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        color: isAvailable
            ? const Color(0xFF27AE60).withOpacity(0.90)
            : Colors.red.withOpacity(0.80),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: ManagerWidth.w6,
            height: ManagerWidth.w6,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: ManagerWidth.w5),
          Text(
            isAvailable ? ManagerStrings.storeOpen : ManagerStrings.storeClosed,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Store Stats Row (products count + completed orders)
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreStatsRow extends StatelessWidget {
  final BestSellingStoreModel store;
  const _StoreStatsRow({required this.store});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatChip(
          icon: Icons.inventory_2_outlined,
          label: '${store.productCount} ${ManagerStrings.bestSellingStoreProductCount}',
          color: ManagerColors.primaryColor,
        ),
        if (store.completedOrdersCount > 0) ...[
          SizedBox(width: ManagerWidth.w10),
          _StatChip(
            icon: Icons.check_circle_outline_rounded,
            label: '${store.completedOrdersCount} ${ManagerStrings.tailorCompletedOrders}',
            color: const Color(0xFF27AE60),
          ),
        ],
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: ManagerWidth.w13, color: color),
          SizedBox(width: ManagerWidth.w5),
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s11,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Specializations Tags
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreTags extends StatelessWidget {
  final List<String> tags;
  const _StoreTags({required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: ManagerWidth.w8,
      runSpacing: ManagerHeight.h4,
      children: tags.map((tag) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w11,
            vertical: ManagerHeight.h4,
          ),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.07),
            borderRadius: BorderRadius.circular(ManagerRadius.r20),
            border: Border.all(
              color: ManagerColors.primaryColor.withOpacity(0.18),
              width: 1,
            ),
          ),
          child: Text(
            tag,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s11,
              color: ManagerColors.primaryColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Products Section Header
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreProductsHeader extends StatelessWidget {
  final int productCount;
  const _StoreProductsHeader({required this.productCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          ManagerStrings.bestSellingStoreProducts,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.black,
          ),
        ),
        Text(
          '$productCount ${ManagerStrings.bestSellingStoreProductCount}',
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Product Thumbnails (horizontal scroll)
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreProductThumbnails extends StatelessWidget {
  final List<ProductItemModel> products;
  final void Function(ProductItemModel product)? onProductTap;

  const _StoreProductThumbnails({
    required this.products,
    this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ManagerHeight.h130,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w10),
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductThumbnail(
            product: product,
            onTap: () => onProductTap?.call(product),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Single Product Thumbnail — image + price + best-seller badge
// ═══════════════════════════════════════════════════════════════════════════════

class _ProductThumbnail extends StatelessWidget {
  final ProductItemModel product;
  final VoidCallback? onTap;

  const _ProductThumbnail({required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: ManagerWidth.w95,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Image ───────────────────────────────────────────────
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Product image
                    product.imageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: product.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => _ProductImagePlaceholder(),
                            errorWidget: (_, __, ___) =>
                                _ProductImagePlaceholder(),
                          )
                        : _ProductImagePlaceholder(),

                    // Price badge — bottom-left
                    Positioned(
                      bottom: ManagerHeight.h5,
                      left: ManagerWidth.w5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w7,
                          vertical: ManagerHeight.h3,
                        ),
                        decoration: BoxDecoration(
                          color: ManagerColors.primaryColor,
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r8),
                        ),
                        child: Text(
                          '${product.price.toStringAsFixed(0)} ${ManagerStrings.userHomeCurrency}',
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s9,
                            color: ManagerColors.white,
                          ),
                        ),
                      ),
                    ),

                    // Best seller badge — top-right corner
                    if (product.isBestSeller)
                      Positioned(
                        top: ManagerHeight.h5,
                        right: ManagerWidth.w5,
                        child: Container(
                          padding: EdgeInsets.all(ManagerWidth.w4),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFD700), Color(0xFFFFAA00)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r6),
                          ),
                          child: CustomSvgImage(
                            path: ManagerIcons.bestSellerIcon,
                            width: ManagerWidth.w10,
                            height: ManagerWidth.w10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // ── Product name ─────────────────────────────────────────
            SizedBox(height: ManagerHeight.h5),
            Text(
              product.name,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s10,
                color: ManagerColors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.06),
      child: Center(
        child: Icon(
          Icons.checkroom_rounded,
          color: ManagerColors.primaryColor.withOpacity(0.25),
          size: ManagerWidth.w24,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Browse Store Button
// ═══════════════════════════════════════════════════════════════════════════════

class _BrowseStoreButton extends StatelessWidget {
  final VoidCallback? onTap;
  const _BrowseStoreButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h13),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ManagerColors.primaryColor,
              ManagerColors.primaryColor.withOpacity(0.85),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.primaryColor.withOpacity(0.28),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ManagerStrings.bestSellingStoreBrowseAll,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.white,
              ),
            ),
            SizedBox(width: ManagerWidth.w8),
            Icon(
              Icons.arrow_forward_rounded,
              size: ManagerWidth.w16,
              color: ManagerColors.white,
            ),
          ],
        ),
      ),
    );
  }
}
