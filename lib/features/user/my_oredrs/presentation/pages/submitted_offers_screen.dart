import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/widgets/loading_widget.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/controller/my_orders_controller.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/tailor_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Animation constants
// ─────────────────────────────────────────────────────────────────────────────
const Duration _kEntranceDuration = Duration(milliseconds: 900);
const double _kCardSlideBegin = 0.10; // fraction of screen height

class SubmittedOffersScreen extends StatefulWidget {
  final String orderId;

  const SubmittedOffersScreen({super.key, required this.orderId});

  @override
  State<SubmittedOffersScreen> createState() => _SubmittedOffersScreenState();
}

class _SubmittedOffersScreenState extends State<SubmittedOffersScreen>
    with SingleTickerProviderStateMixin {
  late final MyOrdersController _ctrl;

  // ── Animation ──────────────────────────────────────────────────────────────
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<MyOrdersController>();
    _controller = AnimationController(
      vsync: this,
      duration: _kEntranceDuration,
    )..forward();
    // Fetch offers for this order
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _ctrl.fetchZoqakOffers(widget.orderId);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Builds a staggered [CurvedAnimation] for the card at [index].
  Animation<double> _staggeredAnim(int index, int total) {
    final start = (total <= 1) ? 0.0 : (index / (total - 1)) * 0.55;
    final end = (start + 0.45).clamp(0.0, 1.0);
    return CurvedAnimation(
      parent: _controller,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseAppScaffold(
      title: ManagerStrings.submittedOffersTitle,
      subtitle: ManagerStrings.submittedOffersSubtitle,
      onBackPressed: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
        child: Obx(() {
          final isAccepting = _ctrl.isAccepting.value;

          if (_ctrl.isOffersLoading.value) {
            return _buildShimmer(context);
          }

          final offers = _ctrl.currentOffers;

          final content = RefreshIndicator(
            onRefresh: () => _ctrl.fetchZoqakOffers(widget.orderId),
            color: ManagerColors.primaryColor,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(height: ManagerHeight.h8),

                  // ── Offer cards ────────────────────────────────────────────
                  if (offers.isEmpty)
                    _buildEmptyState()
                  else
                    ...List.generate(offers.length, (i) {
                      return _AnimatedCard(
                        animation: _staggeredAnim(i, offers.length),
                        child: Column(
                          children: [
                            TailorOfferCard(
                              offer: offers[i],
                              onViewProfile: offers[i].tailorId.isNotEmpty
                                  ? () => Get.toNamed(
                                        Routes.tailorDetailsScreen,
                                        arguments: offers[i].tailorId,
                                      )
                                  : null,
                              onAccept: () {
                                _ctrl.acceptOffer(offers[i].offerId);
                              },
                            ),
                            if (i < offers.length - 1)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ManagerWidth.w16,
                                  vertical: ManagerHeight.h4,
                                ),
                                child: const Divider(
                                  height: 1,
                                  thickness: 0.6,
                                  color: Color(0xFFEEEEEE),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),

                  SizedBox(height: ManagerHeight.h20),
                ],
              ),
            ),
          );

          if (!isAccepting) return content;

          // Premium accept overlay: dims content + centered animated loader
          return Stack(
            children: [
              // Disable interaction with underlying content
              AbsorbPointer(child: content),

              // Dim layer
              AnimatedOpacity(
                opacity: isAccepting ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 250),
                child: Container(
                  color: Colors.black.withOpacity(0.35),
                ),
              ),

              // Centered loading card
              const LoadingWidget(),
            ],
          );
        }),
      ),
    );
  }

  // ── Shimmer ───────────────────────────────────────────────────────────────

  Widget _buildShimmer(BuildContext context) {
    // MediaQuery gives a concrete finite height so Shimmer's ClipRect can lay out.
    // SizedBox.expand / ListView both fail here because the parent has unbounded height.
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: height,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFFE0E0E0),
        highlightColor: const Color(0xFFF5F5F5),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w16,
            vertical: ManagerHeight.h12,
          ),
          child: Column(
            children: [
              _buildShimmerCard(),
              SizedBox(height: ManagerHeight.h12),
              _buildShimmerCard(),
              SizedBox(height: ManagerHeight.h12),
              _buildShimmerCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerCard() {
    // All containers use Colors.white — Shimmer animates its gradient over them.
    final b = (double w, double h, {double r = 8.0}) => Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(r),
          ),
        );

    // Mirrors real _InfoBox: padding h12/w12, label → h4 → large value → unit
    Widget infoBox() => Container(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w12,
            vertical: ManagerHeight.h12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              b(44, 11, r: 5),             // label  (s11)
              SizedBox(height: ManagerHeight.h4),
              b(38, 26, r: 6),             // value  (s24 bold — big number)
              b(26, 11, r: 5),             // unit   (s11, no gap from value)
            ],
          ),
        );

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Body ─────────────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w14,
              ManagerHeight.h14,
              ManagerWidth.w14,
              ManagerHeight.h12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header row ───────────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar — circle with border ring
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w10),

                    // Name + availability / badge + rating
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row: name text  +  availability dot + text
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: b(double.infinity, 14, r: 7)),
                              SizedBox(width: ManagerWidth.w6),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w3),
                              b(38, 10, r: 5),   // availability text
                            ],
                          ),

                          SizedBox(height: ManagerHeight.h4),

                          // Row: badge pill + star icon + rating + review count
                          Row(
                            children: [
                              b(70, 22, r: 11),  // verified badge pill
                              SizedBox(width: ManagerWidth.w8),
                              b(13, 13, r: 3),   // star icon
                              SizedBox(width: ManagerWidth.w2),
                              b(24, 12, r: 5),   // "4.9"
                              SizedBox(width: ManagerWidth.w3),
                              b(52, 11, r: 5),   // "(342 طلب)"
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Replied-ago time (top-right)
                    b(52, 10, r: 5),
                  ],
                ),

                SizedBox(height: ManagerHeight.h14),

                // ── Duration + Price info boxes ──────────────────────────────
                Row(
                  children: [
                    Expanded(child: infoBox()),
                    SizedBox(width: ManagerWidth.w10),
                    Expanded(child: infoBox()),
                  ],
                ),

                SizedBox(height: ManagerHeight.h14),

                // ── Description lines ────────────────────────────────────────
                b(double.infinity, 12, r: 6),
                SizedBox(height: ManagerHeight.h7),
                b(double.infinity, 12, r: 6),
                SizedBox(height: ManagerHeight.h7),
                b(160, 12, r: 6),

                SizedBox(height: ManagerHeight.h12),

                // ── Fabric samples ───────────────────────────────────────────
                b(62, 11, r: 5),              // section label "عينات القماش"
                SizedBox(height: ManagerHeight.h8),
                Row(
                  children: List.generate(
                    4,
                    (i) => Padding(
                      padding: EdgeInsetsDirectional.only(end: ManagerWidth.w8),
                      child: b(60, 68, r: ManagerRadius.r8),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Divider ───────────────────────────────────────────────────────
          Container(height: 1, color: const Color(0xFFEEEEEE)),

          // ── Action buttons ────────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(
              ManagerWidth.w14,
              ManagerHeight.h12,
              ManagerWidth.w14,
              ManagerHeight.h14,
            ),
            child: Row(
              children: [
                // Outline button — عرض الملف
                Expanded(
                  child: Container(
                    height: ManagerHeight.h40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        b(15, 15, r: 4),
                        SizedBox(width: ManagerWidth.w6),
                        b(56, 12, r: 6),
                      ],
                    ),
                  ),
                ),

                SizedBox(width: ManagerWidth.w10),

                // Primary button — قبول العرض
                Expanded(
                  child: Container(
                    height: ManagerHeight.h40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        b(15, 15, r: 4),
                        SizedBox(width: ManagerWidth.w6),
                        b(56, 12, r: 6),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Summary banner ───────────────────────────────────────────────────────

  // ignore: unused_element
  Widget _buildBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w16,
        vertical: ManagerHeight.h14,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(ManagerRadius.r14),
        // border: Border.all(
        //   color: ManagerColors.primaryColor.withOpacity(0.12),
        // ),
      ),
      child: Row(
        children: [
          // Count pill (start in RTL)
          Container(
            height: ManagerHeight.h48,
            width: ManagerWidth.w48,
            // padding: EdgeInsets.symmetric(
            //   horizontal: ManagerWidth.w14,
            //   vertical: ManagerHeight.h8,
            // ),
            decoration: BoxDecoration(
              color: ManagerColors.primaryColor,
              borderRadius: BorderRadius.circular(ManagerRadius.r24),
            ),
            child: CustomSvgImage(path: ManagerIcons.giftIcon, color: Colors.white),
          ),

          SizedBox(width: ManagerWidth.w12),

          // Hint text
          Expanded(
            child: Text(
              ManagerStrings.submittedOffersBannerHint,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s12,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Empty state ───────────────────────────────────────────────────────────

  Widget _buildEmptyState() {
    return FadeTransition(
      opacity: _controller,
      child: Padding(
        padding: EdgeInsets.only(top: ManagerHeight.h60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inbox_outlined,
                size: 56,
                color: ManagerColors.greyWhiteColor.withOpacity(0.4)),
            SizedBox(height: ManagerHeight.h12),
            Text(
              ManagerStrings.submittedOffersEmpty,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s15,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _AnimatedCard — fade + slide-up wrapper for a single list item
// ─────────────────────────────────────────────────────────────────────────────

class _AnimatedCard extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const _AnimatedCard({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    final slide = Tween<Offset>(
      begin: const Offset(0, _kCardSlideBegin),
      end: Offset.zero,
    ).animate(animation);

    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: slide,
        child: child,
      ),
    );
  }
}
