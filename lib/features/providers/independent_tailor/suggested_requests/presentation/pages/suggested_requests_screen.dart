import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/domain/di/di.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/domain/model/suggested_order_model.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/presentation/controller/suggested_requests_controller.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/widgets/submit_offer_bottom_sheet.dart';
import 'package:app_mobile/features/providers/independent_tailor/suggested_requests/widgets/suggested_request_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Suggested Requests Screen  —  with staggered card animations
// ─────────────────────────────────────────────────────────────────────────────

class SuggestedRequestsScreen extends StatefulWidget {
  const SuggestedRequestsScreen({super.key});

  @override
  State<SuggestedRequestsScreen> createState() =>
      _SuggestedRequestsScreenState();
}

class _SuggestedRequestsScreenState extends State<SuggestedRequestsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  late List<Animation<Offset>> _slideAnimations;

  late final SuggestedRequestsController _suggestedController;

  // Stores the GetX worker so it can be cancelled on dispose.
  Worker? _ordersWorker;

  // Each card occupies a 0.45-wide window, shifted 0.15 per card.
  static const double _windowSize = 0.45;
  static const double _stagger = 0.15;

  @override
  void initState() {
    super.initState();
    initSuggestedRequests();
    _suggestedController = Get.find<SuggestedRequestsController>();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    // Listen for orders to rebuild animations when data first loads.
    // Store the worker so we can dispose it properly.
    _ordersWorker = ever(_suggestedController.orders, (_) {
      if (mounted) {
        _buildAnimations(_suggestedController.orders.length);
        _controller
          ..reset()
          ..forward();
      }
    });

    _buildAnimations(0);
  }

  void _buildAnimations(int count) {
    _fadeAnimations = List.generate(count, (i) {
      final start = (i * _stagger).clamp(0.0, 1.0);
      final end = (start + _windowSize).clamp(0.0, 1.0);
      return CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    _slideAnimations = List.generate(count, (i) {
      final start = (i * _stagger).clamp(0.0, 1.0);
      final end = (start + _windowSize).clamp(0.0, 1.0);
      return Tween<Offset>(
        begin: const Offset(0, 0.18),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOutCubic),
        ),
      );
    });
  }

  @override
  void dispose() {
    _ordersWorker?.dispose();
    _controller.dispose();
    disposeSuggestedRequests();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Capture screen height OUTSIDE Obx so MediaQuery is never accessed from
    // inside a reactive closure (avoids double-layout when keyboard changes
    // viewInsets while a reactive update is also scheduled).
    final stateHeight = MediaQuery.sizeOf(context).height * 0.55;

    // BaseAppScaffold is the ONLY Scaffold — never inside a Stack.
    // All loading / error / empty / list states live inside its child.
    return BaseAppScaffold(
      title: ManagerStrings.suggestedRequestsTitle,
      subtitle: ManagerStrings.suggestedRequestsSubtitle,
      onRefresh: _suggestedController.fetchOrders,
      child: Obx(() {
        final isLoading = _suggestedController.isLoading.value;
        final hasError = _suggestedController.hasError.value;
        final orders = _suggestedController.orders;

        if (isLoading) return _buildShimmerState(stateHeight);
        if (hasError) return _buildErrorState(stateHeight);
        if (orders.isEmpty) return _buildEmptyState(stateHeight);
        return _buildList(context, orders);
      }),
    );
  }

  // ── Loading (Shimmer) ─────────────────────────────────────────────────────

  Widget _buildShimmerState(double stateHeight) {
    return SizedBox(
      height: stateHeight,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFE6E6E6),
        highlightColor: Colors.white,
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            top: ManagerHeight.h8,
            bottom: ManagerHeight.h20,
          ),
          itemCount: 4,
          separatorBuilder: (_, __) => Divider(
            height: ManagerHeight.h1,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),
          itemBuilder: (_, __) => _buildShimmerCard(),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      child: Container(
        padding: EdgeInsets.all(ManagerWidth.w12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: ManagerWidth.w46,
                  height: ManagerHeight.h46,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: ManagerWidth.w10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _shimmerBox(120, 12),
                      SizedBox(height: ManagerHeight.h6),
                      _shimmerBox(90, 10),
                    ],
                  ),
                ),
                SizedBox(width: ManagerWidth.w10),
                _shimmerBox(72, 22, radius: 16),
              ],
            ),
            SizedBox(height: ManagerHeight.h12),
            _shimmerBox(double.infinity, 10),
            SizedBox(height: ManagerHeight.h8),
            _shimmerBox(double.infinity, 10),
            SizedBox(height: ManagerHeight.h12),
            Row(
              children: [
                Expanded(child: _shimmerBox(double.infinity, 38, radius: 10)),
                SizedBox(width: ManagerWidth.w10),
                Expanded(child: _shimmerBox(double.infinity, 38, radius: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox(double width, double height, {double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  // ── Error ──────────────────────────────────────────────────────────────────

  Widget _buildErrorState(double stateHeight) {
    final message = _suggestedController.errorMessage.value;
    return SizedBox(
      height: stateHeight,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_rounded,
                size: 64,
                color: ManagerColors.greyWhiteColor.withOpacity(0.5),
              ),
              SizedBox(height: ManagerHeight.h16),
              Text(
                message.isNotEmpty
                    ? message
                    : ManagerStrings.genericError,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
                textDirection: Directionality.of(context),
              ),
              SizedBox(height: ManagerHeight.h20),
              ElevatedButton.icon(
                onPressed: _suggestedController.fetchOrders,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(ManagerStrings.retry),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ManagerColors.primaryColor,
                  foregroundColor: ManagerColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Empty ──────────────────────────────────────────────────────────────────

  Widget _buildEmptyState(double stateHeight) {
    return SizedBox(
      height: stateHeight,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.inbox_rounded,
                size: 64,
                color: ManagerColors.greyWhiteColor.withOpacity(0.4),
              ),
              SizedBox(height: ManagerHeight.h16),
              Text(
                ManagerStrings.suggestedRequestsEmpty,
                style: getMediumTextStyle(
                  fontSize: ManagerFontSize.s14,
                  color: ManagerColors.greyWhiteColor,
                ),
                textAlign: TextAlign.center,
                textDirection: Directionality.of(context),
              ),
              SizedBox(height: ManagerHeight.h8),
              Text(
                ManagerStrings.pullToRefresh,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
                textDirection: Directionality.of(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── List ───────────────────────────────────────────────────────────────────

  Widget _buildList(BuildContext context, List<SuggestedOrderModel> orders) {
    return Column(
      children: [
        SizedBox(height: ManagerHeight.h8),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(bottom: ManagerHeight.h20),
          itemCount: orders.length,
          separatorBuilder: (_, __) => Divider(
            height: ManagerHeight.h1,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),
          itemBuilder: (context, index) {
            final SuggestedOrderModel order = orders[index];
            if (index >= _fadeAnimations.length) {
              return SuggestedRequestCard(
                request: order,
                onSubmitOffer: () =>
                    SubmitOfferBottomSheet.show(context, order),
              );
            }
            return FadeTransition(
              opacity: _fadeAnimations[index],
              child: SlideTransition(
                position: _slideAnimations[index],
                child: SuggestedRequestCard(
                  request: order,
                  onSubmitOffer: () =>
                      SubmitOfferBottomSheet.show(context, order),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
