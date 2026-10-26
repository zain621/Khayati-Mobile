// ignore_for_file: avoid_unused_constructor_parameters
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/domain/model/customer_review_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Card widget displaying a single customer review with real API data.
class CustomerReviewCard extends StatefulWidget {
  final CustomerReviewModel review;

  const CustomerReviewCard({super.key, required this.review});

  @override
  State<CustomerReviewCard> createState() => _CustomerReviewCardState();
}

class _CustomerReviewCardState extends State<CustomerReviewCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 180),
      lowerBound: 0.97,
      upperBound: 1.0,
      value: 1.0,
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleController.reverse(),
      onTapUp: (_) => _scaleController.forward(),
      onTapCancel: () => _scaleController.forward(),
      child: ScaleTransition(
        scale: _scaleController,
        child: _CardContent(review: widget.review),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Card content
// ══════════════════════════════════════════════════════════════════════════════

class _CardContent extends StatelessWidget {
  final CustomerReviewModel review;

  const _CardContent({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.07),
            blurRadius: 18,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: avatar / name / stars / date / type badge ─────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _ReviewerAvatar(imageUrl: review.reviewerImage),
                SizedBox(width: ManagerWidth.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              review.reviewerName,
                              style: getBoldTextStyle(
                                fontSize: ManagerFontSize.s14,
                                color: ManagerColors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (review.type != null) _TypeBadge(type: review.type!),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h4),
                      _StarRating(rating: review.rating),
                    ],
                  ),
                ),
                SizedBox(width: ManagerWidth.w8),
                Text(
                  _formatDate(review.createdAt),
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.greyWhiteColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: ManagerHeight.h12),

            // ── Comment ────────────────────────────────────────────────────
            Text(
              review.comment,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.black,
              ),
            ),

            // ── Review image (optional) ────────────────────────────────────
            if (review.imageUrl != null && review.imageUrl!.isNotEmpty) ...[
              SizedBox(height: ManagerHeight.h12),
              ClipRRect(
                borderRadius: BorderRadius.circular(ManagerRadius.r12),
                child: CachedNetworkImage(
                  imageUrl: review.imageUrl!,
                  height: ManagerHeight.h150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Shimmer.fromColors(
                    baseColor: const Color(0xFFE0E0E0),
                    highlightColor: ManagerColors.white,
                    child: Container(
                      height: ManagerHeight.h150,
                      color: const Color(0xFFE0E0E0),
                    ),
                  ),
                  errorWidget: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ],

            // ── Products (comprehensive shop-type only) ────────────────────
            if (review.products.isNotEmpty) ...[
              SizedBox(height: ManagerHeight.h12),
              Row(
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: ManagerFontSize.s14,
                    color: ManagerColors.primaryColor,
                  ),
                  SizedBox(width: ManagerWidth.w4),
                  Text(
                    ManagerStrings.reviewsProducts,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: ManagerHeight.h6),
              Wrap(
                spacing: ManagerWidth.w6,
                runSpacing: ManagerHeight.h4,
                children: review.products
                    .map((p) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w8,
                            vertical: ManagerHeight.h4,
                          ),
                          decoration: BoxDecoration(
                            color: ManagerColors.primaryColor.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(ManagerRadius.r6),
                          ),
                          child: Text(
                            '${p.productName} ×${p.quantity}',
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],

            SizedBox(height: ManagerHeight.h12),

            // ── Order number chip ──────────────────────────────────────────
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w10,
                vertical: ManagerHeight.h5,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ManagerRadius.r8),
                color: ManagerColors.primaryColor.withOpacity(0.08),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: ManagerFontSize.s13,
                    color: ManagerColors.primaryColor,
                  ),
                  SizedBox(width: ManagerWidth.w4),
                  Text(
                    review.orderNumber,
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
      ),
    );
  }

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Reviewer Avatar
// ══════════════════════════════════════════════════════════════════════════════

class _ReviewerAvatar extends StatelessWidget {
  final String? imageUrl;

  const _ReviewerAvatar({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CircleAvatar(
        radius: ManagerRadius.r22,
        backgroundColor: ManagerColors.primaryColor.withOpacity(0.15),
        child: Icon(
          Icons.person_outline,
          color: ManagerColors.primaryColor,
          size: ManagerFontSize.s22,
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      imageBuilder: (_, imageProvider) => CircleAvatar(
        radius: ManagerRadius.r22,
        backgroundImage: imageProvider,
      ),
      placeholder: (_, __) => Shimmer.fromColors(
        baseColor: const Color(0xFFE0E0E0),
        highlightColor: ManagerColors.white,
        child: CircleAvatar(
          radius: ManagerRadius.r22,
          backgroundColor: const Color(0xFFE0E0E0),
        ),
      ),
      errorWidget: (_, __, ___) => CircleAvatar(
        radius: ManagerRadius.r22,
        backgroundColor: ManagerColors.primaryColor.withOpacity(0.15),
        child: Icon(
          Icons.person_outline,
          color: ManagerColors.primaryColor,
          size: ManagerFontSize.s22,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Type Badge — comprehensive tailor only (shop / zoqak)
// ══════════════════════════════════════════════════════════════════════════════

class _TypeBadge extends StatelessWidget {
  final String type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    final isShop = type == 'shop';
    final label = isShop
        ? ManagerStrings.reviewsTypeBadgeShop
        : ManagerStrings.reviewsTypeBadgeZoqak;
    final color =
        isShop ? ManagerColors.secondaryColor : ManagerColors.primaryColor;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w8,
        vertical: ManagerHeight.h3,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s10,
          color: color,
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Star Rating
// ══════════════════════════════════════════════════════════════════════════════

class _StarRating extends StatelessWidget {
  final int rating;
  final int maxStars = 5;

  const _StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(maxStars, (index) {
        return Padding(
          padding: EdgeInsets.only(right: ManagerWidth.w1),
          child: Icon(
            index < rating ? Icons.star_rounded : Icons.star_outline_rounded,
            size: ManagerFontSize.s16,
            color: const Color(0xFFFFB800),
          ),
        );
      }),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Shimmer placeholder card — shown during loading
// ══════════════════════════════════════════════════════════════════════════════

class CustomerReviewCardShimmer extends StatelessWidget {
  const CustomerReviewCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: ManagerColors.white,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h6,
        ),
        padding: EdgeInsets.all(ManagerWidth.w16),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: ManagerRadius.r22,
                  backgroundColor: const Color(0xFFE0E0E0),
                ),
                SizedBox(width: ManagerWidth.w12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _box(ManagerWidth.w120, ManagerHeight.h14),
                    SizedBox(height: ManagerHeight.h6),
                    _box(ManagerWidth.w80, ManagerHeight.h10),
                    ],
                  ),
                ),
                _box(ManagerWidth.w60, ManagerHeight.h10),
              ],
            ),
            SizedBox(height: ManagerHeight.h12),
            _box(double.infinity, ManagerHeight.h12),
            SizedBox(height: ManagerHeight.h6),
            _box(ManagerWidth.w200, ManagerHeight.h12),
            SizedBox(height: ManagerHeight.h12),
            _box(ManagerWidth.w100, ManagerHeight.h28),
          ],
        ),
      ),
    );
  }

  Widget _box(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
        borderRadius: BorderRadius.circular(ManagerRadius.r6),
      ),
    );
  }
}
