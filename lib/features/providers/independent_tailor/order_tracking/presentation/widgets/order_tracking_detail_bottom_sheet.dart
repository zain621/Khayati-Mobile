import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/independent_tailor/order_tracking/domain/model/order_tracking_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailBottomSheet extends StatelessWidget {
  final OrderTrackingDetailModel detail;

  const OrderTrackingDetailBottomSheet({
    super.key,
    required this.detail,
  });

  static Future<void> show(
    BuildContext context,
    OrderTrackingDetailModel detail,
  ) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => OrderTrackingDetailBottomSheet(detail: detail),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPaid = detail.paymentStatus.toLowerCase() == 'paid';

    return Directionality(
      textDirection: Directionality.of(context),
      child: DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.55,
        maxChildSize: 0.96,
        expand: false,
        builder: (_, scrollCtrl) {
          return SafeArea(
            top: false,
            bottom: true,
            child: Container(
              decoration: BoxDecoration(
                color: ManagerColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ManagerRadius.r20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ManagerColors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(context, isPaid),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: scrollCtrl,
                      padding: EdgeInsets.symmetric(
                        horizontal: ManagerWidth.w16,
                        vertical: ManagerHeight.h12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _section(
                            title: ManagerStrings.storeOrderCustomerSection,
                            child: _customerCard(),
                          ),
                          SizedBox(height: ManagerHeight.h12),
                          _section(
                            title: ManagerStrings.storeOrderProductsSection,
                            child: _productCard(),
                          ),
                          SizedBox(height: ManagerHeight.h12),
                          _section(
                            title: ManagerStrings.orderTrackingProgressLabel,
                            child: _stagesCard(),
                          ),
                          SizedBox(height: ManagerHeight.h12),
                          if (detail.similarImages.isNotEmpty)
                            _section(
                              title: ManagerStrings.orderTrackingDetails,
                              child: _imagesCard(),
                            ),
                          if (detail.similarImages.isNotEmpty)
                            SizedBox(height: ManagerHeight.h12),
                          if (detail.myOffer != null)
                            _section(
                              title: ManagerStrings.myOffersTitle,
                              child: _offerCard(),
                            ),
                          SizedBox(height: ManagerHeight.h18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isPaid) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.only(
              top: ManagerHeight.h10,
              bottom: ManagerHeight.h8,
            ),
            width: ManagerWidth.w40,
            height: ManagerHeight.h4,
            decoration: BoxDecoration(
              color: ManagerColors.greyWhiteColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(ManagerRadius.r10),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  ManagerStrings.storeOrderDetailTitle,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: ManagerWidth.w32,
                  height: ManagerHeight.h32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ManagerColors.backgroundTabBar,
                  ),
                  child: Icon(
                    Icons.close_rounded,
                    size: ManagerFontSize.s18,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  detail.orderNumber,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w10,
                  vertical: ManagerHeight.h4,
                ),
                decoration: BoxDecoration(
                  color: (isPaid ? ManagerColors.primaryColor : ManagerColors.redNew)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(ManagerRadius.r20),
                ),
                child: Text(
                  isPaid
                      ? ManagerStrings.orderTrackingPaid
                      : ManagerStrings.orderTrackingUnpaid,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s11,
                    color: isPaid ? ManagerColors.primaryColor : ManagerColors.redNew,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: ManagerHeight.h10),
        Divider(height: 1, color: ManagerColors.greyWhiteColor.withOpacity(0.2)),
      ],
    );
  }

  Widget _section({required String title, required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.greyWhiteColor.withOpacity(0.18),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.primaryColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _customerCard() {
    return Row(
      children: [
        Container(
          width: ManagerWidth.w46,
          height: ManagerHeight.h46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ManagerColors.backgroundTabBar,
            border: Border.all(color: ManagerColors.white, width: 1),
          ),
          child: ClipOval(
            child: (detail.userImage != null && detail.userImage!.isNotEmpty)
                ? CachedNetworkImage(
                    imageUrl: detail.userImage!,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Icon(
                      Icons.person,
                      size: ManagerFontSize.s20,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: ManagerFontSize.s20,
                    color: ManagerColors.greyWhiteColor,
                  ),
          ),
        ),
        SizedBox(width: ManagerWidth.w10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail.userName,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h4),
              Text(
                detail.userPhone,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _productCard() {
    return Column(
      children: [
        _labeledValue(ManagerStrings.orderTrackingDetailProductName, detail.productName),
        SizedBox(height: ManagerHeight.h8),
        _labeledValue(ManagerStrings.orderTrackingDetailFabricType, detail.fabricType),
        SizedBox(height: ManagerHeight.h8),
        _labeledValue(ManagerStrings.orderTrackingDetailBudgetRange, detail.budgetRange),
        SizedBox(height: ManagerHeight.h8),
        _labeledLongText(ManagerStrings.orderTrackingDetailDescription, detail.description),
        if (detail.specialRequests.isNotEmpty) ...[
          SizedBox(height: ManagerHeight.h8),
          _labeledLongText(
            ManagerStrings.orderTrackingDetailSpecialRequests,
            detail.specialRequests,
          ),
        ],
      ],
    );
  }

  Widget _stagesCard() {
    return Column(
      children: List.generate(detail.stages.length, (index) {
        final stage = detail.stages[index];
        final isLast = index == detail.stages.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : ManagerHeight.h10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      width: ManagerWidth.w22,
                      height: ManagerHeight.h22,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: stage.completed
                            ? ManagerColors.primaryColor
                            : ManagerColors.white,
                        border: Border.all(
                          color: stage.completed
                              ? ManagerColors.primaryColor
                              : ManagerColors.greyWhiteColor,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        stage.completed
                            ? Icons.check_rounded
                            : Icons.radio_button_unchecked,
                        size: ManagerFontSize.s12,
                        color: stage.completed
                            ? ManagerColors.white
                            : ManagerColors.greyWhiteColor,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 1,
                          margin: EdgeInsets.symmetric(vertical: ManagerHeight.h2),
                          color: ManagerColors.greyWhiteColor.withOpacity(0.45),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: ManagerWidth.w8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stage.label,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s12,
                          color: ManagerColors.black,
                        ),
                      ),
                      SizedBox(height: ManagerHeight.h2),
                      Text(
                        '${ManagerStrings.orderTrackingDetailStepDate}: ${detail._formatDate(stage.statusDate)}',
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s10,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _imagesCard() {
    return SizedBox(
      height: ManagerHeight.h88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: detail.similarImages.length,
        separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w8),
        itemBuilder: (_, index) {
          final image = detail.similarImages[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
            child: CachedNetworkImage(
              imageUrl: image,
              width: ManagerWidth.w110,
              height: ManagerHeight.h88,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(
                width: ManagerWidth.w110,
                color: ManagerColors.backgroundTabBar,
                child: Icon(
                  Icons.broken_image_outlined,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _offerCard() {
    final offer = detail.myOffer!;
    return Column(
      children: [
        _labeledValue(
          ManagerStrings.orderTrackingDetailOfferPrice,
          '${offer.proposedPrice.toInt()} ${ManagerStrings.orderTrackingCurrency}',
        ),
        SizedBox(height: ManagerHeight.h8),
        _labeledValue(
          ManagerStrings.orderTrackingDetailExecutionDays,
          '${offer.executionDays}',
        ),
        SizedBox(height: ManagerHeight.h8),
        _labeledLongText(ManagerStrings.orderTrackingDetailDescription, offer.details),
        SizedBox(height: ManagerHeight.h8),
        _labeledValue(
          ManagerStrings.orderTrackingDetailOfferDate,
          detail._formatDate(offer.createdAt),
        ),
      ],
    );
  }

  Widget _labeledValue(String label, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black,
            ),
          ),
        ),
      ],
    );
  }

  Widget _labeledLongText(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s12,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        SizedBox(height: ManagerHeight.h6),
        _fullText(text),
      ],
    );
  }

  Widget _fullText(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h8,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.backgroundTabBar.withOpacity(0.45),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
      ),
      child: Text(
        text,
        style: getRegularTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.black,
        ),
      ),
    );
  }
}

extension _DetailFormat on OrderTrackingDetailModel {
  String _formatDate(String raw) {
    if (raw.isEmpty) return '-';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return raw;
    }
  }
}
