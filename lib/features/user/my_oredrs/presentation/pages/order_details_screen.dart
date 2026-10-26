import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/di/di.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_domain_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/order_details_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_shimmer.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_shop_section.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_summary_card.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_tab_bar.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_tracking_tab.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_zoqak_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore_for_file: use_build_context_synchronously

class OrderDetailsScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailsScreen({super.key, required this.orderId});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen>
    with TickerProviderStateMixin {
  late final OrderDetailsController _ctrl;
  late final TabController _tabController;

  // ── Entrance animation (runs once after data loads) ───────────────────────
  late final AnimationController _entranceCtrl;
  late final Animation<double> _summaryFade;
  late final Animation<Offset> _summarySlide;
  late final Animation<double> _tabBarFade;
  late final Animation<double> _contentFade;
  late final Animation<Offset> _contentSlide;

  bool _entrancePlayed = false;

  @override
  void initState() {
    super.initState();

    _ctrl = createOrderDetailsController();
    _tabController = TabController(length: 2, vsync: this);

    _entranceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    );

    _summaryFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
    );
    _summarySlide = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.0, 0.55, curve: Curves.easeOutCubic),
    ));
    _tabBarFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.30, 0.70, curve: Curves.easeOut),
    );
    _contentFade = CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.50, 1.0, curve: Curves.easeOut),
    );
    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _entranceCtrl,
      curve: const Interval(0.50, 1.0, curve: Curves.easeOutCubic),
    ));

    _ctrl.init(widget.orderId);

    ever(_ctrl.isLoading, (bool loading) {
      if (!loading && _ctrl.order.value != null && mounted && !_entrancePlayed) {
        _entrancePlayed = true;
        _entranceCtrl.forward();
      }
    });
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    _tabController.dispose();
    Get.delete<OrderDetailsController>();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    _entrancePlayed = false;
    _entranceCtrl.reset();
    _tabController.animateTo(0);
    await _ctrl.refresh();
  }

  // ── Error state ───────────────────────────────────────────────────────────

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withValues(alpha: 0.07),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 40,
                color: ManagerColors.primaryColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h20),
            Text(
              message.isNotEmpty
                  ? message
                  : ManagerStrings.orderDetailsNotFound,
              textAlign: TextAlign.center,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h28),
            FilledButton.icon(
              onPressed: () {
                _entrancePlayed = false;
                _ctrl.refresh();
              },
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(ManagerStrings.orderDetailsErrorRetry),
              style: FilledButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w28,
                  vertical: ManagerHeight.h14,
                ),
                shape: const StadiumBorder(),
              ),
            ),
            SizedBox(height: ManagerHeight.h12),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                ManagerStrings.goBack,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Content ───────────────────────────────────────────────────────────────

  Widget _buildContent(UserOrderDomainModel order) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: ManagerColors.primaryColor,
      displacement: 32,
      // ── CustomScrollView fixes the nested-scroll problem ────────────────
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // ── padding top ──
          SliverPadding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
            ).copyWith(top: ManagerHeight.h16),
            sliver: SliverToBoxAdapter(
              child: SlideTransition(
                position: _summarySlide,
                child: FadeTransition(
                  opacity: _summaryFade,
                  child: OrderDetailsSummaryCard(order: order),
                ),
              ),
            ),
          ),

          // ── gap ──
          SliverToBoxAdapter(child: SizedBox(height: ManagerHeight.h16)),

          // ── sticky tab bar ───────────────────────────────────────────
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              child: FadeTransition(
                opacity: _tabBarFade,
                child: Material(
                  color: const Color(0xFFF6F6F6),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w16,
                      vertical: ManagerHeight.h8,
                    ),
                    child: OrderDetailsTabBar(tabController: _tabController),
                  ),
                ),
              ),
            ),
          ),

          // ── tab content ──────────────────────────────────────────────
          // SliverToBoxAdapter renders content at its natural height so the
          // outer CustomScrollView can scroll the full page without clipping.
          SliverPadding(
            padding: EdgeInsets.only(
              left: ManagerWidth.w16,
              right: ManagerWidth.w16,
              top: ManagerHeight.h16,
              bottom: ManagerHeight.h40,
            ),
            sliver: SliverToBoxAdapter(
              child: FadeTransition(
                opacity: _contentFade,
                child: SlideTransition(
                  position: _contentSlide,
                  child: _TabContent(
                    tabController: _tabController,
                    order: order,
                    ctrl: _ctrl,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Root build ────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: ManagerStrings.orderDetailsTitle,
      subtitle:
          '${ManagerStrings.orderDetailsOrderNumberPrefix} ${widget.orderId}',
      onBackPressed: () => Navigator.of(context).pop(),
      useScrollView: false,
      child: Obx(() {
        if (_ctrl.isLoading.value) return const OrderDetailsShimmer();
        if (_ctrl.errorMessage.value.isNotEmpty &&
            _ctrl.order.value == null) {
          return _buildError(_ctrl.errorMessage.value);
        }
        final order = _ctrl.order.value;
        if (order == null) return _buildError('');
        return _buildContent(order);
      }),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _TabContent — switches between Details and Tracking with a smooth
// fade + horizontal slide via AnimatedSwitcher.
// Listens to TabController so the pill animation and content stay in sync.
// ─────────────────────────────────────────────────────────────────────────────

class _TabContent extends StatefulWidget {
  final TabController tabController;
  final UserOrderDomainModel order;
  final OrderDetailsController ctrl;

  const _TabContent({
    required this.tabController,
    required this.order,
    required this.ctrl,
  });

  @override
  State<_TabContent> createState() => _TabContentState();
}

class _TabContentState extends State<_TabContent> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    widget.tabController.addListener(_onTabChange);
  }

  void _onTabChange() {
    if (!widget.tabController.indexIsChanging) return;
    if (mounted) setState(() => _index = widget.tabController.index);
  }

  @override
  void dispose() {
    widget.tabController.removeListener(_onTabChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.03, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          )),
          child: child,
        ),
      ),
      child: _index == 0
          ? KeyedSubtree(
              key: const ValueKey(0),
              child: widget.order.isShop
                  ? Obx(
                      () => OrderDetailsShopSection(
                        order: widget.order,
                        isChatLoading: widget.ctrl.isChatLoading.value,
                        onChat: widget.ctrl.startChatWithShop,
                      ),
                    )
                  : Obx(
                      () => OrderDetailsZoqakSection(
                        order: widget.order,
                        isChatLoading: widget.ctrl.isChatLoading.value,
                        onChat: widget.order.acceptedByProviderId != null &&
                                widget.order.acceptedByProviderId!.isNotEmpty
                            ? widget.ctrl.startChatWithTailor
                            : null,
                      ),
                    ),
            )
          : KeyedSubtree(
              key: const ValueKey(1),
              child: OrderDetailsTrackingTab(
                steps: widget.ctrl.trackingSteps,
                completedCount: widget.ctrl.completedStepsCount,
              ),
            ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sticky header delegate for the tab bar
// ─────────────────────────────────────────────────────────────────────────────

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  const _StickyTabBarDelegate({required this.child});

  // tab bar height + vertical padding
  static const double _height = 66.0;

  @override
  double get minExtent => _height;
  @override
  double get maxExtent => _height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final shadow = shrinkOffset > 0;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        boxShadow: shadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_StickyTabBarDelegate old) => old.child != child;
}
