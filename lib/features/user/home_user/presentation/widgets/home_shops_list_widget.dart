import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/features/user/home_user/domain/model/home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeShopsListWidget extends StatelessWidget {
  final List<HomeShopModel>? shops;

  // Called when the user taps "view all"
  final VoidCallback? onViewAll;

  // Called when the user taps a shop card
  final void Function(HomeShopModel shop)? onShopTap;

  const HomeShopsListWidget({
    super.key,
    this.shops,
    this.onViewAll,
    this.onShopTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<HomeShopModel> resolvedShops = shops ?? [];

    if (resolvedShops.isEmpty) return const SizedBox.shrink();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Section title
              Text(
                ManagerStrings.userHomeShopsListTitle,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              // See all button
              GestureDetector(
                onTap: onViewAll,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ManagerStrings.userHomeViewAll,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: ManagerWidth.w16,
                      color: ManagerColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: ManagerHeight.h14),

        // Horizontal scrollable list
        SizedBox(
          height: ManagerHeight.h116,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: resolvedShops.length,
            separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w12),
            itemBuilder: (context, index) {
              return _ShopCard(
                shop: resolvedShops[index],
                onTap: () => onShopTap?.call(resolvedShops[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Shop card widget — Stack: background image + foreground overlay + name label
class _ShopCard extends StatelessWidget {
  final HomeShopModel shop;
  final VoidCallback? onTap;

  const _ShopCard({required this.shop, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        child: SizedBox(
          width: ManagerWidth.w84,
          height: ManagerHeight.h116,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Layer 1: shop background image ────────────────────────
              _ShopBackground(imageUrl: shop.imageUrl),

              // ── Layer 2: green foreground overlay ─────────────────────
              Image.asset(
                ManagerImages.forgroundShopsCard,
                fit: BoxFit.fill,
              ),

              // ── Layer 3: shop name at the bottom ──────────────────────
              Positioned(
                bottom: ManagerHeight.h10,
                left: ManagerWidth.w6,
                right: ManagerWidth.w6,
                child: Text(
                  shop.name,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Background image — network with placeholder fallback
class _ShopBackground extends StatelessWidget {
  final String? imageUrl;

  const _ShopBackground({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final safeUrl = _safeImageUrl(imageUrl);

    if (safeUrl == null) {
      return const _LogoPlaceholder();
    }

    return CachedNetworkImage(
      imageUrl: safeUrl,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 220),
      placeholder: (_, __) => const _ShopImageLoadingPlaceholder(),
      errorWidget: (_, __, ___) => const _LogoPlaceholder(),
    );
  }
}

class _ShopImageLoadingPlaceholder extends StatelessWidget {
  const _ShopImageLoadingPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE4ECE8),
      highlightColor: const Color(0xFFF7FAF8),
      child: Container(
        color: ManagerColors.white,
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: ManagerWidth.w34,
              height: ManagerWidth.w34,
              decoration: const BoxDecoration(
                color: ManagerColors.white,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            Container(
              width: ManagerWidth.w50,
              height: ManagerHeight.h7,
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

class _LogoPlaceholder extends StatelessWidget {
  const _LogoPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.06),
      child: Center(
        child: CustomSvgImage(
          path: ManagerImages.logo,
          width: ManagerWidth.w40,
          height: ManagerWidth.w40,
          color: ManagerColors.primaryColor,
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
