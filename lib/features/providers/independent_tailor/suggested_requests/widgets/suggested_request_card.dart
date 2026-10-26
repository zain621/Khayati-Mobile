import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/domain/model/suggested_order_model.dart';
import 'package:flutter/material.dart';

/// A card widget displaying a single suggested tailoring order.
class SuggestedRequestCard extends StatelessWidget {
  final SuggestedOrderModel request;
  final VoidCallback onSubmitOffer;

  const SuggestedRequestCard({
    super.key,
    required this.request,
    required this.onSubmitOffer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h8,
      ),
      padding: EdgeInsets.all(ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Customer Info Row
          _buildCustomerHeader(),

          SizedBox(height: ManagerHeight.h12),

          /// Description
          Text(
            request.description,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.black.withOpacity(0.7),
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: ManagerHeight.h12),

          /// Reference Images
          if (request.similarImages.isNotEmpty) ...[
            _buildReferenceImages(),
            SizedBox(height: ManagerHeight.h14),
          ],

          /// Budget & Duration Row
          _buildInfoRow(),

          SizedBox(height: ManagerHeight.h14),

          /// Submit Offer Button
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Widget _buildCustomerHeader() {
    return Row(
      children: [
        /// Profile Image
        CircleAvatar(
          radius: ManagerRadius.r24,
          backgroundColor: ManagerColors.greyWhiteColor.withOpacity(0.2),
          backgroundImage: request.userImage != null
              ? NetworkImage(request.userImage!)
              : null,
          child: request.userImage == null
              ? Icon(
                  Icons.person,
                  color: ManagerColors.greyWhiteColor,
                  size: ManagerFontSize.s22,
                )
              : null,
        ),

        SizedBox(width: ManagerWidth.w12),

        /// Name + Order Number
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                request.userName,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: ManagerColors.primaryColor,
                ),
              ),
              SizedBox(height: ManagerHeight.h2),
              Text(
                request.orderNumber,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
          /// Offers Count Badge
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_offer_outlined,
                size: ManagerFontSize.s12,
                color: ManagerColors.primaryColor,
              ),
              SizedBox(width: ManagerWidth.w4),
              Text(
                '${request.offersCount} ${ManagerStrings.suggestedRequestsOffers}',
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: ManagerHeight.h4),
          Text(
            request.productName,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s12,
              color: ManagerColors.greyWhiteColor,
            ),
          ),

          
        ]),
      ],
    );
  }

  Widget _buildReferenceImages() {
    return SizedBox(
      height: ManagerHeight.h100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: request.similarImages.length,
        separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w8),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            child: Image.network(
              request.similarImages[index],
              width: ManagerWidth.w96,
              height: ManagerHeight.h128,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: ManagerWidth.w96,
                height: ManagerHeight.h128,
                color: ManagerColors.greyWhiteColor.withOpacity(0.1),
                child: Icon(
                  Icons.image_not_supported_outlined,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow() {
    return Row(
      children: [
        /// Budget
        _buildInfoChip(
          icon: Icons.account_balance_wallet_outlined,
          label:
              '${ManagerStrings.suggestedRequestsBudget} ${request.budgetRange} ${ManagerStrings.suggestedRequestsCurrency}',
        ),

        SizedBox(width: ManagerWidth.w12),

        /// Delivery Date
        _buildInfoChip(
          icon: Icons.calendar_today_outlined,
          label: request.deliveryDate,
        ),
      ],
    );
  }

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: ManagerFontSize.s14,
          color: ManagerColors.primaryColor,
        ),
        SizedBox(width: ManagerWidth.w4),
        Text(
          label,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s11,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: ManagerHeight.h42,
      child: ElevatedButton.icon(
        onPressed: onSubmitOffer,
        icon: Icon(
          Icons.send_rounded,
          size: ManagerFontSize.s16,
          color: ManagerColors.white,
        ),
        label: Text(
          ManagerStrings.suggestedRequestsSubmitOffer,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ManagerColors.primaryColor,
          foregroundColor: ManagerColors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ManagerRadius.r10),
          ),
        ),
      ),
    );
  }
}
