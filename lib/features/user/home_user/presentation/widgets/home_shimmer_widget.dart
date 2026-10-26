import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ─── Shared shimmer palette ───────────────────────────────────────────────────
const Color _kBase = Color(0xFFE8E8E8);
const Color _kHighlight = Color(0xFFF5F5F5);

// ═════════════════════════════════════════════════════════════════════════════
// Map Card Shimmer  —  header strip + map body
// ═════════════════════════════════════════════════════════════════════════════

/// Drop-in shimmer replacement for [HomeMapCardWidget] while the map loads.
class HomeMapShimmer extends StatelessWidget {
  const HomeMapShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: Shimmer.fromColors(
        baseColor: _kBase,
        highlightColor: _kHighlight,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header placeholder (mimics primaryColor header bar)
              Container(
                height: ManagerHeight.h66,
                width: double.infinity,
                color: Colors.white,
              ),
              // Map body placeholder
              Container(
                height: ManagerHeight.h200,
                width: double.infinity,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Shops List Shimmer  —  section title + horizontal row of cards
// ═════════════════════════════════════════════════════════════════════════════

/// Drop-in shimmer replacement for [HomeShopsListWidget] while data loads.
class HomeShopsShimmer extends StatelessWidget {
  const HomeShopsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShimmerBox(
                    width: ManagerWidth.w120, height: ManagerHeight.h16),
                _ShimmerBox(width: ManagerWidth.w60, height: ManagerHeight.h14),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // Horizontal list of shop card skeletons
          SizedBox(
            height: ManagerHeight.h74 + ManagerHeight.h30,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (_, __) => SizedBox(width: ManagerWidth.w12),
              itemBuilder: (_, __) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _ShimmerBox(
                    width: ManagerWidth.w74,
                    height: ManagerHeight.h74,
                    radius: ManagerRadius.r8,
                  ),
                  SizedBox(height: ManagerHeight.h8),
                  _ShimmerBox(
                    width: ManagerWidth.w60,
                    height: ManagerHeight.h12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Best Tailors Shimmer  —  section title + 3 vertical card skeletons
// ═════════════════════════════════════════════════════════════════════════════

/// Drop-in shimmer replacement for [HomeBestTailorsWidget] while data loads.
class HomeTailorsShimmer extends StatelessWidget {
  const HomeTailorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShimmerBox(
                    width: ManagerWidth.w140, height: ManagerHeight.h16),
                _ShimmerBox(width: ManagerWidth.w60, height: ManagerHeight.h14),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // Vertical card list
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                3,
                (i) => Padding(
                  padding: EdgeInsets.only(
                    bottom: i < 2 ? ManagerHeight.h12 : 0,
                  ),
                  child: const _TailorCardSkeleton(),
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
// Single tailor card skeleton
// ─────────────────────────────────────────────────────────────────────────────

class _TailorCardSkeleton extends StatelessWidget {
  const _TailorCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top content area — avatar + text lines
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w12,
              vertical: ManagerHeight.h12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                _ShimmerBox(
                  width: ManagerWidth.w64,
                  height: ManagerHeight.h64,
                  radius: ManagerRadius.r8,
                ),
                SizedBox(width: ManagerWidth.w12),

                // Text skeleton lines
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ShimmerBox(
                            width: ManagerWidth.w100,
                            height: ManagerHeight.h12,
                          ),
                          _ShimmerBox(
                            width: ManagerWidth.w60,
                            height: ManagerHeight.h20,
                            radius: ManagerRadius.r20,
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      _ShimmerBox(
                        width: ManagerWidth.w140,
                        height: ManagerHeight.h12,
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      Row(
                        children: [
                          _ShimmerBox(
                            width: ManagerWidth.w64,
                            height: ManagerHeight.h20,
                            radius: ManagerRadius.r20,
                          ),
                          SizedBox(width: ManagerWidth.w6),
                          _ShimmerBox(
                            width: ManagerWidth.w64,
                            height: ManagerHeight.h20,
                            radius: ManagerRadius.r20,
                          ),
                        ],
                      ),
                      SizedBox(height: ManagerHeight.h10),
                      _ShimmerBox(
                        width: ManagerWidth.w80,
                        height: ManagerHeight.h12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Status bar placeholder
          Container(
            height: ManagerHeight.h28,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ManagerColors.greyWhiteColor.withOpacity(0.08),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(ManagerRadius.r12),
                bottomRight: Radius.circular(ManagerRadius.r12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Products Grid Shimmer  —  section title + 2-column grid of 4 card skeletons
// ═════════════════════════════════════════════════════════════════════════════

/// Drop-in shimmer replacement for [HomeProductsGridWidget] while data loads.
class HomeProductsShimmer extends StatelessWidget {
  const HomeProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: _kBase,
      highlightColor: _kHighlight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header row
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _ShimmerBox(
                    width: ManagerWidth.w140, height: ManagerHeight.h16),
                _ShimmerBox(width: ManagerWidth.w60, height: ManagerHeight.h14),
              ],
            ),
          ),

          SizedBox(height: ManagerHeight.h14),

          // 2-column grid of 4 product card skeletons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.54,
              ),
              itemBuilder: (_, __) => const _ProductCardSkeleton(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single product card skeleton
// ─────────────────────────────────────────────────────────────────────────────

class _ProductCardSkeleton extends StatelessWidget {
  const _ProductCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                _ShimmerBox(
                  width: double.infinity,
                  height: double.infinity,
                  radius: ManagerRadius.r16,
                ),
                Positioned(
                  top: ManagerHeight.h8,
                  right: ManagerWidth.w8,
                  child: _ShimmerBox(
                    width: ManagerWidth.w64,
                    height: ManagerHeight.h24,
                    radius: ManagerRadius.r20,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(ManagerWidth.w10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ShimmerBox(
                    width: double.infinity,
                    height: ManagerHeight.h12,
                  ),
                  SizedBox(height: ManagerHeight.h8),
                  _ShimmerBox(
                    width: ManagerWidth.w76,
                    height: ManagerHeight.h10,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _ShimmerBox(
                        width: ManagerWidth.w78,
                        height: ManagerHeight.h13,
                      ),
                      const Spacer(),
                      _ShimmerBox(
                        width: ManagerWidth.w28,
                        height: ManagerWidth.w28,
                        radius: ManagerRadius.r8,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═════════════════════════════════════════════════════════════════════════════
// Custom Offer Card Shimmer  —  animated skeleton of the promotional CTA card
// ═════════════════════════════════════════════════════════════════════════════

/// Drop-in shimmer replacement for [HomeCustomOfferCardWidget] while loading.
/// Shows the exact structural skeleton (icon box · title line · subtitle lines
/// · arrow chevron) with a pulsing scissors icon so the user understands a
/// "create order" feature card is on its way.
class HomeCustomOfferShimmer extends StatefulWidget {
  const HomeCustomOfferShimmer({super.key});

  @override
  State<HomeCustomOfferShimmer> createState() => _HomeCustomOfferShimmerState();
}

class _HomeCustomOfferShimmerState extends State<HomeCustomOfferShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.88, end: 1.12).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: Shimmer.fromColors(
        baseColor: _kBase,
        highlightColor: _kHighlight,
        child: Container(
          width: double.infinity,
          height: ManagerHeight.h110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ManagerRadius.r16),
          ),
          child: Padding(
            padding: EdgeInsets.all(ManagerWidth.w16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon-box skeleton — pulsing scissors icon lives inside
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    width: ManagerWidth.w42,
                    height: ManagerWidth.w42,
                    decoration: BoxDecoration(
                      color: ManagerColors.greyWhiteColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(ManagerRadius.r10),
                    ),
                    child: Icon(
                      Icons.content_cut_rounded,
                      size: ManagerWidth.w20,
                      color: ManagerColors.greyWhiteColor.withOpacity(0.55),
                    ),
                  ),
                ),

                SizedBox(width: ManagerWidth.w12),

                // Title + subtitle skeleton lines
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ShimmerBox(
                        width: ManagerWidth.w140,
                        height: ManagerHeight.h14,
                        radius: ManagerRadius.r6,
                      ),
                      SizedBox(height: ManagerHeight.h8),
                      _ShimmerBox(
                        width: double.infinity,
                        height: ManagerHeight.h10,
                        radius: ManagerRadius.r5,
                      ),
                      SizedBox(height: ManagerHeight.h6),
                      _ShimmerBox(
                        width: ManagerWidth.w100,
                        height: ManagerHeight.h10,
                        radius: ManagerRadius.r5,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: ManagerWidth.w10),

                // Arrow placeholder
                _ShimmerBox(
                  width: ManagerWidth.w20,
                  height: ManagerHeight.h20,
                  radius: ManagerRadius.r4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable rounded rectangle shimmer block
// ─────────────────────────────────────────────────────────────────────────────

class _ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _ShimmerBox({
    required this.width,
    required this.height,
    this.radius = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
