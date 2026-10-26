import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/product_card_widget.dart';
import 'package:app_mobile/features/user/details_shop/domain/model/shop_details_model.dart';
import 'package:app_mobile/features/user/details_shop/presentation/controller/shop_details_controller.dart';
import 'package:app_mobile/features/user/product_details/presentation/widgets/add_to_cart_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ── Design tokens ──────────────────────────────────────────────────────────────
const Color _kGapColor    = Color(0xFFF2F2F2);
const Color _kDivider     = Color(0xFFEEEEEE);
const Color _kBodyText    = Color(0xFF444444);
const Color _kPrimaryTeal = Color(0xFF007A6C); // gradient end for primary
const Color _kGold        = Color(0xFFF9A825);
const Color _kGreenOpen   = Color(0xFF43A047);
const Color _kShimBase    = Color(0xFFE8E8E8);
const Color _kShimHigh    = Color(0xFFF5F5F5);

// ══════════════════════════════════════════════════════════════════════════════
// LOADING BODY — shimmer skeleton mirroring the new layout
// ══════════════════════════════════════════════════════════════════════════════

Widget _shimBox({double? w, double? h, double r = 8}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

class ShopDetailsLoadingBody extends StatelessWidget {
  const ShopDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final sw        = MediaQuery.of(context).size.width;
    final statusH   = MediaQuery.of(context).padding.top;
    // collapsed appbar height matches SliverAppBar kToolbarHeight
    const appBarH   = kToolbarHeight;

    return Column(
      children: [
        // ── Collapsed AppBar skeleton (primaryColor — not shimmer) ─────────────
        Container(
          color: ManagerColors.primaryColor,
          height: statusH + appBarH,
          padding: EdgeInsets.only(top: statusH),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: ManagerWidth.w8),
              // Back button rectangle
              Container(
                width: ManagerWidth.w34,
                height: ManagerHeight.h34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: ManagerWidth.w10),
              // Title + subtitle column
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Container(
                    width: 90,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // ── Scrollable shimmer content ─────────────────────────────────────────
        Expanded(
          child: Shimmer.fromColors(
            baseColor: _kShimBase,
            highlightColor: _kShimHigh,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Cover photo with avatar/name/badge overlay ──────────────
                  SizedBox(
                    height: ManagerHeight.h260,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: Colors.white),
                        Positioned(
                          bottom: ManagerHeight.h20,
                          left: ManagerWidth.w16,
                          right: ManagerWidth.w16,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Avatar circle (98px outer with ring)
                              Container(
                                width: 98,
                                height: 98,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(height: ManagerHeight.h10),
                              // Shop name
                              _shimBox(w: 150, h: 20),
                              SizedBox(height: ManagerHeight.h8),
                              // Status badge pill
                              _shimBox(w: 90, h: 26, r: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Info panel ───────────────────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      ManagerWidth.w16, ManagerHeight.h20,
                      ManagerWidth.w16, ManagerHeight.h20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats row — icon circle + value + label × 3, dividers
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              _buildStatCol(),
                              Container(width: 1, height: 44, color: Colors.white),
                              _buildStatCol(),
                              Container(width: 1, height: 44, color: Colors.white),
                              _buildStatCol(),
                            ],
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        // Trust strip — 3 icon+label badges with dividers
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w14,
                            vertical: ManagerHeight.h10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(ManagerRadius.r12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTrustBadge(w: 58),
                              Container(width: 1, height: 20, color: Colors.white),
                              _buildTrustBadge(w: 58),
                              Container(width: 1, height: 20, color: Colors.white),
                              _buildTrustBadge(w: 44),
                            ],
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        // Subtitle — 1 centered text line
                        Center(child: _shimBox(w: sw * 0.55, h: 12)),
                        SizedBox(height: ManagerHeight.h8),
                        // Contact button
                        _shimBox(w: double.infinity, h: 58, r: 14),
                      ],
                    ),
                  ),

                  // ── Gap ──────────────────────────────────────────────────────
                  Container(height: 8, color: _kGapColor),

                  // ── Content section ──────────────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      ManagerWidth.w16, ManagerHeight.h20,
                      ManagerWidth.w16, ManagerHeight.h20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section header 1: accent bar + icon circle + label
                        _buildSectionHeader(labelW: 100),
                        SizedBox(height: ManagerHeight.h12),
                        _shimBox(w: double.infinity, h: 13),
                        SizedBox(height: ManagerHeight.h8),
                        _shimBox(w: sw * 0.70, h: 13),
                        SizedBox(height: ManagerHeight.h20),
                        // Section header 2
                        _buildSectionHeader(labelW: 120),
                        SizedBox(height: ManagerHeight.h12),
                        // Spec chips
                        Wrap(
                          spacing: ManagerWidth.w8,
                          runSpacing: ManagerHeight.h8,
                          children: List.generate(
                              4, (_) => _shimBox(w: 80, h: 32, r: 8)),
                        ),
                        SizedBox(height: ManagerHeight.h20),
                        // Meta row 1 — circle icon + text
                        Row(children: [
                          _shimBox(w: 32, h: 32, r: 16),
                          SizedBox(width: ManagerWidth.w10),
                          _shimBox(w: sw * 0.50, h: 14),
                        ]),
                        SizedBox(height: ManagerHeight.h10),
                        // Meta row 2
                        Row(children: [
                          _shimBox(w: 32, h: 32, r: 16),
                          SizedBox(width: ManagerWidth.w10),
                          _shimBox(w: sw * 0.40, h: 14),
                        ]),
                      ],
                    ),
                  ),

                  // ── Gap ──────────────────────────────────────────────────────
                  Container(height: 8, color: _kGapColor),

                  // ── Category tabs ─────────────────────────────────────────────
                  SizedBox(
                    height: 54,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h10,
                      ),
                      children: List.generate(
                        4,
                        (i) => Container(
                          width: i == 0 ? 88 : 70,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ── Product grid ──────────────────────────────────────────────
                  Padding(
                    padding: EdgeInsets.all(ManagerWidth.w16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ManagerWidth.w10,
                        mainAxisSpacing: ManagerHeight.h10,
                        childAspectRatio: 0.54,
                      ),
                      itemCount: 4,
                      itemBuilder: (_, __) => Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(ManagerRadius.r12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image area
                            Expanded(
                              flex: 6,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(ManagerRadius.r12),
                                  ),
                                ),
                              ),
                            ),
                            // Text content
                            Expanded(
                              flex: 4,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _shimBox(w: double.infinity, h: 12),
                                    _shimBox(w: 70, h: 12),
                                    Row(children: [
                                      _shimBox(w: 55, h: 14),
                                      const Spacer(),
                                      _shimBox(w: 28, h: 28, r: 14),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Private helper builders ────────────────────────────────────────────────

  Widget _buildStatCol() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _shimBox(w: 38, h: 38, r: 19),
            SizedBox(height: ManagerHeight.h7),
            _shimBox(w: 38, h: 16),
            SizedBox(height: ManagerHeight.h3),
            _shimBox(w: 54, h: 11),
          ],
        ),
      );

  Widget _buildTrustBadge({required double w}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _shimBox(w: 15, h: 15, r: 4),
          SizedBox(width: ManagerWidth.w5),
          _shimBox(w: w, h: 12),
        ],
      );

  Widget _buildSectionHeader({required double labelW}) => Row(
        children: [
          Container(width: 3, height: 18, color: Colors.white),
          SizedBox(width: ManagerWidth.w8),
          _shimBox(w: 30, h: 30, r: 15),
          SizedBox(width: ManagerWidth.w8),
          _shimBox(w: labelW, h: 16),
        ],
      );
}

// ══════════════════════════════════════════════════════════════════════════════
// LOADED BODY — StatefulWidget for entrance animation
// ══════════════════════════════════════════════════════════════════════════════

class ShopDetailsLoadedBody extends StatefulWidget {
  final ShopDetailsController controller;
  const ShopDetailsLoadedBody({super.key, required this.controller});

  @override
  State<ShopDetailsLoadedBody> createState() => _ShopDetailsLoadedBodyState();
}

class _ShopDetailsLoadedBodyState extends State<ShopDetailsLoadedBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 500))
      ..forward();
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ctrl = widget.controller;
      final shop = ctrl.shop.value;
      if (shop == null) {
        return _ShopDetailsErrorState(
          message: ctrl.errorMessage.value,
          onRetry: ctrl.fetchShopDetails,
        );
      }
      return Directionality(
        textDirection: Directionality.of(context),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: RefreshIndicator(
              onRefresh: ctrl.fetchShopDetails,
              color: ManagerColors.primaryColor,
              backgroundColor: ManagerColors.white,
              displacement: 80,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  // ── Hero AppBar ────────────────────────────────────────
                  SliverAppBar(
                    expandedHeight: ManagerHeight.h260,
                    pinned: true,
                    backgroundColor: ManagerColors.primaryColor,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: EdgeInsets.all(ManagerWidth.w8),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: ManagerHeight.h34,
                          width: ManagerWidth.w34,
                          padding: EdgeInsets.all(ManagerWidth.w4),
                          decoration: BoxDecoration(
                            color: ManagerColors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: ManagerColors.white,
                            size: ManagerHeight.h24,
                          ),
                        ),
                      ),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          shop.name,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (shop.address.isNotEmpty) ...[
                          SizedBox(height: ManagerHeight.h4),
                          Text(
                            shop.address,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s10,
                              color: ManagerColors.white.withOpacity(0.9),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: _ShopHeroBackground(shop: shop),
                    ),
                  ),

                  // ── Info Panel (stats + trust + CTA) ──────────────────
                  SliverToBoxAdapter(
                    child: _ShopInfoPanel(shop: shop, controller: ctrl),
                  ),

                  // ── Visual separator ───────────────────────────────────
                  SliverToBoxAdapter(
                    child: Container(height: 8, color: _kGapColor),
                  ),

                  // ── Bio / Specializations / Meta ───────────────────────
                  SliverToBoxAdapter(
                    child: _ShopContentSections(shop: shop),
                  ),

                  // ── Visual separator (only if content existed) ─────────
                  if (shop.bio.isNotEmpty ||
                      shop.specializations.isNotEmpty ||
                      shop.address.isNotEmpty ||
                      shop.createdAt.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Container(height: 8, color: _kGapColor),
                    ),

                  // ── Sticky Category Tabs ───────────────────────────────
                  if (shop.categories.isNotEmpty)
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _CategoryTabsDelegate(
                        categories: shop.categories,
                        controller: ctrl,
                      ),
                    ),

                  // ── Products Grid ──────────────────────────────────────
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w16,
                      vertical: ManagerHeight.h12,
                    ),
                    sliver: Obx(() {
                      final products = ctrl.displayedProducts;
                      if (products.isEmpty) {
                        return SliverToBoxAdapter(
                          child: _EmptyProductsState(),
                        );
                      }
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final p = products[index];
                            return ProductCardWidget(
                              product: p.toProductItemModel(),
                              onTap: () => Navigator.pushNamed(
                                context,
                                Routes.productDetailsScreen,
                                arguments: p.id,
                              ),
                              onAddToCart: () => showAddToCartSheet(
                                context,
                                productId: p.id,
                              ),
                            );
                          },
                          childCount: products.length,
                        ),
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: ManagerWidth.w10,
                          mainAxisSpacing: ManagerHeight.h10,
                          childAspectRatio: 0.54,
                        ),
                      );
                    }),
                  ),

                  SliverToBoxAdapter(child: SizedBox(height: ManagerHeight.h40)),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ERROR STATE
// ══════════════════════════════════════════════════════════════════════════════

class _ShopDetailsErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _ShopDetailsErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.store_mall_directory_outlined,
              size: ManagerWidth.w48,
              color: ManagerColors.greyWhiteColor,
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              message.isNotEmpty
                  ? message
                  : ManagerStrings.detailsShopNoProducts,
              textAlign: TextAlign.center,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(ManagerStrings.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor,
                foregroundColor: ManagerColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HERO BACKGROUND — cover photo + gradient + centered avatar + status badge
// ══════════════════════════════════════════════════════════════════════════════

class _ShopHeroBackground extends StatelessWidget {
  final ShopDetailsModel shop;
  const _ShopHeroBackground({required this.shop});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _ShopCoverImage(imageUrl: shop.coverImageUrl),
          // Gradient scrim — subtle at top, strong at bottom
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.45, 1.0],
                colors: [
                  Color(0x22000000),
                  Color(0x44000000),
                  Color(0xCC000000),
                ],
              ),
            ),
          ),
          // Avatar + name + status at the bottom-center
          Positioned(
            bottom: ManagerHeight.h20,
            left: ManagerWidth.w16,
            right: ManagerWidth.w16,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ShopAvatarWithRing(imageUrl: shop.imageUrl, isOpen: shop.isOpen),
                SizedBox(height: ManagerHeight.h10),
                Text(
                  shop.name,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h6),
                _StatusBadge(isOpen: shop.isOpen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShopCoverImage extends StatelessWidget {
  final String? imageUrl;
  const _ShopCoverImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) return _CoverPlaceholder();
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      placeholder: (_, __) => _CoverPlaceholder(),
      errorWidget: (_, __, ___) => _CoverPlaceholder(),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ManagerImages.backgroundShopImage,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
    );
  }
}

// ── Animated avatar with pulsing ring when shop is open ───────────────────────

class _ShopAvatarWithRing extends StatefulWidget {
  final String? imageUrl;
  final bool isOpen;
  const _ShopAvatarWithRing({required this.imageUrl, required this.isOpen});

  @override
  State<_ShopAvatarWithRing> createState() => _ShopAvatarWithRingState();
}

class _ShopAvatarWithRingState extends State<_ShopAvatarWithRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _scale = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    if (widget.isOpen) _pulse.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringColor = widget.isOpen ? _kGreenOpen : ManagerColors.greyWhiteColor;
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) => Transform.scale(
        scale: widget.isOpen ? _scale.value : 1.0,
        child: child,
      ),
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: ringColor.withOpacity(0.40),
              blurRadius: 14,
              spreadRadius: widget.isOpen ? 3 : 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: ClipOval(
          child: (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: widget.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _AvatarPlaceholder(),
                  errorWidget: (_, __, ___) => _AvatarPlaceholder(),
                )
              : _AvatarPlaceholder(),
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.10),
      child: Center(
        child: CustomSvgImage(
          path: ManagerImages.logo,
          width: 38,
          height: 38,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final bool isOpen;
  const _StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? _kGreenOpen : ManagerColors.greyWhiteColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        border: Border.all(color: color.withOpacity(0.55), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: ManagerWidth.w6),
          Text(
            isOpen
                ? ManagerStrings.detailsShopOpen
                : ManagerStrings.detailsShopClosed,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// INFO PANEL — stats · trust strip · contact CTA
// ══════════════════════════════════════════════════════════════════════════════

class _ShopInfoPanel extends StatelessWidget {
  final ShopDetailsModel shop;
  final ShopDetailsController controller;
  const _ShopInfoPanel({required this.shop, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h20,
        ManagerWidth.w16, ManagerHeight.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ShopStatsRow(shop: shop),
          SizedBox(height: ManagerHeight.h16),
          _TrustStrip(shop: shop),
          SizedBox(height: ManagerHeight.h16),
          // Subtitle above CTA
          Text(
            ManagerStrings.detailsShopContactSubtitle,
            textAlign: TextAlign.center,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h8),
          _ContactCtaButton(controller: controller),
        ],
      ),
    );
  }
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _ShopStatsRow extends StatelessWidget {
  final ShopDetailsModel shop;
  const _ShopStatsRow({required this.shop});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _StatItem(
            value: '${shop.productsCount}',
            label: ManagerStrings.detailsShopProductsStat,
            icon: Icons.grid_view_rounded,
            iconColor: ManagerColors.primaryColor,
          ),
          _VerticalDivider(),
          _StatItem(
            value: '${shop.completedOrdersCount}',
            label: ManagerStrings.detailsShopOrdersStat,
            icon: Icons.check_circle_outline_rounded,
            iconColor: ManagerColors.primaryColor,
          ),
          _VerticalDivider(),
          _StarStatItem(
            rating: shop.rating,
            ratersCount: shop.ratersCount,
            label: ManagerStrings.detailsShopRatingStat,
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: _kDivider,
      margin: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.09),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 19),
          ),
          SizedBox(height: ManagerHeight.h7),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
            child: Text(
              label,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _StarStatItem extends StatelessWidget {
  final double rating;
  final int ratersCount;
  final String label;
  const _StarStatItem(
      {required this.rating, required this.ratersCount, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF8E1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.star_rounded, color: _kGold, size: 21),
          ),
          SizedBox(height: ManagerHeight.h7),
          Text(
            rating.toStringAsFixed(1),
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
            child: Text(
              '$ratersCount $label',
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Trust strip ───────────────────────────────────────────────────────────────

class _TrustStrip extends StatelessWidget {
  final ShopDetailsModel shop;
  const _TrustStrip({required this.shop});

  @override
  Widget build(BuildContext context) {
    final badges = <({IconData icon, String label, Color color})>[];

    if (shop.completedOrdersCount > 0) {
      badges.add((
        icon: Icons.verified_outlined,
        label: ManagerStrings.provenExperience,
        color: ManagerColors.primaryColor,
      ));
    }
    if (shop.rating >= 4.0) {
      badges.add((
        icon: Icons.star_half_rounded,
        label: ManagerStrings.highRating,
        color: _kGold,
      ));
    }
    badges.add((
      icon: Icons.lock_outline_rounded,
      label: ManagerStrings.securePayment,
      color: ManagerColors.primaryColor,
    ));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9F7),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < badges.length; i++) ...[
            _TrustBadge(
              icon: badges[i].icon,
              label: badges[i].label,
              color: badges[i].color,
            ),
            if (i < badges.length - 1)
              Container(
                width: 1,
                height: 20,
                margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w6),
                color: ManagerColors.primaryColor.withOpacity(0.18),
              ),
          ],
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TrustBadge(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        SizedBox(width: ManagerWidth.w5),
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s11,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

// ── Contact CTA button — sweep-light + bouncing icon + press-scale ────────────

class _ContactCtaButton extends StatefulWidget {
  final ShopDetailsController controller;
  const _ContactCtaButton({required this.controller});

  @override
  State<_ContactCtaButton> createState() => _ContactCtaButtonState();
}

class _ContactCtaButtonState extends State<_ContactCtaButton>
    with TickerProviderStateMixin {
  late final AnimationController _press;
  late final AnimationController _sweep;
  late final AnimationController _bounce;
  late final Animation<double> _scale;
  late final Animation<double> _sweepPos;
  late final Animation<double> _bounceY;

  @override
  void initState() {
    super.initState();

    // Press scale
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );

    // Sweep: bright light stripe slides across every 3 s
    _sweep = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
    _sweepPos = CurvedAnimation(
      parent: _sweep,
      curve: const Interval(0.0, 0.75, curve: Curves.easeInOut),
    );

    // Icon bounce: hops up then settles, repeats every 2.5 s
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _bounceY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -5.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 18),
      TweenSequenceItem(
          tween: Tween(begin: -5.0, end: 0.0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 22),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 60),
    ]).animate(_bounce);
  }

  @override
  void dispose() {
    _press.dispose();
    _sweep.dispose();
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = widget.controller.isChatLoading.value;

      return GestureDetector(
        onTapDown: isLoading ? null : (_) => _press.forward(),
        onTapUp: isLoading ? null : (_) => _press.reverse(),
        onTapCancel: isLoading ? null : () => _press.reverse(),
        onTap: isLoading ? null : () => widget.controller.startChat(),
        child: AnimatedBuilder(
          animation: _scale,
          builder: (_, child) =>
              Transform.scale(scale: _scale.value, child: child),
          child: Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: isLoading
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDBDBD),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  )
                : LayoutBuilder(
                    builder: (ctx, constraints) {
                      final btnW = constraints.maxWidth;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Base gradient
                            Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    ManagerColors.primaryColor,
                                    _kPrimaryTeal,
                                  ],
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                ),
                              ),
                            ),

                            // Top-edge highlight line
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.white.withOpacity(0),
                                      Colors.white.withOpacity(0.30),
                                      Colors.white.withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // Sweep light beam
                            AnimatedBuilder(
                              animation: _sweepPos,
                              builder: (_, __) {
                                final left =
                                    _sweepPos.value * (btnW + 90) - 90;
                                return Positioned(
                                  top: 0,
                                  bottom: 0,
                                  left: left,
                                  child: Container(
                                    width: 90,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.white.withOpacity(0.0),
                                          Colors.white.withOpacity(0.20),
                                          Colors.white.withOpacity(0.0),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Icon + label (icon bounces on idle)
                            Center(
                              child: AnimatedBuilder(
                                animation: _bounceY,
                                builder: (_, child) => Transform.translate(
                                  offset: Offset(0, _bounceY.value),
                                  child: child,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: ManagerWidth.w10),
                                    Text(
                                      ManagerStrings.detailsShopContact,
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CONTENT SECTIONS — bio · specializations · meta
// ══════════════════════════════════════════════════════════════════════════════

class _ShopContentSections extends StatelessWidget {
  final ShopDetailsModel shop;
  const _ShopContentSections({required this.shop});

  @override
  Widget build(BuildContext context) {
    final hasBio  = shop.bio.isNotEmpty;
    final hasSpc  = shop.specializations.isNotEmpty;
    final hasMeta = shop.address.isNotEmpty || shop.createdAt.isNotEmpty;

    if (!hasBio && !hasSpc && !hasMeta) return const SizedBox.shrink();

    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h20,
        ManagerWidth.w16, ManagerHeight.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bio
          if (hasBio) ...[
            _SectionHeader(
              title: ManagerStrings.detailsShopAbout,
              icon: Icons.info_outline_rounded,
            ),
            SizedBox(height: ManagerHeight.h10),
            Text(
              shop.bio,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: _kBodyText,
              ),
              textDirection: Directionality.of(context),
            ),
            SizedBox(height: ManagerHeight.h20),
          ],
          if (hasBio && hasSpc)
            const Divider(height: 1, thickness: 1, color: _kDivider),
          // Specializations
          if (hasSpc) ...[
            SizedBox(height: ManagerHeight.h16),
            _SectionHeader(
              title: ManagerStrings.detailsShopSpecializations,
              icon: Icons.category_outlined,
            ),
            SizedBox(height: ManagerHeight.h12),
            Wrap(
              spacing: ManagerWidth.w8,
              runSpacing: ManagerHeight.h8,
              children:
                  shop.specializations.map((s) => _SpecChip(label: s)).toList(),
            ),
            SizedBox(height: ManagerHeight.h20),
          ],
          if ((hasBio || hasSpc) && hasMeta)
            const Divider(height: 1, thickness: 1, color: _kDivider),
          // Meta
          if (hasMeta) ...[
            SizedBox(height: ManagerHeight.h16),
            if (shop.address.isNotEmpty)
              _MetaItem(
                  icon: Icons.location_on_outlined, text: shop.address),
            if (shop.address.isNotEmpty && shop.createdAt.isNotEmpty)
              SizedBox(height: ManagerHeight.h10),
            if (shop.createdAt.isNotEmpty)
              _MetaItem(
                icon: Icons.calendar_today_outlined,
                text:
                    '${ManagerStrings.detailsShopMemberSince} ${shop.createdAt}',
              ),
          ],
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        Icon(icon, size: 17, color: ManagerColors.primaryColor),
        SizedBox(width: ManagerWidth.w6),
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s15,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;
  const _SpecChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h8,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: ManagerColors.primaryColor),
        ),
        SizedBox(width: ManagerWidth.w10),
        Flexible(
          child: Text(
            text,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: _kBodyText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CATEGORY TABS DELEGATE — pinned with drop-shadow on scroll
// ══════════════════════════════════════════════════════════════════════════════

class _CategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  final List<ShopCategoryModel> categories;
  final ShopDetailsController controller;

  const _CategoryTabsDelegate(
      {required this.categories, required this.controller});

  static const double _h = 54.0;

  @override
  double get minExtent => _h;
  @override
  double get maxExtent => _h;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        boxShadow: overlapsContent
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Obx(() {
        final selected = controller.selectedCategoryIndex.value;
        final tabs = [
          ManagerStrings.detailsShopAllProducts,
          ...categories.map((c) => c.name),
        ];
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16,
            vertical: ManagerHeight.h9,
          ),
          itemCount: tabs.length,
          itemBuilder: (ctx, i) {
            final isSelected = i == selected;
            return GestureDetector(
              onTap: () => controller.selectedCategoryIndex.value = i,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.only(left: ManagerWidth.w8),
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h6,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? const LinearGradient(
                          colors: [ManagerColors.primaryColor, _kPrimaryTeal],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        )
                      : null,
                  color: isSelected
                      ? null
                      : ManagerColors.primaryColor.withOpacity(0.07),
                  borderRadius: BorderRadius.circular(ManagerRadius.r20),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: ManagerColors.primaryColor.withOpacity(0.2),
                          width: 1,
                        ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: ManagerColors.primaryColor.withOpacity(0.28),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  tabs[i],
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: isSelected
                        ? Colors.white
                        : ManagerColors.primaryColor,
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  @override
  bool shouldRebuild(covariant _CategoryTabsDelegate old) =>
      old.categories != categories;
}

// ── Empty products placeholder ─────────────────────────────────────────────────

class _EmptyProductsState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.inventory_2_outlined,
                size: 32,
                color: ManagerColors.primaryColor.withOpacity(0.55),
              ),
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              ManagerStrings.detailsShopNoProducts,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
