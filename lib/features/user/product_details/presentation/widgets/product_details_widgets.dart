import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/features/user/cart/domain/di/di.dart' as cart_di;
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:app_mobile/features/user/product_details/domain/model/product_details_model.dart';
import 'package:app_mobile/features/user/product_details/presentation/controller/product_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ── Design tokens ──────────────────────────────────────────────────────────────
const Color _kGapColor    = Color(0xFFF2F2F2);
const Color _kDivider     = Color(0xFFEEEEEE);
const Color _kBodyText    = Color(0xFF444444);
const Color _kPrimaryTeal = Color(0xFF007A6C);
const Color _kGold        = Color(0xFFF9A825);
const Color _kShimBase    = Color(0xFFE8E8E8);
const Color _kShimHigh    = Color(0xFFF5F5F5);

// ══════════════════════════════════════════════════════════════════════════════
// LOADING SKELETON
// ══════════════════════════════════════════════════════════════════════════════

Widget _shimBox({double? w, double? h, double r = 8}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

class ProductDetailsLoadingBody extends StatelessWidget {
  final VoidCallback onBack;
  const ProductDetailsLoadingBody({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    final sw      = MediaQuery.of(context).size.width;
    final statusH = MediaQuery.of(context).padding.top;
    const appBarH = kToolbarHeight;

    return Column(
      children: [
        // AppBar skeleton
        Container(
          color: ManagerColors.primaryColor,
          height: statusH + appBarH,
          padding: EdgeInsets.only(top: statusH),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: ManagerWidth.w8),
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: ManagerWidth.w34,
                  height: ManagerHeight.h34,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(width: ManagerWidth.w10),
              Container(
                width: 140,
                height: 14,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.30),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: Shimmer.fromColors(
            baseColor: _kShimBase,
            highlightColor: _kShimHigh,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image gallery
                  Container(height: 280, color: Colors.white),

                  Container(height: 8, color: Colors.white),

                  // Product header
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ManagerWidth.w16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimBox(w: sw * 0.70, h: 20),
                        SizedBox(height: ManagerHeight.h10),
                        _shimBox(w: sw * 0.45, h: 16),
                        SizedBox(height: ManagerHeight.h10),
                        Row(children: [
                          _shimBox(w: 80, h: 28, r: 6),
                          SizedBox(width: ManagerWidth.w10),
                          _shimBox(w: 60, h: 22, r: 6),
                        ]),
                      ],
                    ),
                  ),

                  Container(height: 8, color: _kGapColor),

                  // Meta section
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ManagerWidth.w14),
                    child: Column(
                      children: List.generate(
                        3,
                        (i) => Padding(
                          padding: EdgeInsets.only(bottom: ManagerHeight.h12),
                          child: Row(children: [
                            _shimBox(w: 32, h: 32, r: 16),
                            SizedBox(width: ManagerWidth.w10),
                            _shimBox(w: 80, h: 13),
                            SizedBox(width: ManagerWidth.w6),
                            _shimBox(w: 120, h: 13),
                          ]),
                        ),
                      ),
                    ),
                  ),

                  Container(height: 8, color: _kGapColor),

                  // Variant selectors
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ManagerWidth.w14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _shimBox(w: 100, h: 16),
                        SizedBox(height: ManagerHeight.h12),
                        Row(
                          children: List.generate(
                            4,
                            (_) => Container(
                              width: 36,
                              height: 36,
                              margin: EdgeInsets.only(left: ManagerWidth.w8),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        _shimBox(w: 100, h: 16),
                        SizedBox(height: ManagerHeight.h12),
                        Row(
                          children: List.generate(
                            4,
                            (_) => Container(
                              width: 55,
                              height: 36,
                              margin: EdgeInsets.only(left: ManagerWidth.w8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(ManagerRadius.r8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(height: 8, color: _kGapColor),

                  // Qty + expandable sections
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(ManagerWidth.w14),
                    child: Column(
                      children: [
                        _shimBox(w: double.infinity, h: 50, r: 8),
                        SizedBox(height: ManagerHeight.h10),
                        _shimBox(w: double.infinity, h: 50, r: 8),
                        SizedBox(height: ManagerHeight.h10),
                        _shimBox(w: double.infinity, h: 50, r: 8),
                      ],
                    ),
                  ),

                  SizedBox(height: ManagerHeight.h100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// LOADED BODY — entrance animation
// ══════════════════════════════════════════════════════════════════════════════

class ProductDetailsLoadedBody extends StatefulWidget {
  final ProductDetailsController controller;
  final PageController pageController;
  final RxInt currentImageIndex;

  const ProductDetailsLoadedBody({
    super.key,
    required this.controller,
    required this.pageController,
    required this.currentImageIndex,
  });

  @override
  State<ProductDetailsLoadedBody> createState() =>
      _ProductDetailsLoadedBodyState();
}

class _ProductDetailsLoadedBodyState extends State<ProductDetailsLoadedBody>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final AnimationController _sectionsCtrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;
  late final Animation<double> _headerAnim;
  late final Animation<double> _metaAnim;
  late final Animation<double> _ctaAnim;
  late final Animation<double> _variantsAnim;
  late final Animation<double> _infoAnim;
  final ScrollController _scrollCtrl = ScrollController();
  bool _appBarScrolled = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    )..forward();
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));

    _sectionsCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _headerAnim   = CurvedAnimation(parent: _sectionsCtrl,
        curve: const Interval(0.00, 0.50, curve: Curves.easeOutCubic));
    _metaAnim     = CurvedAnimation(parent: _sectionsCtrl,
        curve: const Interval(0.18, 0.62, curve: Curves.easeOutCubic));
    _ctaAnim      = CurvedAnimation(parent: _sectionsCtrl,
        curve: const Interval(0.32, 0.74, curve: Curves.easeOutCubic));
    _variantsAnim = CurvedAnimation(parent: _sectionsCtrl,
        curve: const Interval(0.46, 0.88, curve: Curves.easeOutCubic));
    _infoAnim     = CurvedAnimation(parent: _sectionsCtrl,
        curve: const Interval(0.58, 1.00, curve: Curves.easeOutCubic));

    _scrollCtrl.addListener(() {
      final scrolled = _scrollCtrl.offset > 300;
      if (scrolled != _appBarScrolled) {
        setState(() => _appBarScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _sectionsCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  /// Opens a full-screen zoomable gallery overlay.
  void _openFullScreen(
      BuildContext context, List<String> images, int initialIndex) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 280),
        pageBuilder: (ctx, _, __) => _FullScreenGallery(
          images: images,
          initialIndex: initialIndex,
        ),
        transitionsBuilder: (ctx, anim, _, child) => FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeIn),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final product = widget.controller.product.value;
      if (product == null) {
        return _ProductDetailsErrorState(
          onRetry: widget.controller.fetchProductDetails,
        );
      }

      return Directionality(
        textDirection: Directionality.of(context),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Stack(
              children: [
                RefreshIndicator(
                  onRefresh: widget.controller.fetchProductDetails,
                  color: ManagerColors.primaryColor,
                  backgroundColor: ManagerColors.white,
                  displacement: 80,
                  child: CustomScrollView(
                    controller: _scrollCtrl,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    slivers: [
                      // ── Full-bleed gallery — PageView receives all gestures ──
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 340,
                          child: _ProductImageGallery(
                            images: product.images,
                            pageController: widget.pageController,
                            currentIndex: widget.currentImageIndex,
                            onImageTap: (index) => _openFullScreen(
                              context,
                              product.images,
                              index,
                            ),
                          ),
                        ),
                      ),

                      // ── Product header ─────────────────────────────────
                      SliverToBoxAdapter(
                        child: _SectionAnim(
                          animation: _headerAnim,
                          child: _ProductHeaderCard(product: product),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Container(height: 8, color: _kGapColor),
                      ),

                      // ── Meta section ───────────────────────────────────
                      SliverToBoxAdapter(
                        child: _SectionAnim(
                          animation: _metaAnim,
                          child: _ProductMetaSection(product: product),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Container(height: 8, color: _kGapColor),
                      ),

                      // ── Contact shop CTA ───────────────────────────────
                      SliverToBoxAdapter(
                        child: _SectionAnim(
                          animation: _ctaAnim,
                          child: _ContactShopCta(controller: widget.controller),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Container(height: 8, color: _kGapColor),
                      ),

                      // ── Variant selectors ──────────────────────────────
                      SliverToBoxAdapter(
                        child: _SectionAnim(
                          animation: _variantsAnim,
                          child: _VariantSelectorsSection(
                            controller: widget.controller,
                            product: product,
                          ),
                        ),
                      ),

                      SliverToBoxAdapter(
                        child: Container(height: 8, color: _kGapColor),
                      ),

                      // ── Expandable info sections ───────────────────────
                      SliverToBoxAdapter(
                        child: _SectionAnim(
                          animation: _infoAnim,
                          child: _ProductInfoSections(product: product),
                        ),
                      ),

                      // Bottom space for the add-to-cart bar
                      SliverToBoxAdapter(
                        child: SizedBox(height: ManagerHeight.h100),
                      ),
                    ],
                  ),
                ),

                // ── Title bar ──────────────────────────────────────────────
                // IgnorePointer(ignoring: true) when gallery is visible →
                // all horizontal swipes reach the PageView below.
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    ignoring: !_appBarScrolled,
                    child: AnimatedOpacity(
                      opacity: _appBarScrolled ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 220),
                      child: Container(
                        color: ManagerColors.primaryColor,
                        padding: EdgeInsets.fromLTRB(
                          ManagerWidth.w8,
                          MediaQuery.of(context).padding.top + ManagerHeight.h8,
                          ManagerWidth.w8,
                          ManagerHeight.h8,
                        ),
                        child: Row(
                          children: [
                            // Reserve space so title doesn't sit under back btn
                            SizedBox(
                                width: ManagerWidth.w34 + ManagerWidth.w10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    product.name,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s15,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    product.shopName,
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s11,
                                      color: Colors.white.withOpacity(0.80),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            if (product.isBestSelling) ...[                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w8,
                                  vertical: ManagerHeight.h4,
                                ),
                                decoration: BoxDecoration(
                                  color: _kGold.withOpacity(0.90),
                                  borderRadius: BorderRadius.circular(
                                      ManagerRadius.r20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                        Icons.local_fire_department_rounded,
                                        color: Colors.white,
                                        size: 13),
                                    SizedBox(width: ManagerWidth.w3),
                                    Text(
                                      ManagerStrings.allProductsBestSelling,
                                      style: getMediumTextStyle(
                                        fontSize: ManagerFontSize.s10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w8),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // ── Back button ─────────────────────────────────────────────
                // Placed AFTER title bar in Stack → always on top, never hidden.
                Positioned(
                  top: MediaQuery.of(context).padding.top + ManagerHeight.h8,
                  right: ManagerWidth.w8,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: ManagerWidth.w34,
                      height: ManagerHeight.h34,
                      decoration: BoxDecoration(
                        color: _appBarScrolled
                            ? Colors.white.withOpacity(0.20)
                            : Colors.black.withOpacity(0.40),
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      ),
                      child: const Icon(
                          Icons.arrow_back, color: Colors.white, size: 20),
                    ),
                  ),
                ),

                // ── Sticky Add-to-Cart bottom bar ──────────────────────────
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _AddToCartBar(
                    controller: widget.controller,
                    product: product,
                  ),
                ),
              ],
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

class _ProductDetailsErrorState extends StatelessWidget {
  final Future<void> Function() onRetry;
  const _ProductDetailsErrorState({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: ManagerWidth.w48,
              color: ManagerColors.greyWhiteColor,
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              ManagerStrings.productDetailsError,
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
// IMAGE GALLERY — PageView + dot indicator
// ══════════════════════════════════════════════════════════════════════════════

class _ProductImageGallery extends StatelessWidget {
  final List<String> images;
  final PageController pageController;
  final RxInt currentIndex;
  // Callback invoked when user taps any image → open full-screen viewer
  final void Function(int index)? onImageTap;

  const _ProductImageGallery({
    required this.images,
    required this.pageController,
    required this.currentIndex,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return Container(
        color: ManagerColors.primaryColor.withOpacity(0.15),
        child: Center(
          child: Icon(
            Icons.photo_outlined,
            size: 60,
            color: ManagerColors.primaryColor.withOpacity(0.4),
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: images.length,
          onPageChanged: (i) => currentIndex.value = i,
          // GestureDetector receives tap; PageView still receives swipe gestures
          // because GestureDetector does NOT compete for scrolling.
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => onImageTap?.call(i),
            child: CachedNetworkImage(
              imageUrl: images[i],
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(
                color: ManagerColors.primaryColor.withOpacity(0.1),
              ),
              errorWidget: (_, __, ___) => Container(
                color: ManagerColors.primaryColor.withOpacity(0.1),
                child: Icon(
                  Icons.broken_image_outlined,
                  color: ManagerColors.greyWhiteColor,
                  size: 40,
                ),
              ),
            ),
          ),
        ),

        // Gradient scrim at bottom — IgnorePointer so swipe reaches PageView
        Positioned.fill(
          child: IgnorePointer(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.5, 1.0],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.45),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Image counter badge — top-right
        if (images.length > 1)
          Positioned(
            top: 14,
            left: 16,
            child: Obx(() => AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    key: ValueKey(currentIndex.value),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${currentIndex.value + 1} / ${images.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )),
          ),

        // Dot indicators
        if (images.length > 1)
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == currentIndex.value ? 18 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: i == currentIndex.value
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                )),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PRODUCT HEADER CARD — name · price · discount
// ══════════════════════════════════════════════════════════════════════════════

class _ProductHeaderCard extends StatelessWidget {
  final ProductDetailsModel product;
  const _ProductHeaderCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h16,
        ManagerWidth.w16, ManagerHeight.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + best-selling badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s18,
                    color: ManagerColors.black,
                  ),
                ),
              ),
              if (product.isBestSelling) ...[
                SizedBox(width: ManagerWidth.w8),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w8,
                    vertical: ManagerHeight.h4,
                  ),
                  decoration: BoxDecoration(
                    color: _kGold.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(ManagerRadius.r6),
                    border: Border.all(color: _kGold.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_fire_department_rounded,
                          color: _kGold, size: 13),
                      SizedBox(width: ManagerWidth.w3),
                      Text(
                        ManagerStrings.allProductsBestSelling,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: _kGold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: ManagerHeight.h12),

          // Price row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '${product.price.toStringAsFixed(0)} ${ManagerStrings.productDetailsCurrency}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s22,
                  color: ManagerColors.primaryColor,
                ),
              ),
              if (product.hasDiscount) ...[
                SizedBox(width: ManagerWidth.w10),
                Text(
                  '${product.priceBeforeDiscount!.toStringAsFixed(0)} ${ManagerStrings.productDetailsCurrency}',
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.greyWhiteColor,
                  ).copyWith(decoration: TextDecoration.lineThrough),
                ),
                SizedBox(width: ManagerWidth.w8),
                _DiscountBadge(
                  discount: (((product.priceBeforeDiscount! - product.price) /
                              product.priceBeforeDiscount!) *
                          100)
                      .round(),
                ),
              ],
            ],
          ),

          // Availability indicator
          SizedBox(height: ManagerHeight.h10),
          _AvailabilityPill(isAvailable: product.isAvailable),
        ],
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final int discount;
  const _DiscountBadge({required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE53935).withOpacity(0.1),
        borderRadius: BorderRadius.circular(ManagerRadius.r6),
        border:
            Border.all(color: const Color(0xFFE53935).withOpacity(0.35)),
      ),
      child: Text(
        '-$discount%',
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s11,
          color: const Color(0xFFE53935),
        ),
      ),
    );
  }
}

class _AvailabilityPill extends StatelessWidget {
  final bool isAvailable;
  const _AvailabilityPill({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color =
        isAvailable ? const Color(0xFF43A047) : ManagerColors.greyWhiteColor;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: ManagerWidth.w6),
        Text(
          isAvailable
              ? ManagerStrings.inStock
              : ManagerStrings.productDetailsOutOfStock,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: color,
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// META SECTION — rating · shop · category · delivery
// ══════════════════════════════════════════════════════════════════════════════

class _ProductMetaSection extends StatelessWidget {
  final ProductDetailsModel product;
  const _ProductMetaSection({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.all(ManagerWidth.w16),
      child: Column(
        children: [
          // Stats row
          IntrinsicHeight(
            child: Row(
              children: [
                _MiniStat(
                  icon: Icons.star_rounded,
                  iconColor: _kGold,
                  bgColor: const Color(0xFFFFF8E1),
                  value: product.rating.toStringAsFixed(1),
                  label: '${product.ratersCount} ${ManagerStrings.productDetailsReviews}',
                ),
                Container(
                  width: 1,
                  color: const Color(0xFFEEEEEE),
                  margin: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
                ),
                _MiniStat(
                  icon: Icons.local_shipping_outlined,
                  iconColor: ManagerColors.primaryColor,
                  bgColor: ManagerColors.primaryColor.withOpacity(0.09),
                  value: '${product.deliveryTimeMin}-${product.deliveryTimeMax}',
                  label: ManagerStrings.productDetailsDeliveryDays,
                ),
                if (product.category != null) ...[
                  Container(
                    width: 1,
                    color: const Color(0xFFEEEEEE),
                    margin: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
                  ),
                  _MiniStat(
                    icon: Icons.category_outlined,
                    iconColor: const Color(0xFF5C6BC0),
                    bgColor: const Color(0xFF5C6BC0).withOpacity(0.09),
                    value: product.category!.name,
                    label: ManagerStrings.productDetailsCategory,
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h14),
          const Divider(height: 1, thickness: 1, color: _kDivider),
          SizedBox(height: ManagerHeight.h14),

          // Shop link
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              Routes.detailsShop,
              arguments: product.shopId,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.storefront_outlined,
                    size: 15,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                SizedBox(width: ManagerWidth.w10),
                Text(
                  '${ManagerStrings.productDetailsShop}: ',
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                Flexible(
                  child: Text(
                    product.shopName,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s13,
                      color: ManagerColors.primaryColor,
                    ).copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: ManagerColors.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: ManagerWidth.w4),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: ManagerColors.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final String value;
  final String label;

  const _MiniStat({
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          SizedBox(height: ManagerHeight.h5),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: ManagerHeight.h2),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
            child: Text(
              label,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s10,
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

// ══════════════════════════════════════════════════════════════════════════════
// CONTACT SHOP CTA — sweep-light + bouncing icon + press-scale
// ══════════════════════════════════════════════════════════════════════════════

class _ContactShopCta extends StatefulWidget {
  final ProductDetailsController controller;
  const _ContactShopCta({required this.controller});

  @override
  State<_ContactShopCta> createState() => _ContactShopCtaState();
}

class _ContactShopCtaState extends State<_ContactShopCta>
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
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
    _sweep = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
    _sweepPos = CurvedAnimation(
      parent: _sweep,
      curve: const Interval(0.0, 0.75, curve: Curves.easeInOut),
    );
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
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16,
        ManagerHeight.h16,
        ManagerWidth.w16,
        ManagerHeight.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ManagerStrings.detailsShopContactSubtitle,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s13,
              color: _kBodyText,
            ),
          ),
          SizedBox(height: ManagerHeight.h10),
          Obx(() {
            final isLoading = widget.controller.isChatLoading.value;
            return GestureDetector(
              onTapDown: isLoading ? null : (_) => _press.forward(),
              onTapUp: isLoading ? null : (_) => _press.reverse(),
              onTapCancel: isLoading ? null : () => _press.reverse(),
              onTap: isLoading ? null : () => widget.controller.startChatWithShop(),
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
                                  Center(
                                    child: AnimatedBuilder(
                                      animation: _bounceY,
                                      builder: (_, child) =>
                                          Transform.translate(
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
          }),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// VARIANT SELECTORS — color · size
// ══════════════════════════════════════════════════════════════════════════════

class _VariantSelectorsSection extends StatelessWidget {
  final ProductDetailsController controller;
  final ProductDetailsModel product;

  const _VariantSelectorsSection({
    required this.controller,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final hasColors = product.availableColors.isNotEmpty;
    if (!hasColors) return const SizedBox.shrink();

    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.all(ManagerWidth.w16),
      child: Obx(() {
        final selectedColor = controller.selectedColor.value;
        final selectedSize  = controller.selectedSize.value;
        final sizes         = controller.availableSizes;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Color selector
            _SectionHeader2(
              title: ManagerStrings.productDetailsColor,
              icon: Icons.palette_outlined,
            ),
            SizedBox(height: ManagerHeight.h12),
            Wrap(
              spacing: ManagerWidth.w10,
              runSpacing: ManagerHeight.h10,
              children: product.availableColors.map((color) {
                final isSelected = color == selectedColor;
                return GestureDetector(
                  onTap: () => controller.selectColor(color),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: _parseColor(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? ManagerColors.primaryColor
                            : Colors.transparent,
                        width: 2.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: ManagerColors.primaryColor
                                    .withOpacity(0.30),
                                blurRadius: 8,
                                spreadRadius: 1,
                              ),
                            ]
                          : null,
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check_rounded,
                            color: _foregroundFor(_parseColor(color)),
                            size: 18,
                          )
                        : null,
                  ),
                );
              }).toList(),
            ),

            // Size selector (only when a color is selected)
            if (selectedColor != null && sizes.isNotEmpty) ...[
              SizedBox(height: ManagerHeight.h20),
              const Divider(height: 1, thickness: 1, color: _kDivider),
              SizedBox(height: ManagerHeight.h16),
              _SectionHeader2(
                title: ManagerStrings.productDetailsSize,
                icon: Icons.straighten_outlined,
              ),
              SizedBox(height: ManagerHeight.h12),
              Wrap(
                spacing: ManagerWidth.w8,
                runSpacing: ManagerHeight.h8,
                children: sizes.map((size) {
                  final isSelected = size == selectedSize;
                  return GestureDetector(
                    onTap: () => controller.selectSize(size),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h8,
                      ),
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? const LinearGradient(
                                colors: [
                                  ManagerColors.primaryColor,
                                  _kPrimaryTeal
                                ],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              )
                            : null,
                        color: isSelected
                            ? null
                            : ManagerColors.primaryColor.withOpacity(0.06),
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r8),
                        border: isSelected
                            ? null
                            : Border.all(
                                color: ManagerColors.primaryColor
                                    .withOpacity(0.2)),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: ManagerColors.primaryColor
                                      .withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        size,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: isSelected
                              ? Colors.white
                              : ManagerColors.primaryColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],

            // Qty selector (only when variant is fully selected)
            if (selectedColor != null && selectedSize != null) ...[
              SizedBox(height: ManagerHeight.h20),
              const Divider(height: 1, thickness: 1, color: _kDivider),
              SizedBox(height: ManagerHeight.h16),
              _SectionHeader2(
                title: ManagerStrings.productDetailsQty,
                icon: Icons.add_shopping_cart_outlined,
              ),
              SizedBox(height: ManagerHeight.h12),
              _QuantityControl(controller: controller),
            ],
          ],
        );
      }),
    );
  }

  Color _parseColor(String colorStr) {
    // 1 — hex (#RRGGBB or RRGGBB or #AARRGGBB)
    try {
      final hex = colorStr.trim().replaceAll('#', '');
      if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
      if (hex.length == 8) return Color(int.parse(hex, radix: 16));
    } catch (_) {}

    // 2 — named colours (English + Arabic)
    const named = <String, Color>{
      // ── English ──────────────────────────────────────────
      'red':         Color(0xFFE53935),
      'blue':        Color(0xFF1E88E5),
      'green':       Color(0xFF43A047),
      'black':       Color(0xFF212121),
      'white':       Color(0xFFFAFAFA),
      'yellow':      Color(0xFFFDD835),
      'orange':      Color(0xFFFB8C00),
      'pink':        Color(0xFFEC407A),
      'purple':      Color(0xFF8E24AA),
      'brown':       Color(0xFF6D4C41),
      'gray':        Color(0xFF9E9E9E),
      'grey':        Color(0xFF9E9E9E),
      'navy':        Color(0xFF1A237E),
      'teal':        Color(0xFF00897B),
      'cyan':        Color(0xFF00ACC1),
      'indigo':      Color(0xFF3949AB),
      'violet':      Color(0xFF7B1FA2),
      'magenta':     Color(0xFFE91E63),
      'beige':       Color(0xFFF5F0DC),
      'ivory':       Color(0xFFFFF8E7),
      'maroon':      Color(0xFF800000),
      'olive':       Color(0xFF808000),
      'turquoise':   Color(0xFF26A69A),
      'gold':        Color(0xFFFFCA28),
      'silver':      Color(0xFFBDBDBD),
      'cream':       Color(0xFFFFFDD0),
      'khaki':       Color(0xFFC3B091),
      'lavender':    Color(0xFFCE93D8),
      'coral':       Color(0xFFFF7043),
      'salmon':      Color(0xFFEF9A9A),
      'crimson':     Color(0xFFD32F2F),
      'charcoal':    Color(0xFF455A64),
      'mint':        Color(0xFF66BB6A),
      'rose':        Color(0xFFE91E63),
      'peach':       Color(0xFFFFCC80),
      'lime':        Color(0xFFAED581),
      'caramel':     Color(0xFFBF8040),
      'chocolate':   Color(0xFF5D3A1A),
      'mustard':     Color(0xFFFFB300),
      'denim':       Color(0xFF3B5998),
      'sand':        Color(0xFFF4D799),
      'off-white':   Color(0xFFF8F8F0),
      'offwhite':    Color(0xFFF8F8F0),
      // ── Arabic ───────────────────────────────────────────
      'أحمر':        Color(0xFFE53935),
      'أزرق':        Color(0xFF1E88E5),
      'أخضر':        Color(0xFF43A047),
      'أسود':        Color(0xFF212121),
      'أبيض':        Color(0xFFFAFAFA),
      'أصفر':        Color(0xFFFDD835),
      'برتقالي':     Color(0xFFFB8C00),
      'وردي':        Color(0xFFEC407A),
      'بنفسجي':      Color(0xFF8E24AA),
      'بني':         Color(0xFF6D4C41),
      'رمادي':       Color(0xFF9E9E9E),
      'كحلي':        Color(0xFF1A237E),
      'زيتوني':      Color(0xFF808000),
      'فيروزي':      Color(0xFF00897B),
      'ذهبي':        Color(0xFFFFCA28),
      'فضي':         Color(0xFFBDBDBD),
      'كريمي':       Color(0xFFFFFDD0),
      'سماوي':       Color(0xFF00ACC1),
      'نيلي':        Color(0xFF3949AB),
      'خوخي':        Color(0xFFFFCC80),
      'زهري':        Color(0xFFEC407A),
      'بيج':         Color(0xFFF5F0DC),
      'عاجي':        Color(0xFFFFF8E7),
      'قرمزي':       Color(0xFFD32F2F),
      'خردلي':       Color(0xFFFFB300),
      'نعناعي':      Color(0xFF66BB6A),
      'ليموني':      Color(0xFFAED581),
      'قهوي':        Color(0xFF6D4C41),
      'شوكولاتة':    Color(0xFF5D3A1A),
      'رملي':        Color(0xFFF4D799),
      'تركواز':      Color(0xFF26A69A),
      'قرنفلي':      Color(0xFFE91E63),
      'أرجواني':     Color(0xFF7B1FA2),
    };

    final lower = colorStr.trim().toLowerCase();
    if (named.containsKey(lower)) return named[lower]!;
    // Check original case (for Arabic)
    final original = colorStr.trim();
    if (named.containsKey(original)) return named[original]!;

    // 3 — hash-based fallback: deterministic, visually distinct
    final hash = original.codeUnits
        .fold(0, (int acc, int c) => (acc * 31 + c) & 0x7FFFFFFF);
    return HSVColor.fromAHSV(1.0, (hash % 360).toDouble(), 0.62, 0.78)
        .toColor();
  }

  Color _foregroundFor(Color bg) {
    final luminance = bg.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }
}

class _SectionHeader2 extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader2({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        Icon(icon, size: 16, color: ManagerColors.primaryColor),
        SizedBox(width: ManagerWidth.w6),
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

// ── Quantity control ──────────────────────────────────────────────────────────

class _QuantityControl extends StatelessWidget {
  final ProductDetailsController controller;
  const _QuantityControl({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final qty     = controller.quantity.value;
      final variant = controller.selectedVariant;
      final maxQty  = variant?.quantity ?? 0;

      return Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: ManagerColors.greyWhiteColor.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _QtyBtn(
                  icon: Icons.remove,
                  onTap: controller.decrementQty,
                  enabled: qty > 1,
                  isPrimary: false,
                ),
                Container(
                  width: 44,
                  height: ManagerHeight.h38,
                  alignment: Alignment.center,
                  child: Text(
                    '$qty',
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s16,
                      color: ManagerColors.black,
                    ),
                  ),
                ),
                _QtyBtn(
                  icon: Icons.add,
                  onTap: controller.incrementQty,
                  enabled: qty < maxQty,
                  isPrimary: true,
                ),
              ],
            ),
          ),
          SizedBox(width: ManagerWidth.w12),
          Text(
            '${ManagerStrings.productDetailsQty}: $maxQty',

            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      );
    });
  }
}

class _QtyBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  final bool isPrimary;

  const _QtyBtn({
    required this.icon,
    required this.onTap,
    required this.enabled,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final color = enabled
        ? (isPrimary ? ManagerColors.primaryColor : ManagerColors.black)
        : ManagerColors.greyWhiteColor.withOpacity(0.4);

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: ManagerWidth.w38,
        height: ManagerHeight.h38,
        decoration: BoxDecoration(
          color: isPrimary && enabled
              ? ManagerColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: isPrimary
              ? const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  bottomLeft: Radius.circular(9),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(9),
                  bottomRight: Radius.circular(9),
                ),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// INFO SECTIONS — description · features · care instructions
// ══════════════════════════════════════════════════════════════════════════════

class _ProductInfoSections extends StatelessWidget {
  final ProductDetailsModel product;
  const _ProductInfoSections({required this.product});

  @override
  Widget build(BuildContext context) {
    final hasDesc     = product.description != null && product.description!.isNotEmpty;
    final hasFeatures = product.features.isNotEmpty;
    final hasCare     = product.careInstructions.isNotEmpty;

    if (!hasDesc && !hasFeatures && !hasCare) return const SizedBox.shrink();

    return Column(
      children: [
        if (hasDesc)
          _ExpandableInfoCard(
            title: ManagerStrings.productDescription,
            icon: Icons.description_outlined,
            child: Text(
              product.description!,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: _kBodyText,
              ),
              textDirection: Directionality.of(context),
            ),
          ),
        if (hasDesc && hasFeatures)
          Container(height: 8, color: _kGapColor),
        if (hasFeatures)
          _ExpandableInfoCard(
            title: ManagerStrings.productDetailsFeatures,
            icon: Icons.star_outline_rounded,
            child: _BulletList(items: product.features),
          ),
        if (hasFeatures && hasCare)
          Container(height: 8, color: _kGapColor),
        if (hasCare)
          _ExpandableInfoCard(
            title: ManagerStrings.productDetailsCare,
            icon: Icons.local_laundry_service_outlined,
            child: _BulletList(items: product.careInstructions),
          ),
      ],
    );
  }
}

class _ExpandableInfoCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _ExpandableInfoCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  State<_ExpandableInfoCard> createState() => _ExpandableInfoCardState();
}

class _ExpandableInfoCardState extends State<_ExpandableInfoCard>
    with SingleTickerProviderStateMixin {
  bool _expanded = true;
  late final AnimationController _ctrl;
  late final Animation<double> _rotate;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      value: 1.0,
    );
    _rotate = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (_expanded) {
      _ctrl.forward();
    } else {
      _ctrl.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggle,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h14,
              ),
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: 3,
                    height: 16,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: ManagerWidth.w8),
                  Icon(widget.icon, size: 17, color: ManagerColors.primaryColor),
                  SizedBox(width: ManagerWidth.w8),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s15,
                        color: ManagerColors.black,
                      ),
                    ),
                  ),
                  RotationTransition(
                    turns: _rotate,
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: ManagerColors.greyWhiteColor,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: Padding(
              padding: EdgeInsets.fromLTRB(
                ManagerWidth.w16, 0,
                ManagerWidth.w16, ManagerHeight.h16,
              ),
              child: widget.child,
            ),
            secondChild: const SizedBox.shrink(),
            crossFadeState: _expanded
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;
  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: ManagerHeight.h5, left: ManagerWidth.w6),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: _kBodyText,
                      ),
                      textDirection: Directionality.of(context),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ADD TO CART BOTTOM BAR — sweep-light + animated CTA
// ══════════════════════════════════════════════════════════════════════════════

class _AddToCartBar extends StatefulWidget {
  final ProductDetailsController controller;
  final ProductDetailsModel product;

  const _AddToCartBar({
    required this.controller,
    required this.product,
  });

  @override
  State<_AddToCartBar> createState() => _AddToCartBarState();
}

class _AddToCartBarState extends State<_AddToCartBar>
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
    _press = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 90));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut));

    _sweep = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 3000))
      ..repeat();
    _sweepPos = CurvedAnimation(
      parent: _sweep,
      curve: const Interval(0.0, 0.75, curve: Curves.easeInOut));

    _bounce = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2500))
      ..repeat();
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

  void _onTap(CartController cartCtrl) {
    final ctrl    = widget.controller;
    final variant = ctrl.selectedVariant;

    if (!ctrl.canAddToCart || variant == null) {
      // Show select-variant nudge
      Get.snackbar(
        '',
        ManagerStrings.productDetailsSelectVariant,
        snackPosition: SnackPosition.TOP,
        backgroundColor: ManagerColors.primaryColor.withOpacity(0.9),
        colorText: Colors.white,
        margin: EdgeInsets.all(ManagerWidth.w16),
        borderRadius: ManagerRadius.r10,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    cartCtrl.addToCart(
      productId: widget.product.id,
      variantId: variant.id,
      quantity: ctrl.quantity.value,
    ).then((ok) {
      if (ok) cartCtrl.openCartAfterAdd();
    });
  }

  @override
  Widget build(BuildContext context) {
    cart_di.initCart();
    final cartCtrl = Get.find<CartController>();

    return Container(
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h10,
        ManagerWidth.w16, ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.09),
            blurRadius: 16,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Obx(() {
          final isLoading = cartCtrl.isActionLoading.value;
          final canAdd    = widget.controller.canAddToCart;

          return GestureDetector(
            onTapDown: isLoading ? null : (_) => _press.forward(),
            onTapUp: isLoading ? null : (_) => _press.reverse(),
            onTapCancel: isLoading ? null : () => _press.reverse(),
            onTap: isLoading ? null : () => _onTap(cartCtrl),
            child: AnimatedBuilder(
              animation: _scale,
              builder: (_, child) =>
                  Transform.scale(scale: _scale.value, child: child),
              child: Container(
                width: double.infinity,
                height: 54,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: isLoading
                    ? Container(
                        decoration: BoxDecoration(
                          color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: ManagerColors.primaryColor,
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
                                // Base gradient (dimmed when unavailable)
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: canAdd
                                          ? const [
                                              ManagerColors.primaryColor,
                                              _kPrimaryTeal,
                                            ]
                                          : [
                                              ManagerColors.greyWhiteColor
                                                  .withOpacity(0.6),
                                              ManagerColors.greyWhiteColor
                                                  .withOpacity(0.6),
                                            ],
                                      begin: Alignment.centerRight,
                                      end: Alignment.centerLeft,
                                    ),
                                  ),
                                ),

                                // Top highlight
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

                                // Sweep light (only when active)
                                if (canAdd)
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
                                                Colors.white.withOpacity(0.18),
                                                Colors.white.withOpacity(0.0),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),

                                // Label + bouncing icon
                                Center(
                                  child: canAdd
                                      ? AnimatedBuilder(
                                          animation: _bounceY,
                                          builder: (_, child) =>
                                              Transform.translate(
                                            offset: Offset(0, _bounceY.value),
                                            child: child,
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                Icons.shopping_cart_rounded,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(width: ManagerWidth.w10),
                                              Text(
                                                ManagerStrings
                                                    .productDetailsAddToCart,
                                                style: getBoldTextStyle(
                                                  fontSize: ManagerFontSize.s15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          ManagerStrings.productDetailsSelectVariant,
                                          style: getMediumTextStyle(
                                            fontSize: ManagerFontSize.s14,
                                            color: Colors.white,
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
        }),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// FULL-SCREEN GALLERY  —  pinch-zoom · swipe between images · close
// ══════════════════════════════════════════════════════════════════════════════

class _FullScreenGallery extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _FullScreenGallery(
      {required this.images, required this.initialIndex});

  @override
  State<_FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<_FullScreenGallery> {
  late final PageController _pageCtrl;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _pageCtrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    final topPad    = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Zoomable PageView ─────────────────────────────────────────────
          PageView.builder(
            controller: _pageCtrl,
            itemCount: widget.images.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => InteractiveViewer(
              minScale: 1.0,
              maxScale: 4.0,
              clipBehavior: Clip.none,
              child: Center(
                child: CachedNetworkImage(
                  imageUrl: widget.images[i],
                  fit: BoxFit.contain,
                  placeholder: (_, __) => const Center(
                    child: CircularProgressIndicator(
                        color: Colors.white54, strokeWidth: 2),
                  ),
                  errorWidget: (_, __, ___) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white38,
                      size: 52),
                ),
              ),
            ),
          ),

          // ── Top bar: close button + counter ──────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                ManagerWidth.w16,
                topPad + ManagerHeight.h10,
                ManagerWidth.w16,
                ManagerHeight.h12,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.65),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Row(
                children: [
                  // Close
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: ManagerWidth.w34,
                      height: ManagerHeight.h34,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r8),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.25)),
                      ),
                      child: const Icon(Icons.close_rounded,
                          color: Colors.white, size: 18),
                    ),
                  ),
                  const Spacer(),
                  // Counter
                  if (widget.images.length > 1)
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        '${_current + 1} / ${widget.images.length}',
                        key: ValueKey(_current),
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ── Dot indicators ────────────────────────────────────────────────
          if (widget.images.length > 1)
            Positioned(
              bottom: bottomPad + ManagerHeight.h20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: i == _current ? 22 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _current
                          ? Colors.white
                          : Colors.white.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// SECTION ANIMATION WRAPPER — fade + upward slide
// ══════════════════════════════════════════════════════════════════════════════

class _SectionAnim extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _SectionAnim({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
