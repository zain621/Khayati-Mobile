import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

/// Customer info row for offer cards.
/// Avatar + name + subtitle on the right, order ref on the left (RTL).
class OfferCustomerRow extends StatelessWidget {
  final String customerName;
  final String? customerImage;
  final String orderSubtitle;
  final String orderId;

  const OfferCustomerRow({
    super.key,
    required this.customerName,
    this.customerImage,
    required this.orderSubtitle,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Avatar with subtle border ring
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ManagerColors.primaryColor.withOpacity(0.25),
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: ManagerRadius.r22,
              backgroundImage:
                  customerImage != null && customerImage!.isNotEmpty
                      ? NetworkImage(customerImage!)
                      : null,
              backgroundColor: ManagerColors.greyWhiteColor.withOpacity(0.15),
              child: customerImage == null || customerImage!.isEmpty
                  ? Icon(
                      Icons.person_outline_rounded,
                      color: ManagerColors.greyWhiteColor,
                      size: ManagerRadius.r22,
                    )
                  : null,
            ),
          ),
          SizedBox(width: ManagerWidth.w10),

          /// Name + Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customerName,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h3),
                Text(
                  orderSubtitle,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.greyWhiteColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          SizedBox(width: ManagerWidth.w8),

          /// Order Reference chip (LEFT in RTL)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w10,
              vertical: ManagerHeight.h6,
            ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor.withOpacity(0.07),
              borderRadius: BorderRadius.circular(ManagerRadius.r8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  ManagerStrings.myOffersOrderRef,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
                SizedBox(height: ManagerHeight.h2),
                Text(
                  '#$orderId',
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
