import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/user/cart/domain/di/di.dart' as cart_di;
import 'package:app_mobile/features/user/cart/presentation/controller/cart_controller.dart';
import 'package:app_mobile/features/user/home_user/domain/di/di.dart';
import 'package:app_mobile/features/user/product_details/presentation/widgets/add_to_cart_bottom_sheet.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/home_user_controller.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/custom_app_bar_user.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_custom_offer_card_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_map_card_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_best_tailors_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_products_grid_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_shimmer_widget.dart';
import 'package:app_mobile/features/user/home_user/presentation/widgets/home_shops_list_widget.dart';
import 'package:app_mobile/features/user/loyalty/domain/di/di.dart';
import 'package:app_mobile/features/user/loyalty/presentation/controller/loyalty_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeUserScreen extends StatefulWidget {
  const HomeUserScreen({super.key});

  @override
  State<HomeUserScreen> createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  late final HomeUserController controller;
  late final LoyaltyController loyaltyController;

  @override
  void initState() {
    super.initState();
    initHomeUser(forceRefresh: true);
    initLoyalty(forceRefresh: true);
    cart_di.initCart(forceRefresh: true);

    controller = Get.find<HomeUserController>();
    // Prefer freshly written prefs after a new login (guards against stale Rx).
    controller.reloadUserInfo();
    controller.fetchHome();
    loyaltyController = Get.find<LoyaltyController>();
    Get.find<CartController>();
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
          body: Column(
            children: [
              // ── App Bar (pinned — never scrolls) ───────────────────────────
              Obx(() => HomeUserAppBar(
                    userName: controller.userName.value,
                    userAvatar: controller.userAvatar.value.isNotEmpty
                        ? controller.userAvatar.value
                        : null,
                    loyaltyPoints: loyaltyController.loyaltyPoints.value.points,
                    onNotificationTap: () =>
                        Navigator.pushNamed(context, Routes.notificationScreen),
                    onCartTap: () =>
                        Navigator.pushNamed(context, Routes.cartScreen),
                    onLocationTap: () {},
                    onProfileTap: () =>
                        Navigator.pushNamed(context, Routes.profileUserScreen),
                    onSearchTap: () =>
                        Navigator.pushNamed(context, Routes.searchScreen),
                    onFilterTap: () {},
                    onLoyaltyTap: () => Navigator.pushNamed(
                        context, Routes.loyaltyPointsScreen),
                  )),

              // ── Scrollable content ─────────────────────────────────────────
              Expanded(
                // RefreshIndicator lives outside Obx so it isn't rebuilt on
                // every reactive change — only its child content is.
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.refreshHome();
                    await loyaltyController.fetchLoyaltyPoints();
                  },
                  color: ManagerColors.primaryColor,
                  child: Obx(() {
                    // First-load failure — do not read list Rx here or the
                    // whole page (and Google Map) is rebuilt on every assign.
                    if (controller.hasError.value &&
                        !controller.isLoading.value &&
                        !controller.hasLoadedOnce.value) {
                      return _HomeErrorView(onRetry: controller.refreshHome);
                    }
                    return _HomeContent(controller: controller);
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _HomeContent — scrollable home sections.
//
// Each section owns its own [Obx] so a change to one list (e.g. the nearby
// tailors preview that arrives after the main fetch) only rebuilds that
// section instead of the whole page.
// ─────────────────────────────────────────────────────────────────────────────
class _HomeContent extends StatelessWidget {
  final HomeUserController controller;

  const _HomeContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // AlwaysScrollable so pull-to-refresh works even when content is short.
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        children: [
          SizedBox(height: ManagerHeight.h16),

          // ── Map Card ───────────────────────────────────────────────────
          Obx(() {
            if (controller.isLoading.value && !controller.hasLoadedOnce.value) {
              return const HomeMapShimmer();
            }
            return HomeMapCardWidget(
              key: const ValueKey('home_dashboard_map'),
              controller: controller,
              onRefresh: controller.refreshHome,
              onExpandTap: () => Navigator.pushNamed(
                context,
                Routes.nearbyTailorsMapScreen,
              ),
            );
          }),

          SizedBox(height: ManagerHeight.h20),

          // ── Shops List ─────────────────────────────────────────────────
          Obx(() =>
              controller.isLoading.value && !controller.hasLoadedOnce.value
                  ? const HomeShopsShimmer()
                  : HomeShopsListWidget(
                  shops: controller.shops,
                  onViewAll: () =>
                      Navigator.pushNamed(context, Routes.allShopsScreen),
                  onShopTap: (shop) => Navigator.pushNamed(
                    context,
                    Routes.detailsShop,
                    arguments: shop.id,
                  ),
                )),

          SizedBox(height: ManagerHeight.h16),

          // ── Custom Offer Card ──────────────────────────────────────────
          Obx(() =>
              controller.isLoading.value && !controller.hasLoadedOnce.value
                  ? const HomeCustomOfferShimmer()
                  : HomeCustomOfferCardWidget(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.createOrderScreen),
                )),

          SizedBox(height: ManagerHeight.h20),

          // ── Products Grid ──────────────────────────────────────────────
          Obx(() =>
              controller.isLoading.value && !controller.hasLoadedOnce.value
                  ? const HomeProductsShimmer()
                  : HomeProductsGridWidget(
                  products: controller.products,
                  onViewAll: () =>
                      Navigator.pushNamed(context, Routes.allProductsScreen),
                  onProductTap: (product) => Navigator.pushNamed(
                    context,
                    Routes.productDetailsScreen,
                    arguments: product.id,
                  ),
                  onAddToCart: (product) =>
                      showAddToCartSheet(context, productId: product.id),
                )),

          SizedBox(height: ManagerHeight.h16),

          // ── Best Tailors ───────────────────────────────────────────────
          Obx(() =>
              controller.isLoading.value && !controller.hasLoadedOnce.value
                  ? const HomeTailorsShimmer()
                  : HomeBestTailorsWidget(
                  tailors: controller.tailors,
                  onViewAll: () {},
                  onTailorTap: (tailor) => Navigator.pushNamed(
                    context,
                    Routes.tailorDetailsScreen,
                    arguments: tailor.id,
                  ),
                )),

          SizedBox(height: ManagerHeight.h24),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _HomeErrorView — shown on first-load failure (e.g. no internet).
//
// Stays scrollable so the surrounding [RefreshIndicator] pull-to-refresh keeps
// working, in addition to the explicit retry button.
// ─────────────────────────────────────────────────────────────────────────────
class _HomeErrorView extends StatelessWidget {
  final Future<void> Function() onRetry;

  const _HomeErrorView({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: ManagerWidth.w80,
                      height: ManagerWidth.w80,
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.wifi_off_rounded,
                        size: ManagerFontSize.s36,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h20),
                    Text(
                      ManagerStrings.userHomeErrorTitle,
                      textAlign: TextAlign.center,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h8),
                    Text(
                      ManagerStrings.userHomeErrorSubtitle,
                      textAlign: TextAlign.center,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h24),
                    ElevatedButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh_rounded),
                      label: Text(ManagerStrings.retry),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ManagerColors.primaryColor,
                        foregroundColor: ManagerColors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w28,
                          vertical: ManagerHeight.h12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(ManagerRadius.r12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
