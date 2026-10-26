import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_filter_tabs.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_model.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/di/di.dart' as my_orders_di;
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/my_orders_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/user_order_card.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

/// User "My Orders" screen — طلباتي
/// Mirrors the design pattern of OrderTrackingScreen:
///  - Green header with centred title + OrderFilterTabs
///  - Scrollable list of UserOrderCard below
class MyOrdersUserScreen extends StatefulWidget {
  const MyOrdersUserScreen({super.key});

  @override
  State<MyOrdersUserScreen> createState() => _MyOrdersUserScreenState();
}

class _MyOrdersUserScreenState extends State<MyOrdersUserScreen> {
  late MyOrdersController _controller;

  @override
  void initState() {
    super.initState();
    my_orders_di.initMyOrders(forceRefresh: true);
    _controller = Get.find<MyOrdersController>();
  }

  // ── Filter items ──────────────────────────────────────────────────────────

  List<OrderFilterItem> _buildFilterItems(List<UserOrderModel> allOrders) {
    final waitingCount = allOrders
        .where((o) =>
            o.status == UserOrderStatus.waitingOffers ||
            o.status == UserOrderStatus.hasOffers)
        .length;
    final inProgressCount =
        allOrders.where((o) => o.status == UserOrderStatus.inProgress).length;
    final readyCount = allOrders
        .where((o) => o.status == UserOrderStatus.readyForDelivery)
        .length;
    final completedCount =
        allOrders.where((o) => o.status == UserOrderStatus.completed).length;

    return [
      OrderFilterItem(label: ManagerStrings.myOrdersFilterAll, count: allOrders.length),
      OrderFilterItem(label: ManagerStrings.myOrdersFilterWaiting, count: waitingCount),
      OrderFilterItem(label: ManagerStrings.myOrdersFilterInProgress, count: inProgressCount),
      OrderFilterItem(label: ManagerStrings.myOrdersFilterReady, count: readyCount),
      OrderFilterItem(label: ManagerStrings.myOrdersFilterCompleted, count: completedCount),
    ];
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(() {
            final allOrders = _controller.allOrders;
            final orders = _controller.filteredOrders;
            final selectedIndex = _controller.selectedFilterIndex.value;
            final filterItems = _buildFilterItems(allOrders);

            return Column(
              children: [
                // ── Green header: title + filter tabs ────────────────────────
                Container(
                  color: ManagerColors.primaryColor,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: ManagerHeight.h12,
                            right: ManagerWidth.w16,
                            left: ManagerWidth.w16,
                            bottom: ManagerHeight.h8,
                          ),
                          child: Text(
                            ManagerStrings.myOrdersTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                      OrderFilterTabs(
                        selectedIndex: selectedIndex,
                        onSelected: (index) {
                          _controller.selectedFilterIndex.value = index;
                        },
                        filters: filterItems,
                        isDarkBackground: true,
                      ),
                    ],
                  ),
                ),

                // ── Order list / shimmer / empty state ───────────────────────
                Expanded(
                  child: _controller.isLoading.value
                      ? _buildShimmer()
                      : _controller.errorMessage.isNotEmpty
                          ? _buildErrorState()
                          : orders.isEmpty
                              ? _buildEmptyState()
                              : RefreshIndicator(
                                  onRefresh: _controller.refreshOrders,
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    padding: EdgeInsets.symmetric(
                                        vertical: ManagerHeight.h12),
                                    itemCount: orders.length,
                                    separatorBuilder: (_, __) =>
                                        SizedBox(height: ManagerHeight.h4),
                                    itemBuilder: (context, index) {
                                      final order = orders[index];
                                      return UserOrderCard(
                                        order: order,
                                        onTap: () {
                                          if (order.status ==
                                              UserOrderStatus.hasOffers) {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.submittedOffers,
                                              arguments: order.orderId,
                                            );
                                          } else {
                                            Navigator.pushNamed(
                                              context,
                                              Routes.orderDetails,
                                              arguments: order.orderId,
                                            );
                                          }
                                        },
                                        onChat: () {},
                                      );
                                    },
                                  ),
                                ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  // ── Shimmer ───────────────────────────────────────────────────────────────

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h12,
        ),
        itemCount: 5,
        separatorBuilder: (_, __) => SizedBox(height: ManagerHeight.h10),
        itemBuilder: (_, __) => Container(
          height: 130,
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }

  // ── Error state ───────────────────────────────────────────────────────────

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.error_outline_rounded,
              size: 48, color: ManagerColors.greyWhiteColor.withOpacity(0.5)),
          SizedBox(height: ManagerHeight.h12),
          Text(
            _controller.errorMessage.value,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.greyWhiteColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: ManagerHeight.h16),
          TextButton(
            onPressed: _controller.refreshOrders,
            child: Text(
              ManagerStrings.retry,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s14,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 56,
            color: ManagerColors.greyWhiteColor.withOpacity(0.4),
          ),
          SizedBox(height: ManagerHeight.h12),
          Text(
            ManagerStrings.myOrdersEmpty,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
