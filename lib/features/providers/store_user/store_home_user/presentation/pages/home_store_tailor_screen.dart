import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/common_features/chat/presentation/pages/conversations_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/action_card_widget.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/domain/di/di.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/domain/di/di.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/controller/shop_owner_home_controller.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/widgets/shop_owner_home_shimmer.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/widgets/store_balance_card_widget.dart';
import 'package:app_mobile/features/providers/store_user/store_home_user/presentation/widgets/store_home_header_widget.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/presentation/store_order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

/// Main home screen for the store tailor (صاحب محل) with bottom navigation.
class HomeStoreTailorScreen extends StatefulWidget {
  const HomeStoreTailorScreen({super.key});

  @override
  State<HomeStoreTailorScreen> createState() => _HomeStoreTailorScreenState();
}

class _HomeStoreTailorScreenState extends State<HomeStoreTailorScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initShopOwnerHome(forceRefresh: true);
  }

  @override
  void dispose() {
    // Do NOT Get.delete here — races with Get.offAllNamed (new session wiped).
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: _buildCurrentTab(),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: ManagerColors.white,
              boxShadow: [
                BoxShadow(
                  color: ManagerColors.black.withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              bottom: true,
              child: SalomonBottomBar(
                currentIndex: _currentIndex,
                onTap: _onTabSelected,
                selectedItemColor: ManagerColors.primaryColor,
                unselectedItemColor: ManagerColors.greyWhiteColor,
                margin: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w16,
                  vertical: ManagerHeight.h8,
                ),
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: CustomSvgImage(
                      path: ManagerIcons.homeBottomIcon,
                      width: ManagerWidth.w24,
                      height: ManagerHeight.h24,
                      color: _currentIndex == 0
                          ? ManagerColors.primaryColor
                          : ManagerColors.greyWhiteColor,
                    ),
                    title: Text(
                      ManagerStrings.homeNavHome,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    selectedColor: ManagerColors.primaryColor,
                  ),

                  /// Orders
                  SalomonBottomBarItem(
                    icon: CustomSvgImage(
                      path: ManagerIcons.ordersBottomIcon,
                      width: ManagerWidth.w24,
                      height: ManagerHeight.h24,
                      color: _currentIndex == 1
                          ? ManagerColors.primaryColor
                          : ManagerColors.greyWhiteColor,
                    ),
                    title: Text(
                      ManagerStrings.homeNavOrders,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    selectedColor: ManagerColors.primaryColor,
                  ),

                  /// Messages
                  SalomonBottomBarItem(
                    icon: CustomSvgImage(
                      path: ManagerIcons.messagesBottomIcon,
                      width: ManagerWidth.w24,
                      height: ManagerHeight.h24,
                      color: _currentIndex == 2
                          ? ManagerColors.primaryColor
                          : ManagerColors.greyWhiteColor,
                    ),
                    title: Text(
                      ManagerStrings.homeNavMessages,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    selectedColor: ManagerColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTabSelected(int index) {
    if (index == _currentIndex) return;
    if (index == 1) {
      initStoreOrderTracking(forceRefresh: true);
    }
    setState(() => _currentIndex = index);
  }

  Widget _buildCurrentTab() {
    switch (_currentIndex) {
      case 1:
        return const StoreOrderTrackingScreen();
      case 2:
        return const ConversationsScreen();
      default:
        return const _HomeTab();
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// ── Home Tab — shimmer on first load, RefreshIndicator on refresh
// ─────────────────────────────────────────────────────────────────────────────

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _balanceController;

  late Animation<Offset> _headerSlide;
  late Animation<double> _headerFade;
  late Animation<double> _balanceFade;
  late Animation<Offset> _balanceSlide;
  late Animation<double> _balanceScale;
  late Animation<double> _card1Fade;
  late Animation<Offset> _card1Slide;
  late Animation<double> _card2Fade;
  late Animation<Offset> _card2Slide;

  @override
  void initState() {
    super.initState();
    _mainController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1200));
    _balanceController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));

    // Header: 0.0 → 0.35
    _headerSlide = Tween<Offset>(begin: const Offset(0, -0.3), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic)));
    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut)));

    // Balance card
    _balanceFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _balanceController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut)));
    _balanceSlide =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _balanceController,
                curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic)));
    _balanceScale = Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(
            parent: _balanceController,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic)));

    // Card 1: 0.35 → 0.65
    _card1Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.35, 0.65, curve: Curves.easeOut)));
    _card1Slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic)));

    // Card 2: 0.45 → 0.75
    _card2Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.45, 0.75, curve: Curves.easeOut)));
    _card2Slide = Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: _mainController,
            curve: const Interval(0.45, 0.75, curve: Curves.easeOutCubic)));

    _mainController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _balanceController.forward();
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ShopOwnerHomeController>();

    return Obx(() {
      // Show shimmer only on the very first load
      if (controller.isFirstLoad.value) {
        return const ShopOwnerHomeShimmer();
      }

      return Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_mainController, _balanceController]),
            builder: (context, _) {
              return Column(
                children: [
                  // Fixed Header — slide down + fade in
                  SlideTransition(
                    position: _headerSlide,
                    child: FadeTransition(
                      opacity: _headerFade,
                      child: Obx(() => StoreHomeHeaderWidget(
                            isAvailable: controller.isShopOpen.value,
                            onAvailabilityChanged:
                                controller.changeAvailability,
                            shopName: controller.shopName.value,
                            imageUrl: controller.shopLogoUrl.value,
                          )),
                    ),
                  ),

                  // Scrollable content with RefreshIndicator
                  Expanded(
                    child: RefreshIndicator(
                      color: ManagerColors.primaryColor,
                      onRefresh: controller.refreshHome,
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics()),
                        padding: EdgeInsets.only(
                          top: ManagerHeight.h16,
                          bottom: ManagerHeight.h16,
                        ),
                        child: Column(
                          children: [
                            // Balance Card
                            FadeTransition(
                              opacity: _balanceFade,
                              child: SlideTransition(
                                position: _balanceSlide,
                                child: ScaleTransition(
                                  scale: _balanceScale,
                                  child: const StoreBalanceCardWidget(),
                                ),
                              ),
                            ),

                            SizedBox(height: ManagerHeight.h20),

                            // Action Cards Row
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w16),
                              child: Row(
                                children: [
                                  // Card 1 — إدارة المنتجات
                                  Expanded(
                                    child: FadeTransition(
                                      opacity: _card1Fade,
                                      child: SlideTransition(
                                        position: _card1Slide,
                                        child: ActionCardWidget(
                                          svgIconPath: ManagerIcons.storeIcon,
                                          iconBackgroundColor: ManagerColors
                                              .primaryColor
                                              .withOpacity(0.1),
                                          iconColor: ManagerColors.primaryColor,
                                          title: ManagerStrings
                                              .shopHomeProductsTitle,
                                          subtitle: ManagerStrings
                                              .shopHomeProductsSubtitle,
                                          onTap: () => Navigator.pushNamed(
                                              context, Routes.managerProducts),
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: ManagerWidth.w12),

                                  // Card 2 — آراء العملاء
                                  Expanded(
                                    child: FadeTransition(
                                      opacity: _card2Fade,
                                      child: SlideTransition(
                                        position: _card2Slide,
                                        child: Obx(
                                          () => ActionCardWidget(
                                            icon: Icons.star_outline_rounded,
                                            iconBackgroundColor: ManagerColors
                                                .primaryColor
                                                .withOpacity(0.1),
                                            iconColor:
                                                ManagerColors.primaryColor,
                                            title: ManagerStrings
                                                .shopHomeReviewsTitle,
                                            subtitle: ManagerStrings
                                                .shopHomeReviewsSubtitle,
                                            badge: controller.reviewsCount > 0
                                                ? controller.reviewsCount
                                                    .toString()
                                                : null,
                                            onTap: () => Navigator.pushNamed(
                                                context,
                                                Routes.customerReviews),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Loading overlay while changing availability
          Obx(() => controller.isChangingAvailability.value
              ? const LoadingWidget()
              : const SizedBox.shrink()),
        ],
      );
    });
  }
}
