import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/shops/domain/model/shop_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AllShopsShimmer  —  full-screen list of card skeletons while loading
// ─────────────────────────────────────────────────────────────────────────────

class AllShopsShimmer extends StatelessWidget {
  const AllShopsShimmer({super.key});

  static const _kBase = Color(0xFFE0E0E0);
  static const _kHighlight = Color(0xFFF5F5F5);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        separatorBuilder: (_, __) => SizedBox(height: ManagerHeight.h10),
        itemBuilder: (_, __) => const _ShimmerCardSkeleton(),
      ),
    );
  }
}

class _ShimmerCardSkeleton extends StatelessWidget {
  const _ShimmerCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      padding: EdgeInsets.all(ManagerWidth.w14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _SBox(w: ManagerWidth.w130, h: ManagerHeight.h15),
                    SizedBox(width: ManagerWidth.w8),
                    _SBox(
                        w: ManagerWidth.w36,
                        h: ManagerHeight.h15,
                        r: ManagerRadius.r6),
                  ],
                ),
                SizedBox(height: ManagerHeight.h8),
                _SBox(w: ManagerWidth.w80, h: ManagerHeight.h12),
                SizedBox(height: ManagerHeight.h8),
                Row(
                  children: [
                    _SBox(w: ManagerWidth.w40, h: ManagerHeight.h12),
                    SizedBox(width: ManagerWidth.w14),
                    _SBox(w: ManagerWidth.w40, h: ManagerHeight.h12),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          _SBox(
            w: ManagerWidth.w70,
            h: ManagerWidth.w70,
            r: ManagerRadius.r12,
          ),
        ],
      ),
    );
  }
}

class _SBox extends StatelessWidget {
  final double w, h;
  final double? r;

  const _SBox({required this.w, required this.h, this.r});

  @override
  Widget build(BuildContext context) => Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r ?? ManagerRadius.r4),
        ),
      );
}

// ─────────────────────────────────────────────────────────────────────────────
// AnimatedShopCard  —  staggered fade + slide entrance animation per card
// ─────────────────────────────────────────────────────────────────────────────

class AnimatedShopCard extends StatefulWidget {
  final int index;
  final Widget child;

  const AnimatedShopCard({
    super.key,
    required this.index,
    required this.child,
  });

  @override
  State<AnimatedShopCard> createState() => _AnimatedShopCardState();
}

class _AnimatedShopCardState extends State<AnimatedShopCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
    );
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0.0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    Future.delayed(
      Duration(milliseconds: (widget.index * 55).clamp(0, 280)),
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
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllShopCard  —  professional horizontal shop card
// ─────────────────────────────────────────────────────────────────────────────

class AllShopCard extends StatelessWidget {
  final ShopModel shop;
  final VoidCallback? onTap;

  const AllShopCard({super.key, required this.shop, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h5,
      ),
      child: Material(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        elevation: 2,
        shadowColor: Colors.black.withOpacity(0.09),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          splashColor: ManagerColors.primaryColor.withOpacity(0.06),
          highlightColor: ManagerColors.primaryColor.withOpacity(0.04),
          child: Padding(
            padding: EdgeInsets.all(ManagerWidth.w14),
            child: Row(
              children: [
                // ── Info ──────────────────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Name + badge
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              shop.name,
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s15,
                                color: ManagerColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: ManagerWidth.w6),
                          _ShopTypeBadge(),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h6),
                      // Compact rating
                      _CompactRating(
                        rating: shop.rating,
                        ratersCount: shop.ratersCount,
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      // Stats — icon + count only (translation-independent)
                      Row(
                        children: [
                          _StatPill(
                            icon: Icons.inventory_2_outlined,
                            count: shop.productsCount,
                          ),
                          SizedBox(width: ManagerWidth.w14),
                          _StatPill(
                            icon: Icons.task_alt_rounded,
                            count: shop.completedOrdersCount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: ManagerWidth.w12),
                // ── Logo ──────────────────────────────────────────────
                _ShopLogo(imageUrl: shop.imageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopLogo extends StatelessWidget {
  final String? imageUrl;

  const _ShopLogo({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ManagerWidth.w70,
      height: ManagerWidth.w70,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7F5),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(color: const Color(0xFFDCEDEA), width: 1.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r12 - 1.5),
        child: (imageUrl != null && imageUrl!.isNotEmpty)
            ? CachedNetworkImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
                placeholder: (_, __) => const _LogoFallback(),
                errorWidget: (_, __, ___) => const _LogoFallback(),
              )
            : const _LogoFallback(),
      ),
    );
  }
}

class _LogoFallback extends StatelessWidget {
  const _LogoFallback();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(
        Icons.storefront_rounded,
        color: ManagerColors.primaryColor.withOpacity(0.55),
        size: ManagerWidth.w30,
      ),
    );
  }
}

class _ShopTypeBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w7,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.09),
        borderRadius: BorderRadius.circular(ManagerRadius.r6),
      ),
      child: Text(
        ManagerStrings.shopBadge,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s10,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _CompactRating extends StatelessWidget {
  final double rating;
  final int ratersCount;

  const _CompactRating({required this.rating, required this.ratersCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star_rounded,
          color: const Color(0xFFFFC107),
          size: ManagerWidth.w14,
        ),
        SizedBox(width: ManagerWidth.w3),
        Text(
          rating.toStringAsFixed(1),
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.black,
          ),
        ),
        if (ratersCount > 0) ...[
          SizedBox(width: ManagerWidth.w5),
          Text(
            '· $ratersCount',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s11,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  final IconData icon;
  final int count;

  const _StatPill({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: ManagerWidth.w13, color: ManagerColors.greyWhiteColor),
        SizedBox(width: ManagerWidth.w4),
        Text(
          count.toString(),
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// AllShopsEmptyState
// ─────────────────────────────────────────────────────────────────────────────

class AllShopsEmptyState extends StatelessWidget {
  const AllShopsEmptyState({super.key});

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
              Icons.store_mall_directory_outlined,
              size: ManagerWidth.w44,
              color: ManagerColors.primaryColor.withOpacity(0.5),
            ),
          ),
          SizedBox(height: ManagerHeight.h20),
          Text(
            ManagerStrings.allShopsEmptyTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s18,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
            child: Text(
              ManagerStrings.allShopsEmptySubtitle,
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
// AllShopsErrorState
// ─────────────────────────────────────────────────────────────────────────────

class AllShopsErrorState extends StatelessWidget {
  final VoidCallback? onRetry;
  const AllShopsErrorState({super.key, this.onRetry});

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
            ManagerStrings.allShopsLoadError,
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
// AllShopsLoadMoreIndicator
// ─────────────────────────────────────────────────────────────────────────────

class AllShopsLoadMoreIndicator extends StatelessWidget {
  const AllShopsLoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ManagerHeight.h16),
      child: Center(
        child: SizedBox(
          width: ManagerWidth.w24,
          height: ManagerWidth.w24,
          child: CircularProgressIndicator(
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
