import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/domain/di/di.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/domain/model/customer_review_model.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/presentation/controller/customer_reviews_controller.dart';
import 'package:app_mobile/features/providers/common_features/customer_reviews/widgets/customer_review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerReviewsScreen extends StatefulWidget {
  const CustomerReviewsScreen({super.key});

  @override
  State<CustomerReviewsScreen> createState() => _CustomerReviewsScreenState();
}

class _CustomerReviewsScreenState extends State<CustomerReviewsScreen>
    with SingleTickerProviderStateMixin {
  late final CustomerReviewsController _controller;
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    initCustomerReviews();
    _controller = Get.find<CustomerReviewsController>();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    // Re-run stagger animation whenever reviews list changes
    ever(_controller.reviews, (_) {
      _animController
        ..reset()
        ..forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    disposeCustomerReviews();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => BaseAppScaffold(
          title: ManagerStrings.reviewsScreenTitle,
          subtitle: ManagerStrings.reviewsScreenSubtitle,
          onRefresh: _controller.fetchReviews,
          child: _buildBody(),
        ));
  }

  Widget _buildBody() {
    if (_controller.isLoading.value) {
      return _ShimmerList();
    }

    if (_controller.hasError.value) {
      return _ErrorState(
        message: _controller.errorMessage.value,
        onRetry: _controller.fetchReviews,
      );
    }

    if (_controller.reviews.isEmpty) {
      return _EmptyState();
    }

    return Column(
      children: [
        SizedBox(height: ManagerHeight.h12),
        if (_controller.summary.value != null)
          Padding(
            padding: EdgeInsets.only(bottom: ManagerHeight.h16),
            child: _RatingSummaryCard(summary: _controller.summary.value!),
          ),
        ...List.generate(_controller.reviews.length, (index) {
          final start = (index * 0.12).clamp(0.0, 0.72);
          final end = (start + 0.45).clamp(0.0, 1.0);
          final interval = CurvedAnimation(
            parent: _animController,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          );
          return _AnimatedCardWrapper(
            animation: interval,
            child: Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h12),
              child: CustomerReviewCard(review: _controller.reviews[index]),
            ),
          );
        }),
        SizedBox(height: ManagerHeight.h20),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Rating summary card — shop owner only
// ══════════════════════════════════════════════════════════════════════════════

class _RatingSummaryCard extends StatelessWidget {
  final ReviewSummaryModel summary;

  const _RatingSummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.all(ManagerWidth.w20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ManagerColors.primaryColor,
            ManagerColors.primaryColor.withOpacity(0.75),
          ],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.primaryColor.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: big average score
          Column(
            children: [
              Text(
                summary.averageRating.toStringAsFixed(1),
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s48,
                  color: ManagerColors.white,
                ),
              ),
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < summary.averageRating.floor()
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    size: ManagerFontSize.s16,
                    color: const Color(0xFFFFE066),
                  );
                }),
              ),
              SizedBox(height: ManagerHeight.h4),
              Text(
                '${summary.totalReviews} ${ManagerStrings.reviewsTotalReviews}',
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.white.withOpacity(0.85),
                ),
              ),
            ],
          ),
          SizedBox(width: ManagerWidth.w24),
          // Right: bar breakdown
          Expanded(
            child: Column(
              children: [
                _BarRow(label: '5★', value: summary.fiveStars, total: summary.totalReviews),
                SizedBox(height: ManagerHeight.h6),
                _BarRow(label: '4★', value: summary.fourStars, total: summary.totalReviews),
                SizedBox(height: ManagerHeight.h6),
                _BarRow(label: '3★', value: summary.threeStars, total: summary.totalReviews),
                SizedBox(height: ManagerHeight.h6),
                _BarRow(label: '2★', value: summary.twoStars, total: summary.totalReviews),
                SizedBox(height: ManagerHeight.h6),
                _BarRow(label: '1★', value: summary.oneStar, total: summary.totalReviews),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BarRow extends StatelessWidget {
  final String label;
  final int value;
  final int total;

  const _BarRow({required this.label, required this.value, required this.total});

  @override
  Widget build(BuildContext context) {
    final fraction = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;
    return Row(
      children: [
        SizedBox(
          width: ManagerWidth.w24,
          child: Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.white.withOpacity(0.85),
            ),
          ),
        ),
        SizedBox(width: ManagerWidth.w4),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r4),
            child: LinearProgressIndicator(
              value: fraction,
              backgroundColor: ManagerColors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFE066)),
              minHeight: ManagerHeight.h6,
            ),
          ),
        ),
        SizedBox(width: ManagerWidth.w6),
        SizedBox(
          width: ManagerWidth.w20,
          child: Text(
            '$value',
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.white.withOpacity(0.85),
            ),
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Loading shimmer list
// ══════════════════════════════════════════════════════════════════════════════

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ManagerHeight.h12),
        ...List.generate(
          5,
          (_) => Padding(
            padding: EdgeInsets.only(bottom: ManagerHeight.h12),
            child: const CustomerReviewCardShimmer(),
          ),
        ),
        SizedBox(height: ManagerHeight.h20),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Error state
// ══════════════════════════════════════════════════════════════════════════════

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ManagerWidth.w24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 56,
                color: ManagerColors.primaryColor.withOpacity(0.6),
              ),
              SizedBox(height: ManagerHeight.h12),
              Text(
                message,
                textAlign: TextAlign.center,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h20),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ManagerColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  ),
                ),
                child: Text(
                  ManagerStrings.retry,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Empty state
// ══════════════════════════════════════════════════════════════════════════════

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(ManagerWidth.w24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.rate_review_outlined,
                size: 64,
                color: ManagerColors.primaryColor.withOpacity(0.5),
              ),
              SizedBox(height: ManagerHeight.h16),
              Text(
                ManagerStrings.reviewsNoReviews,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.black,
                ),
              ),
              SizedBox(height: ManagerHeight.h8),
              Text(
                ManagerStrings.reviewsEmptySubtitle,
                textAlign: TextAlign.center,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s13,
                  color: ManagerColors.greyWhiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Animated card wrapper — fade + slide up
// ══════════════════════════════════════════════════════════════════════════════

class _AnimatedCardWrapper extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedCardWrapper({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.18),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }
}
