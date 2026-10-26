import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/domain/model/comprehensive_order_tracking_model.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/presentation/controller/comprehensive_order_tracking_controller.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/order_traking_comprehensive/presentation/widgets/comprehensive_order_tracking_widgets.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_filter_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ComprehensiveOrderTrackingScreen extends StatelessWidget {
  const ComprehensiveOrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComprehensiveOrderTrackingController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: DefaultTabController(
        length: 2,
        child: AppSafeArea(
          child: Scaffold(
            backgroundColor: ManagerColors.white,
            body: Column(
              children: [
                // ── Green header ─────────────────────────────────────────
                Container(
                  color: ManagerColors.primaryColor,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ManagerHeight.h12,
                          bottom: ManagerHeight.h8,
                        ),
                        child: Center(
                          child: Text(
                            ManagerStrings.ctOrderTrackingTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ManagerWidth.w16,
                          vertical: ManagerHeight.h8,
                        ),
                        child: Container(
                          height: ManagerHeight.h40,
                          decoration: BoxDecoration(
                            color: ManagerColors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TabBar(
                            indicator: BoxDecoration(
                              color: ManagerColors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            labelColor: ManagerColors.primaryColor,
                            unselectedLabelColor:
                                ManagerColors.white.withOpacity(0.8),
                            labelStyle: getBoldTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.primaryColor,
                            ),
                            unselectedLabelStyle: getMediumTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.white.withOpacity(0.8),
                            ),
                            tabs: [
                              Tab(text: ManagerStrings.ctOrderTabShop),
                              Tab(text: ManagerStrings.ctOrderTabZoqak),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Tab content ──────────────────────────────────────────
                Expanded(
                  child: TabBarView(
                    children: [
                      _ShopOrdersTab(controller: controller),
                      _ZoqakOrdersTab(controller: controller),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shop Orders Tab
// ─────────────────────────────────────────────────────────────────────────────

class _ShopOrdersTab extends StatelessWidget {
  final ComprehensiveOrderTrackingController controller;

  const _ShopOrdersTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final filteredOrders = controller.filteredShopOrders;
      final selectedIndex = controller.selectedShopFilterIndex.value;

      final filterItems = [
        OrderFilterItem(
          label: ManagerStrings.orderTrackingFilterAll,
          count: controller.shopOrders.length,
        ),
        OrderFilterItem(
          label: ManagerStrings.storeOrderFilterNew,
          count: controller.shopNewOrdersCount,
        ),
        OrderFilterItem(
          label: ManagerStrings.storeOrderFilterInPrep,
          count: controller.shopInPrepCount,
        ),
        OrderFilterItem(
          label: ManagerStrings.storeOrderFilterReady,
          count: controller.shopReadyCount,
        ),
      ];

      return Column(
        children: [
          // Filter tabs
          Container(
            color: ManagerColors.white,
            child: OrderFilterTabs(
              selectedIndex: selectedIndex,
              onSelected: controller.selectShopFilter,
              filters: filterItems,
              isDarkBackground: false,
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                isLoading
                    ? const ComprehensiveOrderTrackingShimmer()
                    : RefreshIndicator(
                        onRefresh: controller.refreshOrders,
                        color: ManagerColors.primaryColor,
                        child: filteredOrders.isEmpty
                            ? ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.35,
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.shopping_cart_outlined,
                                            size: 64,
                                            color: ManagerColors.greyWhiteColor
                                                .withOpacity(0.2),
                                          ),
                                          SizedBox(height: ManagerHeight.h16),
                                          Text(
                                            ManagerStrings.ctOrderShopNoOrders,
                                            style: getBoldTextStyle(
                                              fontSize: ManagerFontSize.s16,
                                              color: ManagerColors.black,
                                            ),
                                          ),
                                          SizedBox(height: ManagerHeight.h6),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: ManagerWidth.w40,
                                            ),
                                            child: Text(
                                              ManagerStrings.ctOrderZoqakFilterNoOrders,
                                              // No orders in this category
                                              style: getRegularTextStyle(
                                                fontSize: ManagerFontSize.s13,
                                                color: ManagerColors
                                                    .greyWhiteColor,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: ManagerHeight.h12,
                                ),
                                itemCount: filteredOrders.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: ManagerHeight.h4),
                                itemBuilder: (context, index) {
                                  final order = filteredOrders[index];
                                  return Obx(
                                    () => ComprehensiveShopOrderCard(
                                      order: order,
                                      isUpdatingStage:
                                          controller.isUpdatingStage.value,
                                      onViewDetails: () =>
                                          _showShopOrderDetails(
                                              context, controller, order),
                                      onChat: () {
                                        controller.navigateToChat(
                                          userId: order.buyer.id,
                                          userName: order.buyer.fullName,
                                          avatarUrl: order.buyer.imageUrl,
                                        );
                                      },
                                      onCall: () =>
                                          _launchPhone(order.buyer.phoneNumber),
                                      onPrimaryAction: () {
                                        final nextKey = order.nextStageKey;
                                        if (nextKey != null) {
                                          controller.updateOrderStage(
                                            orderId: order.id,
                                            stageKey: nextKey,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                Obx(
                  () => controller.isLoadingDetails.value
                      ? const LoadingWidget()
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  void _showShopOrderDetails(
    BuildContext context,
    ComprehensiveOrderTrackingController controller,
    order,
  ) {
    Get.bottomSheet(
      Obx(
        () => ComprehensiveShopOrderDetailSheet(
          order: order,
          isUpdatingStage: controller.isUpdatingStage.value,
          onUpdateStatus: () {
            final nextKey = order.nextStageKey;
            if (nextKey != null) {
              Get.back();
              controller.updateOrderStage(
                orderId: order.id,
                stageKey: nextKey,
              );
            }
          },
          onCall: () => _launchPhone(order.buyer.phoneNumber),
          onChat: () {
            Get.back();
            controller.navigateToChat(
              userId: order.buyer.id,
              userName: order.buyer.fullName,
              avatarUrl: order.buyer.imageUrl,
            );
          },
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      ignoreSafeArea: false,
    );
  }

  Future<void> _launchPhone(String phoneNumber) async {
    if (phoneNumber.isEmpty) return;
    final uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Zoqak Orders Tab
// ─────────────────────────────────────────────────────────────────────────────

class _ZoqakOrdersTab extends StatelessWidget {
  final ComprehensiveOrderTrackingController controller;

  const _ZoqakOrdersTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = controller.isLoading.value;
      final orders = controller.filteredZoqakOrders;
      final selectedIndex = controller.selectedZoqakFilterIndex.value;

      final filterItems = [
        OrderFilterItem(
          label: ManagerStrings.orderTrackingFilterAll,
          count: controller.zoqakOrders.length,
        ),
        OrderFilterItem(
          label: ManagerStrings.ctOrderZoqakFilterPending,
          count: controller.zoqakPendingCount,
        ),
        OrderFilterItem(
          label: ManagerStrings.orderTrackingFilterAccepted,
          count: controller.zoqakAcceptedCount,
        ),
        OrderFilterItem(
          label: ManagerStrings.orderTrackingFilterCompleted,
          count: controller.zoqakCompletedCount,
        ),
        OrderFilterItem(
          label: ManagerStrings.ctOrderZoqakFilterCancelled,
          count: controller.zoqakCancelledCount,
        ),
      ];

      if (isLoading) {
        return const ComprehensiveOrderTrackingShimmer();
      }

      return Column(
        children: [
          Container(
            color: ManagerColors.white,
            child: OrderFilterTabs(
              selectedIndex: selectedIndex,
              onSelected: controller.selectZoqakFilter,
              filters: filterItems,
              isDarkBackground: false,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.refreshOrders,
              color: ManagerColors.primaryColor,
              child: orders.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.inbox_outlined,
                                  size: 64,
                                  color: ManagerColors.greyWhiteColor
                                      .withOpacity(0.3),
                                ),
                                SizedBox(height: ManagerHeight.h16),
                                Text(
                                  ManagerStrings.ctOrderZoqakNoOrdersTitle,
                                  style: getBoldTextStyle(
                                    fontSize: ManagerFontSize.s16,
                                    color: ManagerColors.black,
                                  ),
                                ),
                                SizedBox(height: ManagerHeight.h6),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ManagerWidth.w40,
                                  ),
                                  child: Text(
                                    ManagerStrings.ctOrderZoqakNoOrdersSubtitle,
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s13,
                                      color: ManagerColors.greyWhiteColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: ManagerHeight.h12),
                      itemCount: orders.length,
                      separatorBuilder: (_, __) =>
                          SizedBox(height: ManagerHeight.h4),
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        final statusKey = order.statusKey.toLowerCase();
                        final canStart = statusKey == 'accepted';
                        final canMarkReady = statusKey == 'in_progress';
                        final canMarkReadyForDelivery = statusKey == 'ready';
                        final canComplete = statusKey == 'ready_for_delivery';
                        final hasAction = canStart ||
                            canMarkReady ||
                            canMarkReadyForDelivery ||
                            canComplete;

                        final statusActionLabel = canStart
                            ? ManagerStrings.ctOrderZoqakStartWork
                            : canMarkReady
                                ? ManagerStrings.ctOrderZoqakMarkReady
                                : canMarkReadyForDelivery
                                    ? ManagerStrings
                                        .ctOrderZoqakMarkReadyForDelivery
                                    : canComplete
                                        ? ManagerStrings.ctOrderZoqakCompleteWork
                                        : null;

                        return Obx(
                          () => ComprehensiveZoqakOrderCard(
                            order: order,
                            isUpdatingStatus:
                                controller.isUpdatingZoqakStatus.value,
                            statusActionLabel: statusActionLabel,
                            onChat: () {
                              controller.navigateToChat(
                                userId: order.userId ?? '',
                                userName: order.userName,
                                avatarUrl: order.userImage,
                              );
                            },
                            onViewOffer: () {
                              _showZoqakOfferDetails(
                                context,
                                controller,
                                order,
                              );
                            },
                            onUpdateStatus: hasAction
                                ? () {
                                    final nextStatus = canStart
                                        ? 'in_progress'
                                        : canMarkReady
                                            ? 'ready'
                                            : canMarkReadyForDelivery
                                                ? 'ready_for_delivery'
                                                : canComplete
                                                    ? 'completed'
                                                    : null;
                                    if (nextStatus != null) {
                                      controller.updateZoqakOrderStatus(
                                        orderId: order.id,
                                        newStatus: nextStatus,
                                      );
                                    }
                                  }
                                : null,
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      );
    });
  }

  void _showZoqakOfferDetails(
    BuildContext context,
    ComprehensiveOrderTrackingController controller,
    ComprehensiveZoqakOrderModel order,
  ) {
    Get.bottomSheet(
      Obx(() {
        if (controller.isLoadingOfferDetail.value) {
          return Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        return const SizedBox.shrink();
      }),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      ignoreSafeArea: false,
    );

    controller.fetchZoqakOfferByOrderId(order.id).then((detail) {
      if (Get.isBottomSheetOpen ?? false) Get.back();
      if (detail != null) {
        Get.bottomSheet(
          ComprehensiveZoqakOfferDetailSheet(detail: detail),
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          ignoreSafeArea: false,
        );
      }
    });
  }
}
