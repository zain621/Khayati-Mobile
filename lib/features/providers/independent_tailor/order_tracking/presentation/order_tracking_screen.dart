import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/domain/di/di.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/controller/order_tracking_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/widgets/order_tracking_detail_bottom_sheet.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/presentation/widgets/order_tracking_shimmer.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_filter_tabs.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_tracking_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class OrderTrackingScreen extends StatefulWidget {
  const OrderTrackingScreen({super.key});

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  @override
  void initState() {
    super.initState();
    initOrderTracking(forceRefresh: true);
  }

  @override
  void dispose() {
    // Do NOT Get.delete here — IndexedStack + offAllNamed race would wipe the
    // new account's OrderTrackingController after re-login.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OrderTrackingController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Obx(() {
          if (controller.isFirstLoad.value) {
            return const Scaffold(
              backgroundColor: ManagerColors.white,
              body: OrderTrackingShimmer(),
            );
          }

          final counts = controller.trackingData.value?.counts;
          final orders = controller.filteredOrders;

          final List<OrderFilterItem> filters = [
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterAll,
              count: counts?.all ?? 0,
            ),
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterAccepted,
              count: counts?.accepted ?? 0,
            ),
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterInProgress,
              count: counts?.inProgress ?? 0,
            ),
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterReady,
              count: counts?.ready ?? 0,
            ),
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterReadyForDelivery,
              count: counts?.readyForDelivery ?? 0,
            ),
            OrderFilterItem(
              label: ManagerStrings.orderTrackingFilterCompleted,
              count: counts?.completed ?? 0,
            ),
          ];

          return Scaffold(
            backgroundColor: ManagerColors.white,
            body: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      color: ManagerColors.primaryColor,
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
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
                                ManagerStrings.orderTrackingTitle,
                                style: getBoldTextStyle(
                                  fontSize: ManagerFontSize.s16,
                                  color: ManagerColors.white,
                                ),
                              ),
                            ),
                          ),
                          OrderFilterTabs(
                            selectedIndex: controller.selectedFilterIndex.value,
                            onSelected: controller.changeFilter,
                            filters: filters,
                            isDarkBackground: true,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        color: ManagerColors.primaryColor,
                        onRefresh: controller.refreshOrders,
                        child: orders.isEmpty
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(height: ManagerHeight.h120),
                                  Center(
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
                                          ManagerStrings.orderTrackingNoOrders,
                                          style: getMediumTextStyle(
                                            fontSize: ManagerFontSize.s16,
                                            color: ManagerColors.greyWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                padding: EdgeInsets.symmetric(vertical: ManagerHeight.h12),
                                itemCount: orders.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: ManagerHeight.h4),
                                itemBuilder: (context, index) {
                                  final order = orders[index];
                                  final actionLabel = controller.nextActionLabel(order.status);

                                  return OrderTrackingCard(
                                    order: order,
                                    actionLabel: actionLabel,
                                    onDetails: () async {
                                      final detail = await controller.fetchOrderDetail(order.orderId);
                                      if (!context.mounted || detail == null) return;
                                      await OrderTrackingDetailBottomSheet.show(context, detail);
                                    },
                                    onChat: () {
                                      // TODO: Navigate to chat.
                                    },
                                    onActionButton: actionLabel == null
                                        ? null
                                        : () => controller.updateOrderStatus(order),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
                Obx(() => (controller.isUpdatingStatus.value ||
                            controller.isLoadingDetails.value)
                    ? const LoadingWidget()
                    : const SizedBox.shrink()),
              ],
            ),
          );
        }),
      ),
    );
  }
}
