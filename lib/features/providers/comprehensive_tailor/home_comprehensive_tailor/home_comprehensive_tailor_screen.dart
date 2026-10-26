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
import 'package:app_mobile/features/providers/comprehensive_tailor/home_comprehensive_tailor/domain/di/di.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/home_comprehensive_tailor/presentation/controller/comprehensive_home_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/home_comprehensive_tailor/presentation/widgets/comprehensive_home_shimmer.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/domain/di/di.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/presentation/pages/comprehensive_order_tracking_screen.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/action_card_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/balance_card_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/home_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

/// Main home screen for the comprehensive tailor (خياط شامل) with bottom navigation.
class HomeComprehensiveTailorScreen extends StatefulWidget {
  const HomeComprehensiveTailorScreen({super.key});

  @override
  State<HomeComprehensiveTailorScreen> createState() =>
      _HomeComprehensiveTailorScreenState();
}

class _HomeComprehensiveTailorScreenState
    extends State<HomeComprehensiveTailorScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    initComprehensiveHome(forceRefresh: true);
    initComprehensiveOrderTracking(forceRefresh: true);
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
          body: IndexedStack(
            index: _currentIndex,
            children: [
              const _HomeTab(),
              const ComprehensiveOrderTrackingScreen(),
              const ConversationsScreen(),
            ],
          ),
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
                onTap: (index) => setState(() => _currentIndex = index),
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
}

// ─────────────────────────────────────────────────────────────────────────────
// ── Home Tab — header + balance + 4 action cards with staggered animations
// ─────────────────────────────────────────────────────────────────────────────

class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _balanceController;

  // Header slide down + fade in
  late Animation<Offset> _headerSlide;
  late Animation<double> _headerFade;

  // Balance card: fade + slide up + scale
  late Animation<double> _balanceFade;
  late Animation<Offset> _balanceSlide;
  late Animation<double> _balanceScale;

  // Row 1 — card 1: طلبات على ذوقك  (0.30 → 0.58)
  late Animation<double> _card1Fade;
  late Animation<Offset> _card1Slide;

  // Row 1 — card 2: آراء العملاء     (0.40 → 0.68)
  late Animation<double> _card2Fade;
  late Animation<Offset> _card2Slide;

  // Row 2 — card 3: إدارة المنتجات  (0.52 → 0.80)
  late Animation<double> _card3Fade;
  late Animation<Offset> _card3Slide;

  // Row 2 — card 4: عروضي المقدمة   (0.62 → 0.90)
  late Animation<double> _card4Fade;
  late Animation<Offset> _card4Slide;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _balanceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // ── Header ────────────────────────────────────────────────────────────────
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.35, curve: Curves.easeOutCubic),
    ));
    _headerFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
    ));

    // ── Balance Card ──────────────────────────────────────────────────────────
    _balanceFade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _balanceController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    _balanceSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _balanceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));
    _balanceScale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _balanceController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // ── Action Cards (staggered by 0.12 each) ─────────────────────────────────
    _card1Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.30, 0.58, curve: Curves.easeOut),
    ));
    _card1Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.30, 0.58, curve: Curves.easeOutCubic),
    ));

    _card2Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.40, 0.68, curve: Curves.easeOut),
    ));
    _card2Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.40, 0.68, curve: Curves.easeOutCubic),
    ));

    _card3Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.52, 0.80, curve: Curves.easeOut),
    ));
    _card3Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.52, 0.80, curve: Curves.easeOutCubic),
    ));

    _card4Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.62, 0.90, curve: Curves.easeOut),
    ));
    _card4Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.62, 0.90, curve: Curves.easeOutCubic),
    ));

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
    final controller = Get.find<ComprehensiveHomeController>();

    return Obx(() {
      // Show shimmer only on the very first load
      if (controller.isFirstLoad.value) {
        return const ComprehensiveHomeShimmer();
      }

      return Stack(
        children: [
          AnimatedBuilder(
            animation:
                Listenable.merge([_mainController, _balanceController]),
            builder: (context, _) {
              return Column(
                children: [
                  /// Fixed Header — slide down + fade in
                  SlideTransition(
                    position: _headerSlide,
                    child: FadeTransition(
                      opacity: _headerFade,
                      child: Obx(() => HomeHeaderWidget(
                            isAvailable:
                                controller.homeData.value?.isAcceptingOrders ??
                                    true,
                            onAvailabilityChanged:
                                controller.changeAvailability,
                            fullName: controller.homeData.value?.fullName,
                            imageUrl: controller.homeData.value?.imageUrl,
                            rankLabel: controller.homeData.value?.rankLabel,
                          )),
                    ),
                  ),

                  /// Scrollable Content
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
                            /// Balance Card — fade + slide up + scale
                            FadeTransition(
                              opacity: _balanceFade,
                              child: SlideTransition(
                                position: _balanceSlide,
                                child: ScaleTransition(
                                  scale: _balanceScale,
                                  child: Obx(() => BalanceCardWidget(
                                        withdrawableBalance: controller
                                            .homeData.value?.withdrawableBalance,
                                        lastLoginFormatted:
                                            controller.formattedLastLogin,
                                      )),
                                ),
                              ),
                            ),

                            SizedBox(height: ManagerHeight.h20),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Row 1: طلبات على ذوقك + آراء العملاء
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card1Fade,
                                          child: SlideTransition(
                                            position: _card1Slide,
                                            child: Obx(() {
                                              final count = controller
                                                      .homeData
                                                      .value
                                                      ?.zoqakOrdersCount ??
                                                  0;
                                              return ActionCardWidget(
                                                svgIconPath: ManagerIcons
                                                    .customOrderIcon,
                                                iconBackgroundColor:
                                                    ManagerColors.primaryColor
                                                        .withOpacity(0.1),
                                                iconColor:
                                                    ManagerColors.primaryColor,
                                                title: ManagerStrings
                                                    .homeOrdersTitle,
                                                subtitle: ManagerStrings
                                                    .homeOrdersSubtitle,
                                                // Real count from the API —
                                                // hidden when there are no
                                                // orders (was a hardcoded "12").
                                                badge: count > 0
                                                    ? count.toString()
                                                    : null,
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    Routes.suggestedRequests,
                                                  );
                                                },
                                              );
                                            }),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: ManagerWidth.w12),

                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card2Fade,
                                          child: SlideTransition(
                                            position: _card2Slide,
                                            child: ActionCardWidget(
                                              icon: Icons.star_outline_rounded,
                                              iconBackgroundColor:
                                                  ManagerColors.primaryColor
                                                      .withOpacity(0.1),
                                              iconColor:
                                                  ManagerColors.primaryColor,
                                              title: ManagerStrings
                                                  .homeReviewsTitle,
                                              subtitle: ManagerStrings
                                                  .homeReviewsSubtitle,
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    Routes.customerReviews);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: ManagerHeight.h12),

                                  /// Row 2: إدارة المنتجات + عروضي المقدمة
                                  Row(
                                    children: [
                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card3Fade,
                                          child: SlideTransition(
                                            position: _card3Slide,
                                            child: ActionCardWidget(
                                              svgIconPath:
                                                  ManagerIcons.storeIcon,
                                              iconBackgroundColor:
                                                  ManagerColors.primaryColor
                                                      .withOpacity(0.1),
                                              iconColor:
                                                  ManagerColors.primaryColor,
                                              title: ManagerStrings
                                                  .homeStoreProductsTitle,
                                              subtitle: ManagerStrings
                                                  .homeStoreProductsSubtitle,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  Routes.managerProducts,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: ManagerWidth.w12),

                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card4Fade,
                                          child: SlideTransition(
                                            position: _card4Slide,
                                            child: ActionCardWidget(
                                              icon: Icons.local_offer_rounded,
                                              iconBackgroundColor:
                                                  ManagerColors.primaryColor
                                                      .withOpacity(0.1),
                                              iconColor:
                                                  ManagerColors.primaryColor,
                                              title:
                                                  ManagerStrings.homeOffersTitle,
                                              subtitle: ManagerStrings
                                                  .homeOffersSubtitle,
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, Routes.myOffers);
                                              },
                                            ),
                                          ),
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
                  ),
                ],
              );
            },
          ),

          /// Loading overlay while changing availability
          Obx(() => controller.isChangingAvailability.value
              ? const LoadingWidget()
              : const SizedBox.shrink()),
        ],
      );
    });
  }
}
