import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/order_detail_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/presentation/controller/my_offers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

/// Displays full details of a single order (tailor side).
class OrderDetailScreen extends StatefulWidget {
  final String orderId;

  const OrderDetailScreen({super.key, required this.orderId});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late final MyOffersController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<MyOffersController>();
    _controller.fetchOrderDetail(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: ManagerColors.white,
          body: Obx(() {
            if (_controller.isDetailLoading.value) {
              return const LoadingWidget();
            }

            final detail = _controller.orderDetail.value;
            if (detail == null) {
              return const SizedBox.shrink();
            }

            return _buildContent(context, detail);
          }),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, OrderDetailModel detail) {
    return Column(
      children: [
        _buildHeader(context, detail),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(ManagerWidth.w16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  ManagerStrings.orderDetailProductName,
                  detail.productName,
                ),
                SizedBox(height: ManagerHeight.h12),
                _buildInfoRow(
                  ManagerStrings.orderDetailDescription,
                  detail.description,
                ),
                if (detail.specialRequests.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h12),
                  _buildInfoRow(
                    ManagerStrings.orderDetailSpecialRequests,
                    detail.specialRequests,
                  ),
                ],
                SizedBox(height: ManagerHeight.h12),
                _buildInfoRow(
                  ManagerStrings.orderDetailFabricType,
                  detail.fabricType,
                ),
                SizedBox(height: ManagerHeight.h12),
                _buildInfoRow(
                  ManagerStrings.orderDetailBudget,
                  '${detail.budgetRange} ${ManagerStrings.myOffersCurrency}',
                ),
                SizedBox(height: ManagerHeight.h12),
                _buildInfoRow(
                  ManagerStrings.orderDetailDeliveryDate,
                  detail.deliveryDate,
                ),
                SizedBox(height: ManagerHeight.h12),
                _buildInfoRow(
                  ManagerStrings.orderDetailOffersCount,
                  '${detail.offersCount}',
                ),
                if (detail.similarImages.isNotEmpty) ...[
                  SizedBox(height: ManagerHeight.h20),
                  Text(
                    ManagerStrings.orderDetailImages,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h10),
                  _buildImagesGrid(detail.similarImages),
                ],
                SizedBox(height: ManagerHeight.h24),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, OrderDetailModel detail) {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: EdgeInsets.only(
          top: ManagerHeight.h12,
          right: ManagerWidth.w16,
          left: ManagerWidth.w16,
          bottom: ManagerHeight.h16,
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: ManagerHeight.h34,
                width: ManagerWidth.w34,
                padding: EdgeInsets.all(ManagerWidth.w4),
                decoration: BoxDecoration(
                  color: ManagerColors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: ManagerColors.white,
                  size: ManagerHeight.h24,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  '${ManagerStrings.orderDetailTitle} #${detail.orderNumber}',
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: ManagerWidth.w34),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(ManagerWidth.w12),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundTabBar,
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            value,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagesGrid(List<String> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (_, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          child: Image.network(
            images[index],
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: ManagerColors.backgroundTabBar,
              child: Icon(
                Icons.image_not_supported_outlined,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
