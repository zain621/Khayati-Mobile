import 'dart:async';

import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/product_card_widget.dart';
import 'package:app_mobile/features/user/home_user/domain/model/home_model.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_best_selling_stores_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_products_grid_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_shimmer_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_shops_list_widget.dart';
import 'package:app_mobile/features/user/shops/domain/di/di.dart';
import 'package:app_mobile/features/user/shops/domain/model/shop_model.dart';
import 'package:app_mobile/features/user/shops/presentation/controller/shops_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen>
    with SingleTickerProviderStateMixin {
  // ── Animation ──────────────────────────────────────────────────────────────
  late final AnimationController _animController;
  late final ShopsController _shopsController;

  // App Bar: slides down from top
  late final Animation<Offset> _headerSlide;
  late final Animation<double> _headerFade;

  // Banner card
  late final Animation<double> _bannerFade;
  late final Animation<Offset> _bannerSlide;

  // Shops list
  late final Animation<double> _shopsFade;
  late final Animation<Offset> _shopsSlide;

  // Best-selling stores
  late final Animation<double> _bestFade;
  late final Animation<Offset> _bestSlide;

  // Products grid
  late final Animation<double> _gridFade;
  late final Animation<Offset> _gridSlide;

  // ── Ads auto-scroll ────────────────────────────────────────────────────────
  final PageController _adsPageController = PageController();
  int _currentAdPage = 0;
  Timer? _adsTimer;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    // ── Header ────────────────────────────────────────────────────────────────
    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.00, 0.38, curve: Curves.easeOut),
    ));
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.00, 0.40, curve: Curves.easeOutCubic),
    ));

    // ── Banner ────────────────────────────────────────────────────────────────
    _bannerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.18, 0.52, curve: Curves.easeOut),
    ));
    _bannerSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.18, 0.55, curve: Curves.easeOutCubic),
    ));

    // ── Shops List ────────────────────────────────────────────────────────────
    _shopsFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.34, 0.68, curve: Curves.easeOut),
    ));
    _shopsSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.34, 0.70, curve: Curves.easeOutCubic),
    ));

    // ── Best Selling ──────────────────────────────────────────────────────────
    _bestFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.50, 0.82, curve: Curves.easeOut),
    ));
    _bestSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.50, 0.84, curve: Curves.easeOutCubic),
    ));

    // ── Products Grid ─────────────────────────────────────────────────────────
    _gridFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.64, 0.96, curve: Curves.easeOut),
    ));
    _gridSlide = Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: const Interval(0.64, 0.98, curve: Curves.easeOutCubic),
    ));

    _animController.forward();

    initShops();
    _shopsController = Get.find<ShopsController>();

    _startAdsTimer();
  }

  void _startAdsTimer() {
    _adsTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_adsPageController.hasClients) return;
      final adCount = _shopsController.ads.length;
      if (adCount <= 1) return;
      final next = (_currentAdPage + 1) % adCount;
      _adsPageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  // ── Mapper: TopShopModel → BestSellingStoreModel ───────────────────────────
  BestSellingStoreModel _toStoreModel(TopShopModel shop) {
    return BestSellingStoreModel(
      id: shop.id,
      name: shop.name,
      imageUrl: shop.imageUrl,
      coverImageUrl: shop.coverImageUrl ?? shop.imageUrl ?? '',
      rating: shop.rating,
      reviewCount: shop.ratersCount,
      productCount: shop.productsCount,
      completedOrdersCount: shop.completedOrdersCount,
      isAvailable: shop.isAvailable,
      tags: shop.specializations,
      products: shop.products
          .map((p) => ProductItemModel(
                id: p.id,
                name: p.name,
                shopName: p.shopName,
                imageUrl: p.imageUrl ?? '',
                price: p.price,
                isBestSeller: p.isBestSelling,
              ))
          .toList(),
    );
  }

  @override
  void dispose() {
    _adsTimer?.cancel();
    _adsPageController.dispose();
    _animController.dispose();
    disposeShops();
    super.dispose();
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: ManagerColors.white,
        body: AnimatedBuilder(
          animation: _animController,
          builder: (context, _) {
            return Column(
              children: [
                // ── App Bar ──────────────────────────────────────────────────
                SlideTransition(
                  position: _headerSlide,
                  child: FadeTransition(
                    opacity: _headerFade,
                    child: const _StoreAppBar(),
                  ),
                ),

                // ── Scrollable Content ───────────────────────────────────────
                Expanded(
                  child: Obx(() {
                    final isLoading = _shopsController.isLoading.value;

                    // ── Unified full-page shimmer (all sections together) ────
                    if (isLoading) {
                      return const SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: _StorePageShimmer(),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: _shopsController.refreshShops,
                      color: ManagerColors.primaryColor,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: ManagerHeight.h12),

                            // ── Banner ───────────────────────────────────────
                            FadeTransition(
                              opacity: _bannerFade,
                              child: SlideTransition(
                                position: _bannerSlide,
                                child: _shopsController.ads.isEmpty
                                    ? _StaticBanner()
                                    : _AdsBanner(
                                        ads: _shopsController.ads,
                                        pageController: _adsPageController,
                                        currentPage: _currentAdPage,
                                        onPageChanged: (p) => setState(
                                            () => _currentAdPage = p),
                                      ),
                              ),
                            ),

                            SizedBox(height: ManagerHeight.h16),

                            // ── Shops List ───────────────────────────────────
                            FadeTransition(
                              opacity: _shopsFade,
                              child: SlideTransition(
                                position: _shopsSlide,
                                child: HomeShopsListWidget(
                                  shops: _shopsController.shops
                                      .map((s) => HomeShopModel(
                                            id: s.id,
                                            name: s.name,
                                            imageUrl: s.imageUrl,
                                            productsCount: s.productsCount,
                                            rating: s.rating,
                                            ratersCount: s.ratersCount,
                                            completedOrdersCount:
                                                s.completedOrdersCount,
                                          ))
                                      .toList(),
                                  onViewAll: () => Get.toNamed(Routes.allShopsScreen),
                                  onShopTap: (shop) => Get.toNamed(
                                    Routes.detailsShop,
                                    arguments: shop.id,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: ManagerHeight.h20),

                            // ── Best Selling Stores ──────────────────────────
                            FadeTransition(
                              opacity: _bestFade,
                              child: SlideTransition(
                                position: _bestSlide,
                                child: Obx(() {
                                  final isTopLoading =
                                      _shopsController.isTopLoading.value;
                                  final realStores = isTopLoading
                                      ? null
                                      : _shopsController.topShops
                                          .where((s) =>
                                              s.name.isNotEmpty &&
                                              s.productsCount > 0)
                                          .map(_toStoreModel)
                                          .toList();
                                  return HomeBestSellingStoresWidget(
                                    stores: realStores,
                                    onViewAll: () {},
                                    onStoreTap: (store) => Get.toNamed(
                                      Routes.detailsShop,
                                      arguments: store.id,
                                    ),
                                    onProductTap: (store, product) =>
                                        Get.toNamed(
                                      Routes.productDetailsScreen,
                                      arguments: product.id,
                                    ),
                                  );
                                }),
                              ),
                            ),

                            // ── Products Grid ────────────────────────────────
                            FadeTransition(
                              opacity: _gridFade,
                              child: SlideTransition(
                                position: _gridSlide,
                                child: HomeProductsGridWidget(
                                  onViewAll: () {},
                                  onProductTap: (product) {},
                                  onAddToCart: (product) {},
                                ),
                              ),
                            ),

                            SizedBox(height: ManagerHeight.h24),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Unified Full-Page Shimmer
// ═══════════════════════════════════════════════════════════════════════════════

class _StorePageShimmer extends StatelessWidget {
  const _StorePageShimmer();

  static const Color _base = Color(0xFFE8E8E8);
  static const Color _high = Color(0xFFF5F5F5);

  static Widget _box({double? w, double h = 12, double r = 8}) => Container(
        width: w ?? double.infinity,
        height: h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(r),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _base,
      highlightColor: _high,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h12),

          // ── Banner ──────────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Container(
              height: ManagerHeight.h190,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h20),

          // ── Shops List header ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _box(w: ManagerWidth.w130, h: ManagerHeight.h16),
                _box(w: ManagerWidth.w60, h: ManagerHeight.h14),
              ],
            ),
          ),
          SizedBox(height: ManagerHeight.h14),

          // ── Shops horizontal list ─────────────────────────────────────────────
          SizedBox(
            height: ManagerHeight.h100,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w10),
              itemBuilder: (_, __) => Column(
                children: [
                  Container(
                    width: ManagerWidth.w66,
                    height: ManagerWidth.w66,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  _box(w: ManagerWidth.w60, h: ManagerHeight.h10),
                ],
              ),
            ),
          ),

          SizedBox(height: ManagerHeight.h24),

          // ── Section header — Best Selling ─────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Row(
              children: [
                Container(
                  width: ManagerWidth.w32,
                  height: ManagerWidth.w32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r10),
                  ),
                ),
                SizedBox(width: ManagerWidth.w10),
                _box(w: ManagerWidth.w150, h: ManagerHeight.h16),
              ],
            ),
          ),
          SizedBox(height: ManagerHeight.h16),

          // ── 2 Store card skeletons ────────────────────────────────────────────
          ...List.generate(2, (_) => _StoreCardShimmer()),
        ],
      ),
    );
  }
}

class _StoreCardShimmer extends StatelessWidget {
  const _StoreCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, 0, ManagerWidth.w16, ManagerHeight.h20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image placeholder
            Container(
              height: ManagerHeight.h210,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ManagerRadius.r16),
                  topRight: Radius.circular(ManagerRadius.r16),
                ),
              ),
            ),
            // Card body
            Padding(
              padding: EdgeInsets.all(ManagerWidth.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stat chips row
                  Row(
                    children: [
                      Container(
                        width: ManagerWidth.w90,
                        height: ManagerHeight.h26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(ManagerRadius.r20),
                        ),
                      ),
                      SizedBox(width: ManagerWidth.w10),
                      Container(
                        width: ManagerWidth.w110,
                        height: ManagerHeight.h26,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(ManagerRadius.r20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ManagerHeight.h12),
                  // Tags
                  Row(
                    children: List.generate(
                      3,
                      (_) => Container(
                        width: ManagerWidth.w60,
                        height: ManagerHeight.h22,
                        margin: EdgeInsets.only(left: ManagerWidth.w6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(ManagerRadius.r20),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h16),
                  // Products row
                  SizedBox(
                    height: ManagerHeight.h110,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      separatorBuilder: (_, __) =>
                          SizedBox(width: ManagerWidth.w10),
                      itemBuilder: (_, __) => Container(
                        width: ManagerWidth.w90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(ManagerRadius.r12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h14),
                  // Browse button
                  Container(
                    height: ManagerHeight.h44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
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
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Store App Bar
// ═══════════════════════════════════════════════════════════════════════════════

class _StoreAppBar extends StatelessWidget {
  const _StoreAppBar();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16,
        topPadding + ManagerHeight.h12,
        ManagerWidth.w16,
        ManagerHeight.h12,
      ),
      decoration: const BoxDecoration(
        color: ManagerColors.primaryColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ManagerStrings.storeTitle,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s20,
              color: ManagerColors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Static Banner (fallback when no ads from API)
// ═══════════════════════════════════════════════════════════════════════════════

class _StaticBanner extends StatelessWidget {
  const _StaticBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        child: Image.asset(
          ManagerImages.continueUserProvider,
          width: double.infinity,
          height: ManagerHeight.h190,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// ── Ads Banner (auto-scrolling PageView from API)
// ═══════════════════════════════════════════════════════════════════════════════

class _AdsBanner extends StatelessWidget {
  final List<AdModel> ads;
  final PageController pageController;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const _AdsBanner({
    required this.ads,
    required this.pageController,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: ManagerHeight.h190,
          child: PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: ads.length,
            itemBuilder: (_, i) => _AdCard(ad: ads[i]),
          ),
        ),
        if (ads.length > 1) ...[
          SizedBox(height: ManagerHeight.h8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(ads.length, (i) {
              final isActive = i == currentPage;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w3),
                width: isActive ? ManagerWidth.w18 : ManagerWidth.w6,
                height: ManagerHeight.h6,
                decoration: BoxDecoration(
                  color: isActive
                      ? ManagerColors.primaryColor
                      : ManagerColors.primaryColor.withOpacity(0.30),
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
              );
            }),
          ),
        ],
      ],
    );
  }
}

class _AdCard extends StatelessWidget {
  final AdModel ad;
  const _AdCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            ad.imageUrl != null && ad.imageUrl!.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: ad.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const _AdPlaceholder(),
                    errorWidget: (_, __, ___) => const _AdPlaceholder(),
                  )
                : const _AdPlaceholder(),
            if (ad.title != null || ad.subtitle != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                    ManagerWidth.w14,
                    ManagerHeight.h24,
                    ManagerWidth.w14,
                    ManagerHeight.h14,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.65),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (ad.title != null)
                        Text(
                          ad.title!,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s15,
                            color: ManagerColors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      if (ad.subtitle != null) ...[
                        SizedBox(height: ManagerHeight.h4),
                        Text(
                          ad.subtitle!,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s12,
                            color: ManagerColors.white.withOpacity(0.85),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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

class _AdPlaceholder extends StatelessWidget {
  const _AdPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.08),
      child: Center(
        child: CustomSvgImage(
          path: ManagerImages.logo,
          width: ManagerWidth.w60,
          height: ManagerWidth.w60,
          color: ManagerColors.primaryColor.withOpacity(0.40),
        ),
      ),
    );
  }
}

