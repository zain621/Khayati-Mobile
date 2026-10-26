import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_filter_tabs.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/domain/model/shop_owner_order_model.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/presentation/controller/store_order_tracking_controller.dart';
import 'package:app_mobile/features/providers/store_user/store_order_tracking/widgets/store_order_tracking_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreOrderTrackingScreen extends StatelessWidget {
  const StoreOrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoreOrderTrackingController>();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(() {
            final isLoading      = controller.isLoading.value;
            final filteredOrders = controller.filteredOrders;
            final selectedIndex  = controller.selectedFilterIndex.value;

            final filterItems = [
              OrderFilterItem(
                label: ManagerStrings.orderTrackingFilterAll,
                count: controller.allOrders.length,
              ),
              OrderFilterItem(
                label: ManagerStrings.storeOrderFilterNew,
                count: controller.newOrdersCount,
              ),
              OrderFilterItem(
                label: ManagerStrings.storeOrderFilterInPrep,
                count: controller.inPrepCount,
              ),
              OrderFilterItem(
                label: ManagerStrings.storeOrderFilterReady,
                count: controller.readyCount,
              ),
            ];

            return Column(
              children: [
                // ── Green header ─────────────────────────────────────────
                Container(
                  color: ManagerColors.primaryColor,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ManagerHeight.h12,
                          right: ManagerWidth.w16,
                          left: ManagerWidth.w16,
                          bottom: ManagerHeight.h8,
                        ),
                        child: Center(
                          child: Text(
                            ManagerStrings.storeOrderTitle,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s16,
                              color: ManagerColors.white,
                            ),
                          ),
                        ),
                      ),
                      OrderFilterTabs(
                        selectedIndex: selectedIndex,
                        onSelected: controller.selectFilter,
                        filters: filterItems,
                        isDarkBackground: true,
                      ),
                    ],
                  ),
                ),

                // ── Content ──────────────────────────────────────────────
                Expanded(
                  child: isLoading
                      ? const StoreOrderTrackingShimmer()
                      : RefreshIndicator(
                          onRefresh: controller.refreshOrders,
                          color: ManagerColors.primaryColor,
                          child: filteredOrders.isEmpty
                              ? ListView(
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.inbox_outlined,
                                              size: 56,
                                              color: ManagerColors
                                                  .greyWhiteColor
                                                  .withOpacity(0.4),
                                            ),
                                            SizedBox(height: ManagerHeight.h12),
                                            Text(
                                              ManagerStrings.storeOrderNoOrders,
                                              style: getMediumTextStyle(
                                                fontSize: ManagerFontSize.s16,
                                                color: ManagerColors
                                                    .greyWhiteColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(
                                    vertical: ManagerHeight.h12,
                                  ),
                                  itemCount: filteredOrders.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: ManagerHeight.h4),
                                  itemBuilder: (context, index) {
                                    final order = filteredOrders[index];
                                    return Obx(
                                      () => StoreOrderCard(
                                        order: order,
                                        isUpdatingStage: controller
                                            .isUpdatingStage.value,
                                        onViewDetails: () =>
                                            _showDetails(context, controller, order),
                                        onCall: () => _launchPhone(order.buyer.phoneNumber),
                                        onPrimaryAction: () {
                                          final nextKey = order.nextStageKey;
                                          if (nextKey != null) {
                                            controller.updateOrderStage(
                                              orderId:  order.id,
                                              stageKey: nextKey,
                                            );
                                          }
                                        },
                                      ),
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

  void _showDetails(
    BuildContext context,
    StoreOrderTrackingController controller,
    ShopOwnerOrderModel order,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Obx(
        () => StoreOrderDetailSheet(
          order: order,
          isUpdatingStage: controller.isUpdatingStage.value,
          onUpdateStatus: () {
            final nextKey = order.nextStageKey;
            if (nextKey != null) {
              Navigator.of(context).pop();
              controller.updateOrderStage(
                orderId:  order.id,
                stageKey: nextKey,
              );
            }
          },
          onCall: () => _launchPhone(order.buyer.phoneNumber),
          onChat: () {
            Navigator.of(context).pop();
            controller.navigateToChat(
              buyerId: order.buyer.id,
              buyerName: order.buyer.fullName,
              avatarUrl: order.buyer.imageUrl,
            );
          },
        ),
      ),
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
