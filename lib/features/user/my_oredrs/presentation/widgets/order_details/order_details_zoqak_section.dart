import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/user_order_domain_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_colors.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_section_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsZoqakSection
//
// Details tab content for zoqak (على ذوقك) orders.
// Shows:
//   1. Request details card  (name, fabric, budget, delivery date, description)
//   2. Similar images gallery (if any)
//   3. Tailor / provider info card (if accepted)
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsZoqakSection extends StatelessWidget {
  final UserOrderDomainModel order;
  final VoidCallback? onChat;
  final bool isChatLoading;

  const OrderDetailsZoqakSection({
    super.key,
    required this.order,
    this.onChat,
    this.isChatLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final images = order.similarImages ?? [];
    final hasProvider = order.acceptedByProviderName != null &&
        order.acceptedByProviderName!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Request details card ──────────────────────────────────────
        _ZoqakDetailsCard(order: order),

        // ── Similar images ────────────────────────────────────────────
        if (images.isNotEmpty) ...[
          SizedBox(height: ManagerHeight.h16),
          _SimilarImagesCard(images: images),
        ],

        // ── Provider / tailor card ────────────────────────────────────
        if (hasProvider) ...[
          SizedBox(height: ManagerHeight.h16),
          _ProviderCard(
            name: order.acceptedByProviderName!,
            onChat: onChat,
            isChatLoading: isChatLoading,
          ),
        ],

        SizedBox(height: ManagerHeight.h24),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ZoqakDetailsCard
// ─────────────────────────────────────────────────────────────────────────────

class _ZoqakDetailsCard extends StatelessWidget {
  final UserOrderDomainModel order;
  const _ZoqakDetailsCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final minB = order.minBudget;
    final maxB = order.maxBudget;
    final budgetText = (minB != null && maxB != null)
        ? '${minB.toStringAsFixed(0)} - ${maxB.toStringAsFixed(0)} ${ManagerStrings.orderDetailsCurrency}'
        : null;

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsSectionHeader(
            icon: Icons.design_services_rounded,
            title: ManagerStrings.orderDetailsZoqakRequestTitle,
          ),
          SizedBox(height: ManagerHeight.h16),

          // Product name
          _InfoRow(
            icon: Icons.label_outline_rounded,
            label: ManagerStrings.orderDetailsZoqakProductNameLabel,
            value: order.productName ?? '—',
          ),
          SizedBox(height: ManagerHeight.h10),

          // Fabric type
          if (order.fabricType != null && order.fabricType!.isNotEmpty) ...[
            _InfoRow(
              icon: Icons.texture_rounded,
              label: ManagerStrings.orderDetailsFabricLabel,
              value: order.fabricType!,
            ),
            SizedBox(height: ManagerHeight.h10),
          ],

          // Budget
          if (budgetText != null) ...[
            _InfoRow(
              icon: Icons.account_balance_wallet_outlined,
              label: ManagerStrings.orderDetailsZoqakBudgetLabel,
              value: budgetText,
            ),
            SizedBox(height: ManagerHeight.h10),
          ],

          // Delivery date
          if (order.deliveryDate != null &&
              order.deliveryDate!.isNotEmpty) ...[
            _InfoRow(
              icon: Icons.event_available_rounded,
              label: ManagerStrings.orderDetailsDeliveryDate,
              value: order.deliveryDate!,
            ),
            SizedBox(height: ManagerHeight.h10),
          ],

          // Description
          if (order.description != null &&
              order.description!.isNotEmpty) ...[
            Divider(
              height: ManagerHeight.h20,
              thickness: 0.8,
              color: ManagerColors.greyWhiteColor.withOpacity(0.2),
            ),
            OrderDetailsSectionHeader(
              icon: Icons.notes_rounded,
              title: ManagerStrings.orderDetailsDescriptionLabel,
            ),
            SizedBox(height: ManagerHeight.h8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(ManagerWidth.w12),
              decoration: BoxDecoration(
                color: kOdStatusSectionBg,
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              child: Text(
                order.description!,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.black.withOpacity(0.75),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _SimilarImagesCard
// ─────────────────────────────────────────────────────────────────────────────

class _SimilarImagesCard extends StatelessWidget {
  final List<String> images;
  const _SimilarImagesCard({required this.images});

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsSectionHeader(
            icon: Icons.photo_library_outlined,
            title: ManagerStrings.orderDetailsZoqakImagesTitle,
          ),
          SizedBox(height: ManagerHeight.h12),
          SizedBox(
            height: ManagerHeight.h100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w8),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () => _showImageViewer(context, images, i),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ManagerRadius.r10),
                    child: CachedNetworkImage(
                      imageUrl: images[i],
                      width: ManagerWidth.w100,
                      height: ManagerHeight.h100,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        color: kOdStatusSectionBg,
                        child: Icon(
                          Icons.image_outlined,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        color: kOdStatusSectionBg,
                        child: Icon(
                          Icons.broken_image_outlined,
                          color: ManagerColors.greyWhiteColor,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showImageViewer(
      BuildContext context, List<String> images, int initialIndex) {
    showDialog(
      context: context,
      builder: (_) => _ImageViewerDialog(
        images: images,
        initialIndex: initialIndex,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ProviderCard — assigned tailor / provider info
// ─────────────────────────────────────────────────────────────────────────────

class _ProviderCard extends StatelessWidget {
  final String name;
  final VoidCallback? onChat;
  final bool isChatLoading;

  const _ProviderCard({
    required this.name,
    this.onChat,
    this.isChatLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsSectionHeader(
            icon: Icons.content_cut_rounded,
            title: ManagerStrings.orderDetailsTailorSection,
          ),
          SizedBox(height: ManagerHeight.h12),
          Row(
            children: [
              Container(
                width: ManagerWidth.w48,
                height: ManagerWidth.w48,
                decoration: BoxDecoration(
                  color: kOdStatusSectionBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_rounded,
                  color: ManagerColors.primaryColor,
                  size: ManagerFontSize.s24,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s15,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      ManagerStrings.orderDetailsZoqakProviderLabel,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (onChat != null)
                IconButton(
                  onPressed: isChatLoading ? null : onChat,
                  tooltip: ManagerStrings.orderDetailsChat,
                  icon: isChatLoading
                      ? SizedBox(
                          width: ManagerWidth.w20,
                          height: ManagerWidth.w20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: ManagerColors.primaryColor,
                          ),
                        )
                      : Icon(
                          Icons.chat_bubble_outline_rounded,
                          color: ManagerColors.primaryColor,
                        ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ImageViewerDialog — full-screen image gallery
// ─────────────────────────────────────────────────────────────────────────────

class _ImageViewerDialog extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const _ImageViewerDialog({
    required this.images,
    required this.initialIndex,
  });

  @override
  State<_ImageViewerDialog> createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<_ImageViewerDialog> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: widget.images.length,
            controller: PageController(initialPage: _current),
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => InteractiveViewer(
              child: CachedNetworkImage(
                imageUrl: widget.images[i],
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Close button
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),
          // Page indicator
          if (widget.images.length > 1)
            Positioned(
              bottom: ManagerHeight.h20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w3),
                    width: _current == i ? ManagerWidth.w16 : ManagerWidth.w6,
                    height: ManagerHeight.h6,
                    decoration: BoxDecoration(
                      color: _current == i
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Shared private widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(ManagerWidth.w16),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon,
            size: ManagerFontSize.s14, color: ManagerColors.primaryColor),
        SizedBox(width: ManagerWidth.w8),
        Text(
          '$label: ',
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
