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
import 'package:app_mobile/features/providers/common_features/chat/presentation/pages/conversations_screen.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/domain/di/di.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/presentation/controller/independent_tailor_home_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/presentation/widgets/independent_tailor_home_shimmer.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/action_card_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/balance_card_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/home_independents_tailor/widgets/home_header_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/order_tracking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

/// Main home screen for the independent tailor with bottom navigation.
class HomeIndependentTailorScreen extends StatefulWidget {
  const HomeIndependentTailorScreen({super.key});

  @override
  State<HomeIndependentTailorScreen> createState() =>
      _HomeIndependentTailorScreenState();
}

class _HomeIndependentTailorScreenState
    extends State<HomeIndependentTailorScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Always recreate so a previous account's controller cannot survive login.
    initIndependentTailorHome(forceRefresh: true);
  }

  @override
  void dispose() {
    // Do NOT Get.delete here — with Get.offAllNamed the new home's controller
    // is registered before this dispose runs, and deleting would wipe the new session.
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
          // backgroundColor: const Color(0xFFF5F5F5),
          backgroundColor: ManagerColors.white,
          body: IndexedStack(
            index: _currentIndex,
            children: [
              const _HomeTab(),
              const OrderTrackingScreen(),
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

/// ── Home Tab ──
/// Combines header, balance card, and action cards with staggered animations.
class _HomeTab extends StatefulWidget {
  const _HomeTab();

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _balanceController;

  // Header slide down
  late Animation<Offset> _headerSlide;
  late Animation<double> _headerFade;

  // Balance card
  late Animation<double> _balanceFade;
  late Animation<Offset> _balanceSlide;
  late Animation<double> _balanceScale;

  // Action cards — staggered
  late Animation<double> _card1Fade;
  late Animation<Offset> _card1Slide;
  late Animation<double> _card2Fade;
  late Animation<Offset> _card2Slide;
  late Animation<double> _card3Fade;
  late Animation<Offset> _card3Slide;

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

    // Header: 0.0 → 0.35
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

    // Balance card: 0.15 → 0.55
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
    _balanceScale = Tween<double>(begin: 0.95, end: 1.0).animate(CurvedAnimation(
      parent: _balanceController,
      curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
    ));

    // Card 1 (Orders): 0.35 → 0.65
    _card1Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.35, 0.65, curve: Curves.easeOut),
    ));
    _card1Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.35, 0.65, curve: Curves.easeOutCubic),
    ));

    // Card 2 (Offers): 0.45 → 0.75
    _card2Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.45, 0.75, curve: Curves.easeOut),
    ));
    _card2Slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.45, 0.75, curve: Curves.easeOutCubic),
    ));

    // Card 3 (Reviews): 0.6 → 0.9
    _card3Fade = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 0.9, curve: Curves.easeOut),
    ));
    _card3Slide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _mainController,
      curve: const Interval(0.6, 0.9, curve: Curves.easeOutCubic),
    ));

    // Start animations
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
    final controller = Get.find<IndependentTailorHomeController>();

    return Obx(() {
      if (controller.isFirstLoad.value) {
        return const IndependentTailorHomeShimmer();
      }

      return Stack(
        children: [
          AnimatedBuilder(
            animation: Listenable.merge([_mainController, _balanceController]),
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
                            onAvailabilityChanged: controller.changeAvailability,
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
                          parent: BouncingScrollPhysics(),
                        ),
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

                            /// Action Cards Grid
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Row 1: Orders + Offers (staggered)
                                  Row(
                                    children: [
                                      /// Orders Card
                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card1Fade,
                                          child: SlideTransition(
                                            position: _card1Slide,
                                            child: Obx(() => ActionCardWidget(
                                                  svgIconPath:
                                                      ManagerIcons.customOrderIcon,
                                                  iconBackgroundColor:
                                                      ManagerColors.primaryColor
                                                          .withOpacity(0.1),
                                                  iconColor:
                                                      ManagerColors.primaryColor,
                                                  title: ManagerStrings
                                                      .homeOrdersTitle,
                                                  subtitle: ManagerStrings
                                                      .homeOrdersSubtitle,
                                                  badge: controller.homeData.value
                                                              ?.zoqakAvailableForOffersCount !=
                                                          null
                                                      ? controller.homeData.value!
                                                          .zoqakAvailableForOffersCount
                                                          .toString()
                                                      : null,
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                        context,
                                                        Routes.suggestedRequests,
                                                      ),
                                                )),
                                          ),
                                        ),
                                      ),

                                      SizedBox(width: ManagerWidth.w12),

                                      /// Offers Card
                                      Expanded(
                                        child: FadeTransition(
                                          opacity: _card2Fade,
                                          child: SlideTransition(
                                            position: _card2Slide,
                                            child: Obx(() => ActionCardWidget(
                                                  icon:
                                                      Icons.local_offer_rounded,
                                                  iconBackgroundColor:
                                                      ManagerColors.primaryColor
                                                          .withOpacity(0.1),
                                                  iconColor:
                                                      ManagerColors.primaryColor,
                                                  title: ManagerStrings
                                                      .homeOffersTitle,
                                                  subtitle: ManagerStrings
                                                      .homeOffersSubtitle,
                                                  badge: controller.homeData.value
                                                              ?.zoqakOrdersCount !=
                                                          null
                                                      ? controller.homeData.value!
                                                          .zoqakOrdersCount
                                                          .toString()
                                                      : null,
                                                  onTap: () =>
                                                      Navigator.pushNamed(
                                                        context,
                                                        Routes.myOffers,
                                                      ),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: ManagerHeight.h12),

                                  /// Row 2: Reviews
                                  FadeTransition(
                                    opacity: _card3Fade,
                                    child: SlideTransition(
                                      position: _card3Slide,
                                      child: SizedBox(
                                        width: (MediaQuery.of(context).size.width -
                                                ManagerWidth.w16 * 2 -
                                                ManagerWidth.w12) /
                                            2,
                                        child: Obx(() => ActionCardWidget(
                                              icon: Icons.star_outline_rounded,
                                              iconBackgroundColor: ManagerColors
                                                  .primaryColor
                                                  .withOpacity(0.1),
                                              iconColor:
                                                  ManagerColors.primaryColor,
                                              title:
                                                  ManagerStrings.homeReviewsTitle,
                                              subtitle: ManagerStrings
                                                  .homeReviewsSubtitle,
                                              badge: controller.homeData.value
                                                          ?.reviewsCount !=
                                                      null
                                                  ? controller.homeData.value!
                                                      .reviewsCount
                                                      .toString()
                                                  : null,
                                              onTap: () => Navigator.pushNamed(
                                                  context,
                                                  Routes.customerReviews),
                                            )),
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

          /// Loading overlay while changing availability
          Obx(() => controller.isChangingAvailability.value
              ? const LoadingWidget()
              : const SizedBox.shrink()),
        ],
      );
    });
  }
}

// /// ── Order Tracking Tab ──
// /// Embedded order tracking with green header, filter tabs, and order cards.
// class _OrderTrackingTab extends StatefulWidget {
//   const _OrderTrackingTab();

//   @override
//   State<_OrderTrackingTab> createState() => _OrderTrackingTabState();
// }

// class _OrderTrackingTabState extends State<_OrderTrackingTab> {
//   int _selectedFilterIndex = 0;
//   final List<OrderTrackingModel> _allOrders = OrderTrackingMockData.orders;

//   List<OrderTrackingModel> get _filteredOrders {
//     switch (_selectedFilterIndex) {
//       case 1:
//         return _allOrders.where((o) => o.status == OrderStatus.ready).toList();
//       case 2:
//         return _allOrders
//             .where((o) => o.status == OrderStatus.inProgress)
//             .toList();
//       case 3:
//         return _allOrders
//             .where((o) => o.status == OrderStatus.readyForDelivery)
//             .toList();
//       default:
//         return _allOrders;
//     }
//   }

//   List<OrderFilterItem> get _filterItems {
//     return [
//       OrderFilterItem(
//         label: ManagerStrings.orderTrackingFilterAll,
//         count: _allOrders.length,
//       ),
//       OrderFilterItem(
//         label: ManagerStrings.orderTrackingFilterReady,
//         count: _allOrders.where((o) => o.status == OrderStatus.ready).length,
//       ),
//       OrderFilterItem(
//         label: ManagerStrings.orderTrackingFilterInProgress,
//         count:
//             _allOrders.where((o) => o.status == OrderStatus.inProgress).length,
//       ),
//       OrderFilterItem(
//         label: ManagerStrings.orderTrackingFilterReadyForDelivery,
//         count: _allOrders
//             .where((o) => o.status == OrderStatus.readyForDelivery)
//             .length,
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     final orders = _filteredOrders;

//     return Column(
//       children: [
//         /// Green Header with Filter Tabs
//         Container(
//           color: ManagerColors.primaryColor,
//           padding: EdgeInsets.only(
//             top: MediaQuery.of(context).padding.top,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// Title
//               Padding(
//                 padding: EdgeInsets.only(
//                   top: ManagerHeight.h12,
//                   right: ManagerWidth.w16,
//                   left: ManagerWidth.w16,
//                   bottom: ManagerHeight.h8,
//                 ),
//                 child: Text(
//                   ManagerStrings.orderTrackingTitle,
//                   style: getRegularTextStyle(
//                     fontSize: ManagerFontSize.s16,
//                     color: ManagerColors.white,
//                   ),
//                 ),
//               ),

//               /// Filter Tabs inside green header
//               OrderFilterTabs(
//                 selectedIndex: _selectedFilterIndex,
//                 onSelected: (index) {
//                   setState(() => _selectedFilterIndex = index);
//                 },
//                 filters: _filterItems,
//                 isDarkBackground: true,
//               ),
//             ],
//           ),
//         ),

//         /// Scrollable Order Cards
//         Expanded(
//           child: orders.isEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.inbox_outlined,
//                         size: 56,
//                         color: ManagerColors.greyWhiteColor.withOpacity(0.4),
//                       ),
//                       SizedBox(height: ManagerHeight.h12),
//                       Text(
//                         'لا توجد طلبات',
//                         style: getMediumTextStyle(
//                           fontSize: ManagerFontSize.s16,
//                           color: ManagerColors.greyWhiteColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : ListView.separated(
//                   physics: const BouncingScrollPhysics(),
//                   padding: EdgeInsets.symmetric(
//                     vertical: ManagerHeight.h12,
//                   ),
//                   itemCount: orders.length,
//                   separatorBuilder: (_, __) =>
//                       SizedBox(height: ManagerHeight.h4),
//                   itemBuilder: (context, index) {
//                     return OrderTrackingCard(
//                       order: orders[index],
//                       onChat: () {
//                         // TODO: Navigate to chat
//                       },
//                       onActionButton: () {
//                         // TODO: Handle status update
//                       },
//                     );
//                   },
//                 ),
//         ),
//       ],
//     );
