import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/di/di.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/my_offer_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/controller/my_offers_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/edit_offer_bottom_sheet.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/my_offer_card.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/widgets/order_filter_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Screen displaying the tailor's submitted offers with filter tabs.
/// Custom green header (like OrderTrackingScreen) with back button.
class MyOffersScreen extends StatefulWidget {
  const MyOffersScreen({super.key});

  @override
  State<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends State<MyOffersScreen> {
  late final MyOffersController _controller;

  @override
  void initState() {
    super.initState();
    initMyOffers();
    _controller = Get.find<MyOffersController>();
  }

  @override
  void dispose() {
    disposeMyOffers();
    super.dispose();
  }

  List<OrderFilterItem> _buildFilterItems(List<MyOfferModel> allOffers) {
    return [
      OrderFilterItem(
        label: ManagerStrings.myOffersFilterAll,
        count: allOffers.length,
      ),
      OrderFilterItem(
        label: ManagerStrings.myOffersFilterUnderReview,
        count: allOffers
            .where((o) => o.myOffer.status == OfferStatus.underReview)
            .length,
      ),
      OrderFilterItem(
        label: ManagerStrings.myOffersFilterAccepted,
        count: allOffers
            .where((o) => o.myOffer.status == OfferStatus.accepted)
            .length,
      ),
      OrderFilterItem(
        label: ManagerStrings.myOffersFilterRejected,
        count: allOffers
            .where((o) => o.myOffer.status == OfferStatus.rejected)
            .length,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(() {
            final allOffers = _controller.allOffers;
            final offers = _controller.filteredOffers;
            final filterItems = _buildFilterItems(allOffers);

            return Stack(
              children: [
                Column(
                  children: [
                    /// Green Header with Back Button + Title + Filter Tabs
                    Container(
                      color: ManagerColors.primaryColor,
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// Title Row with Back Button
                          Padding(
                            padding: EdgeInsets.only(
                              top: ManagerHeight.h12,
                              right: ManagerWidth.w16,
                              left: ManagerWidth.w16,
                              bottom: ManagerHeight.h8,
                            ),
                            child: Row(
                              children: [
                                /// Back Button
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    height: ManagerHeight.h34,
                                    width: ManagerWidth.w34,
                                    padding: EdgeInsets.all(ManagerWidth.w4),
                                    decoration: BoxDecoration(
                                      color:
                                          ManagerColors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: ManagerColors.white,
                                      size: ManagerHeight.h24,
                                    ),
                                  ),
                                ),

                                /// Centered Title
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      ManagerStrings.myOffersTitle,
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s16,
                                        color: ManagerColors.white,
                                      ),
                                    ),
                                  ),
                                ),

                                /// Spacer to balance back button
                                SizedBox(width: ManagerWidth.w34),
                              ],
                            ),
                          ),

                          /// Filter Tabs inside green header
                          OrderFilterTabs(
                            selectedIndex: _controller.selectedFilterIndex.value,
                            onSelected: (index) {
                              _controller.selectedFilterIndex.value = index;
                            },
                            filters: filterItems,
                            isDarkBackground: true,
                          ),
                        ],
                      ),
                    ),

                    /// Scrollable Offer Cards
                    Expanded(
                      child: offers.isEmpty && !_controller.isLoading.value
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.inbox_outlined,
                                    size: 56,
                                    color: ManagerColors.greyWhiteColor
                                        .withOpacity(0.4),
                                  ),
                                  SizedBox(height: ManagerHeight.h12),
                                  Text(
                                    ManagerStrings.myOffersNoOffers,
                                    style: getMediumTextStyle(
                                      fontSize: ManagerFontSize.s16,
                                      color: ManagerColors.greyWhiteColor,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: _controller.fetchMyOffers,
                              color: ManagerColors.primaryColor,
                              child: ListView.separated(
                                physics: const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  vertical: ManagerHeight.h12,
                                ),
                                itemCount: offers.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: ManagerHeight.h4),
                                itemBuilder: (context, index) {
                                  return MyOfferCard(
                                    offer: offers[index],
                                    onTrackOrders: () {
                                      Navigator.pushNamed(
                                        context,
                                        Routes.orderDetailForTailor,
                                        arguments: {
                                          'orderId': offers[index].orderId,
                                        },
                                      );
                                    },
                                    onEditOffer: () {
                                      EditOfferBottomSheet.show(
                                        context,
                                        offers[index],
                                      );
                                    },
                                    onWithdrawOffer: () async {
                                      final confirmed =
                                          await CustomConfirmDialog.show(
                                        context: context,
                                        title: ManagerStrings
                                            .myOffersConfirmWithdrawTitle,
                                        subtitle: ManagerStrings
                                            .myOffersConfirmWithdrawBody,
                                        confirmText:
                                            ManagerStrings.myOffersConfirmYes,
                                        cancelText:
                                            ManagerStrings.myOffersConfirmNo,
                                      );
                                      if (confirmed == true) {
                                        _controller.deleteOffer(
                                            offers[index].myOffer.id);
                                      }
                                    },
                                    onDelete: () async {
                                      final confirmed =
                                          await CustomConfirmDialog.show(
                                        context: context,
                                        title: ManagerStrings
                                            .myOffersConfirmDeleteTitle,
                                        subtitle: ManagerStrings
                                            .myOffersConfirmDeleteBody,
                                        confirmText:
                                            ManagerStrings.myOffersConfirmYes,
                                        cancelText:
                                            ManagerStrings.myOffersConfirmNo,
                                      );
                                      if (confirmed == true) {
                                        _controller.deleteOffer(
                                            offers[index].myOffer.id);
                                      }
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),

                /// Full-screen loading overlay
                if (_controller.isLoading.value)
                  const LoadingWidget(),
              ],
            );
          }),
        ),
      ),
    );
  }
}
