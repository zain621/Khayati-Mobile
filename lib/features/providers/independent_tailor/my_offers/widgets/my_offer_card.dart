import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/domain/model/my_offer_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/offer_action_buttons.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/offer_customer_row.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/offer_info_grid.dart';
import 'package:app_mobile/features/providers/independent_tailor/my_offers/widgets/offer_status_header.dart';
import 'package:flutter/material.dart';

/// A card widget displaying a single submitted offer.
/// Composes separated sub-widgets: header, customer row, info grid, actions.
class MyOfferCard extends StatelessWidget {
  final MyOfferModel offer;
  final VoidCallback? onTrackOrders;
  final VoidCallback? onEditOffer;
  final VoidCallback? onWithdrawOffer;
  final VoidCallback? onDelete;

  const MyOfferCard({
    super.key,
    required this.offer,
    this.onTrackOrders,
    this.onEditOffer,
    this.onWithdrawOffer,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h6,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 14,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Status header
            OfferStatusHeader(
              status: offer.myOffer.status,
              timeAgo: offer.myOffer.createdAt.split('T').first,
            ),

            /// Customer info row
            OfferCustomerRow(
              customerName: offer.requesterName,
              customerImage: offer.requesterImage,
              orderSubtitle: offer.requesterDescription ?? offer.orderNumber,
              orderId: offer.orderNumber,
            ),

            /// Stats grid
            OfferInfoGrid(
              formattedPrice: offer.myOffer.formattedPrice,
              executionDays: offer.myOffer.executionDays,
              competingOffers: offer.competitorsCount,
              budgetRange: offer.clientBudget.budgetRange,
            ),

            SizedBox(height: ManagerHeight.h12),

            /// Action buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              child: OfferActionButtons(
                status: offer.myOffer.status,
                onTrackOrders: onTrackOrders,
                onEditOffer: onEditOffer,
                onWithdrawOffer: onWithdrawOffer,
                onDelete: onDelete,
              ),
            ),

            SizedBox(height: ManagerHeight.h14),
          ],
        ),
      ),
    );
  }}

