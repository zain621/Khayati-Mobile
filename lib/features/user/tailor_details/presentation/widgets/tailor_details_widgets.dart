import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/features/user/tailor_details/domain/model/tailor_details_model.dart';
import 'package:app_mobile/features/user/tailor_details/presentation/controller/tailor_details_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

// ── Design tokens ──────────────────────────────────────────────────────────────
const Color _kGapColor    = Color(0xFFF2F2F2);
const Color _kDivider     = Color(0xFFEEEEEE);
const Color _kBodyText    = Color(0xFF444444);
const Color _kPrimaryTeal = Color(0xFF007A6C);
const Color _kGold        = Color(0xFFF9A825);
const Color _kGreenOpen   = Color(0xFF43A047);
const Color _kShimBase    = Color(0xFFE8E8E8);
const Color _kShimHigh    = Color(0xFFF5F5F5);

// ══════════════════════════════════════════════════════════════════════════════
// SHIMMER LOADING BODY
// ══════════════════════════════════════════════════════════════════════════════

Widget _shimBox({double? w, double? h, double r = 8}) => Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(r),
      ),
    );

class TailorDetailsLoadingBody extends StatelessWidget {
  const TailorDetailsLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final sw      = MediaQuery.of(context).size.width;
    final statusH = MediaQuery.of(context).padding.top;
    const appBarH = kToolbarHeight;

    return Column(
      children: [
        // ── AppBar skeleton ────────────────────────────────────────────────
        Container(
          color: ManagerColors.primaryColor,
          height: statusH + appBarH,
          padding: EdgeInsets.only(top: statusH),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: ManagerWidth.w8),
              Container(
                width: ManagerWidth.w34,
                height: ManagerHeight.h34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(width: ManagerWidth.w10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.30),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h6),
                  Container(
                    width: 90,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.20),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        Expanded(
          child: Shimmer.fromColors(
            baseColor: _kShimBase,
            highlightColor: _kShimHigh,
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Hero header ──────────────────────────────────────────
                  SizedBox(
                    height: ManagerHeight.h240,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Container(color: Colors.white),
                        Positioned(
                          bottom: ManagerHeight.h20,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 98,
                                height: 98,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(height: ManagerHeight.h10),
                              _shimBox(w: 150, h: 20),
                              SizedBox(height: ManagerHeight.h8),
                              _shimBox(w: 90, h: 26, r: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Stats panel ───────────────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      ManagerWidth.w16, ManagerHeight.h20,
                      ManagerWidth.w16, ManagerHeight.h20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              _buildStatCol(),
                              Container(width: 1, height: 44, color: Colors.white),
                              _buildStatCol(),
                              Container(width: 1, height: 44, color: Colors.white),
                              _buildStatCol(),
                            ],
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: ManagerWidth.w14,
                            vertical: ManagerHeight.h10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(ManagerRadius.r12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildTrustBadge(w: 58),
                              Container(width: 1, height: 20, color: Colors.white),
                              _buildTrustBadge(w: 58),
                              Container(width: 1, height: 20, color: Colors.white),
                              _buildTrustBadge(w: 44),
                            ],
                          ),
                        ),
                        SizedBox(height: ManagerHeight.h16),
                        _shimBox(w: double.infinity, h: 58, r: 14),
                      ],
                    ),
                  ),

                  Container(height: 8, color: _kGapColor),

                  // ── Content skeleton ──────────────────────────────────────
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.fromLTRB(
                      ManagerWidth.w16, ManagerHeight.h20,
                      ManagerWidth.w16, ManagerHeight.h20,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionHeader(labelW: 100),
                        SizedBox(height: ManagerHeight.h12),
                        _shimBox(w: double.infinity, h: 13),
                        SizedBox(height: ManagerHeight.h8),
                        _shimBox(w: sw * 0.70, h: 13),
                        SizedBox(height: ManagerHeight.h20),
                        _buildSectionHeader(labelW: 120),
                        SizedBox(height: ManagerHeight.h12),
                        Wrap(
                          spacing: ManagerWidth.w8,
                          runSpacing: ManagerHeight.h8,
                          children: List.generate(
                              4, (_) => _shimBox(w: 80, h: 32, r: 8)),
                        ),
                        SizedBox(height: ManagerHeight.h20),
                        _buildSectionHeader(labelW: 110),
                        SizedBox(height: ManagerHeight.h12),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                          ),
                          itemBuilder: (_, __) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(ManagerRadius.r8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatCol() => Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _shimBox(w: 38, h: 38, r: 19),
            SizedBox(height: ManagerHeight.h7),
            _shimBox(w: 38, h: 16),
            SizedBox(height: ManagerHeight.h3),
            _shimBox(w: 54, h: 11),
          ],
        ),
      );

  Widget _buildTrustBadge({required double w}) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _shimBox(w: 15, h: 15, r: 4),
          SizedBox(width: ManagerWidth.w5),
          _shimBox(w: w, h: 12),
        ],
      );

  Widget _buildSectionHeader({required double labelW}) => Row(
        children: [
          Container(width: 3, height: 18, color: Colors.white),
          SizedBox(width: ManagerWidth.w8),
          _shimBox(w: 30, h: 30, r: 15),
          SizedBox(width: ManagerWidth.w8),
          _shimBox(w: labelW, h: 16),
        ],
      );
}

// ══════════════════════════════════════════════════════════════════════════════
// LOADED BODY — entrance animation (fade + slide)
// ══════════════════════════════════════════════════════════════════════════════

class TailorDetailsLoadedBody extends StatefulWidget {
  final TailorDetailsController controller;
  const TailorDetailsLoadedBody({super.key, required this.controller});

  @override
  State<TailorDetailsLoadedBody> createState() =>
      _TailorDetailsLoadedBodyState();
}

class _TailorDetailsLoadedBodyState extends State<TailorDetailsLoadedBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fade  = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final ctrl   = widget.controller;
      final tailor = ctrl.tailor.value;
      if (tailor == null) {
        return _TailorDetailsErrorState(
          message: ctrl.errorMessage.value,
          onRetry: ctrl.fetchTailorDetails,
        );
      }
      return Directionality(
        textDirection: Directionality.of(context),
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: RefreshIndicator(
              onRefresh: ctrl.fetchTailorDetails,
              color: ManagerColors.primaryColor,
              backgroundColor: ManagerColors.white,
              displacement: 80,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                slivers: [
                  // ── Hero AppBar ──────────────────────────────────────────
                  SliverAppBar(
                    expandedHeight: ManagerHeight.h240,
                    pinned: true,
                    backgroundColor: ManagerColors.primaryColor,
                    surfaceTintColor: Colors.transparent,
                    elevation: 0,
                    leading: Padding(
                      padding: EdgeInsets.all(ManagerWidth.w8),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          height: ManagerHeight.h34,
                          width: ManagerWidth.w34,
                          padding: EdgeInsets.all(ManagerWidth.w4),
                          decoration: BoxDecoration(
                            color: ManagerColors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: ManagerColors.white,
                            size: ManagerHeight.h24,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      tailor.name,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.parallax,
                      background: _TailorHeroBackground(tailor: tailor),
                    ),
                  ),

                  // ── Stats + Trust + CTA ───────────────────────────────────
                  SliverToBoxAdapter(
                    child: _TailorInfoPanel(tailor: tailor, controller: ctrl),
                  ),

                  SliverToBoxAdapter(
                    child: Container(height: 8, color: _kGapColor),
                  ),

                  // ── Content sections ─────────────────────────────────────
                  SliverToBoxAdapter(
                    child: _TailorContentSections(tailor: tailor),
                  ),

                  if (tailor.bio != null ||
                      tailor.specializations.isNotEmpty ||
                      tailor.portfolioImages.isNotEmpty)
                    SliverToBoxAdapter(
                      child: Container(height: 8, color: _kGapColor),
                    ),

                  // ── Portfolio grid ────────────────────────────────────────
                  if (tailor.portfolioImages.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _PortfolioSection(tailor: tailor),
                    ),

                  SliverToBoxAdapter(
                    child: SizedBox(height: ManagerHeight.h40),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// ERROR STATE
// ══════════════════════════════════════════════════════════════════════════════

class _TailorDetailsErrorState extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _TailorDetailsErrorState({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_search_rounded,
              size: ManagerWidth.w48,
              color: ManagerColors.greyWhiteColor,
            ),
            SizedBox(height: ManagerHeight.h12),
            Text(
              message.isNotEmpty ? message : ManagerStrings.tailorDetailsError,
              textAlign: TextAlign.center,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: ManagerColors.greyWhiteColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(ManagerStrings.retry),
              style: ElevatedButton.styleFrom(
                backgroundColor: ManagerColors.primaryColor,
                foregroundColor: ManagerColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// HERO BACKGROUND — gradient + centered animated avatar + status badge
// ══════════════════════════════════════════════════════════════════════════════

class _TailorHeroBackground extends StatelessWidget {
  final TailorDetailsModel tailor;
  const _TailorHeroBackground({required this.tailor});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ManagerColors.primaryColor,
                  _kPrimaryTeal,
                  Color(0xFF004D45),
                ],
              ),
            ),
          ),
          // Decorative circle patterns
          Positioned(
            top: -40,
            right: -40,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          // Gradient scrim at bottom
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.55, 1.0],
                  colors: [
                    Color(0x00000000),
                    Color(0x22000000),
                    Color(0x88000000),
                  ],
                ),
              ),
            ),
          ),
          // Avatar + name + badge centered at bottom
          Positioned(
            bottom: ManagerHeight.h20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TailorAvatarWithRing(
                  imageUrl: tailor.image,
                  isAvailable: tailor.isAvailable,
                ),
                SizedBox(height: ManagerHeight.h10),
                Text(
                  tailor.name,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s18,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ManagerHeight.h6),
                _TailorStatusBadge(isAvailable: tailor.isAvailable),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Animated avatar with pulsing ring when available ──────────────────────────

class _TailorAvatarWithRing extends StatefulWidget {
  final String? imageUrl;
  final bool isAvailable;
  const _TailorAvatarWithRing(
      {required this.imageUrl, required this.isAvailable});

  @override
  State<_TailorAvatarWithRing> createState() => _TailorAvatarWithRingState();
}

class _TailorAvatarWithRingState extends State<_TailorAvatarWithRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    );
    _scale = Tween<double>(begin: 0.94, end: 1.06).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    if (widget.isAvailable) _pulse.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ringColor =
        widget.isAvailable ? _kGreenOpen : ManagerColors.greyWhiteColor;
    return AnimatedBuilder(
      animation: _scale,
      builder: (_, child) => Transform.scale(
        scale: widget.isAvailable ? _scale.value : 1.0,
        child: child,
      ),
      child: Container(
        width: 92,
        height: 92,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: ringColor, width: 3),
          boxShadow: [
            BoxShadow(
              color: ringColor.withOpacity(0.40),
              blurRadius: 14,
              spreadRadius: widget.isAvailable ? 3 : 0,
            ),
          ],
        ),
        padding: const EdgeInsets.all(3),
        child: ClipOval(
          child: (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
              ? CachedNetworkImage(
                  imageUrl: widget.imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => _AvatarPlaceholder(),
                  errorWidget: (_, __, ___) => _AvatarPlaceholder(),
                )
              : _AvatarPlaceholder(),
        ),
      ),
    );
  }
}

class _AvatarPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor.withOpacity(0.10),
      child: Center(
        child: CustomSvgImage(
          path: ManagerImages.logo,
          width: 38,
          height: 38,
          color: ManagerColors.white,
        ),
      ),
    );
  }
}

class _TailorStatusBadge extends StatelessWidget {
  final bool isAvailable;
  const _TailorStatusBadge({required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final color = isAvailable ? _kGreenOpen : ManagerColors.greyWhiteColor;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h5,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        border: Border.all(color: color.withOpacity(0.55), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(width: ManagerWidth.w6),
          Text(
            isAvailable
                ? ManagerStrings.tailorDetailsAvailable
                : ManagerStrings.tailorDetailsUnavailable,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// INFO PANEL — stats · trust strip · CTA button
// ══════════════════════════════════════════════════════════════════════════════

class _TailorInfoPanel extends StatelessWidget {
  final TailorDetailsModel tailor;
  final TailorDetailsController controller;
  const _TailorInfoPanel({required this.tailor, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h20,
        ManagerWidth.w16, ManagerHeight.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TailorStatsRow(tailor: tailor),
          SizedBox(height: ManagerHeight.h16),
          _TrustStrip(tailor: tailor),
          SizedBox(height: ManagerHeight.h16),
          _TailorCtaButton(controller: controller),
        ],
      ),
    );
  }
}

// ── Stats row ─────────────────────────────────────────────────────────────────

class _TailorStatsRow extends StatelessWidget {
  final TailorDetailsModel tailor;
  const _TailorStatsRow({required this.tailor});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          _StatItem(
            value: tailor.rating.toStringAsFixed(1),
            label: '${tailor.ratersCount} ${ManagerStrings.tailorDetailsReviews}',
            icon: Icons.star_rounded,
            iconColor: _kGold,
            bgColor: const Color(0xFFFFF8E1),
          ),
          _VerticalDivider(),
          _StatItem(
            value: '${tailor.offersCount}',
            label: ManagerStrings.tailorDetailsOffers,
            icon: Icons.description_outlined,
            iconColor: ManagerColors.primaryColor,
            bgColor: ManagerColors.primaryColor.withOpacity(0.09),
          ),
          _VerticalDivider(),
          _StatItem(
            value: '${tailor.completedOrdersCount}',
            label: ManagerStrings.tailorDetailsCompletedOrders,
            icon: Icons.check_circle_outline_rounded,
            iconColor: _kGreenOpen,
            bgColor: _kGreenOpen.withOpacity(0.09),
          ),
        ],
      ),
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      color: _kDivider,
      margin: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;

  const _StatItem({
    required this.value,
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 19),
          ),
          SizedBox(height: ManagerHeight.h7),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
            child: Text(
              label,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Trust strip ───────────────────────────────────────────────────────────────

class _TrustStrip extends StatelessWidget {
  final TailorDetailsModel tailor;
  const _TrustStrip({required this.tailor});

  @override
  Widget build(BuildContext context) {
    final badges = <({IconData icon, String label, Color color})>[];

    if (tailor.completedOrdersCount > 0) {
      badges.add((
        icon: Icons.verified_outlined,
        label: ManagerStrings.provenExperience,
        color: ManagerColors.primaryColor,
      ));
    }
    if (tailor.rating >= 4.0) {
      badges.add((
        icon: Icons.star_half_rounded,
        label: ManagerStrings.highRating,
        color: _kGold,
      ));
    }
    badges.add((
      icon: Icons.security_rounded,
      label: ManagerStrings.trustedTailor,
      color: ManagerColors.primaryColor,
    ));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9F7),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.12),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < badges.length; i++) ...[
            _TrustBadge(
              icon: badges[i].icon,
              label: badges[i].label,
              color: badges[i].color,
            ),
            if (i < badges.length - 1)
              Container(
                width: 1,
                height: 20,
                margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w6),
                color: ManagerColors.primaryColor.withOpacity(0.18),
              ),
          ],
        ],
      ),
    );
  }
}

class _TrustBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _TrustBadge(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 15, color: color),
        SizedBox(width: ManagerWidth.w5),
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s11,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

// ── CTA Button — sweep-light + bouncing icon + press-scale ───────────────────

class _TailorCtaButton extends StatefulWidget {
  final TailorDetailsController controller;
  const _TailorCtaButton({required this.controller});

  @override
  State<_TailorCtaButton> createState() => _TailorCtaButtonState();
}

class _TailorCtaButtonState extends State<_TailorCtaButton>
    with TickerProviderStateMixin {
  late final AnimationController _press;
  late final AnimationController _sweep;
  late final AnimationController _bounce;
  late final Animation<double> _scale;
  late final Animation<double> _sweepPos;
  late final Animation<double> _bounceY;

  @override
  void initState() {
    super.initState();
    _press = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 90),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _press, curve: Curves.easeOut),
    );
    _sweep = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
    _sweepPos = CurvedAnimation(
      parent: _sweep,
      curve: const Interval(0.0, 0.75, curve: Curves.easeInOut),
    );
    _bounce = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _bounceY = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -5.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 18),
      TweenSequenceItem(
          tween: Tween(begin: -5.0, end: 0.0)
              .chain(CurveTween(curve: Curves.bounceOut)),
          weight: 22),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 60),
    ]).animate(_bounce);
  }

  @override
  void dispose() {
    _press.dispose();
    _sweep.dispose();
    _bounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = widget.controller.isChatLoading.value;
      return GestureDetector(
        onTapDown: isLoading ? null : (_) => _press.forward(),
        onTapUp: isLoading ? null : (_) => _press.reverse(),
        onTapCancel: isLoading ? null : () => _press.reverse(),
        onTap: isLoading ? null : () => widget.controller.startChat(),
        child: AnimatedBuilder(
          animation: _scale,
          builder: (_, child) =>
              Transform.scale(scale: _scale.value, child: child),
          child: Container(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
            ),
            child: isLoading
                ? Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDBDBD),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                  )
                : LayoutBuilder(
                    builder: (ctx, constraints) {
                      final btnW = constraints.maxWidth;
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            ManagerColors.primaryColor,
                            _kPrimaryTeal,
                          ],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 1.5,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0),
                              Colors.white.withOpacity(0.30),
                              Colors.white.withOpacity(0),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _sweepPos,
                      builder: (_, __) {
                        final left = _sweepPos.value * (btnW + 90) - 90;
                        return Positioned(
                          top: 0,
                          bottom: 0,
                          left: left,
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.0),
                                  Colors.white.withOpacity(0.20),
                                  Colors.white.withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                            Center(
                              child: AnimatedBuilder(
                                animation: _bounceY,
                                builder: (_, child) => Transform.translate(
                                  offset: Offset(0, _bounceY.value),
                                  child: child,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.chat_bubble_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: ManagerWidth.w10),
                                    Text(
                                      ManagerStrings.detailsShopContact,
                                      style: getBoldTextStyle(
                                        fontSize: ManagerFontSize.s15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ),
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// CONTENT SECTIONS — bio · specializations
// ══════════════════════════════════════════════════════════════════════════════

class _TailorContentSections extends StatelessWidget {
  final TailorDetailsModel tailor;
  const _TailorContentSections({required this.tailor});

  @override
  Widget build(BuildContext context) {
    final hasBio  = tailor.bio != null && tailor.bio!.isNotEmpty;
    final hasSpc  = tailor.specializations.isNotEmpty;
    final hasMeta = tailor.address != null && tailor.address!.isNotEmpty;

    if (!hasBio && !hasSpc && !hasMeta) return const SizedBox.shrink();

    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h20,
        ManagerWidth.w16, ManagerHeight.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasBio) ...[
            _SectionHeader(
              title: ManagerStrings.tailorDetailsBio,
              icon: Icons.info_outline_rounded,
            ),
            SizedBox(height: ManagerHeight.h10),
            Text(
              tailor.bio!,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s13,
                color: _kBodyText,
              ),
              textDirection: Directionality.of(context),
            ),
            SizedBox(height: ManagerHeight.h20),
          ],
          if (hasBio && hasSpc)
            const Divider(height: 1, thickness: 1, color: _kDivider),
          if (hasSpc) ...[
            SizedBox(height: ManagerHeight.h16),
            _SectionHeader(
              title: ManagerStrings.tailorDetailsSpecializations,
              icon: Icons.category_outlined,
            ),
            SizedBox(height: ManagerHeight.h12),
            Wrap(
              spacing: ManagerWidth.w8,
              runSpacing: ManagerHeight.h8,
              children: tailor.specializations
                  .map((s) => _SpecChip(label: s))
                  .toList(),
            ),
            SizedBox(height: ManagerHeight.h16),
          ],
          if ((hasBio || hasSpc) && hasMeta)
            const Divider(height: 1, thickness: 1, color: _kDivider),
          if (hasMeta) ...[
            SizedBox(height: ManagerHeight.h16),
            _MetaItem(
              icon: Icons.location_on_outlined,
              text: tailor.address!,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Section header with accent bar ───────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionHeader({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 18,
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        SizedBox(width: ManagerWidth.w8),
        Icon(icon, size: 17, color: ManagerColors.primaryColor),
        SizedBox(width: ManagerWidth.w6),
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s15,
            color: ManagerColors.black,
          ),
        ),
      ],
    );
  }
}

class _SpecChip extends StatelessWidget {
  final String label;
  const _SpecChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h8,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.07),
        borderRadius: BorderRadius.circular(ManagerRadius.r8),
        border: Border.all(
          color: ManagerColors.primaryColor.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s12,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: ManagerColors.primaryColor.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: ManagerColors.primaryColor),
        ),
        SizedBox(width: ManagerWidth.w10),
        Flexible(
          child: Text(
            text,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s13,
              color: _kBodyText,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PORTFOLIO SECTION
// ══════════════════════════════════════════════════════════════════════════════

class _PortfolioSection extends StatelessWidget {
  final TailorDetailsModel tailor;
  const _PortfolioSection({required this.tailor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.white,
      padding: EdgeInsets.fromLTRB(
        ManagerWidth.w16, ManagerHeight.h20,
        ManagerWidth.w16, ManagerHeight.h20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionHeader(
            title: ManagerStrings.tailorDetailsPortfolio,
            icon: Icons.photo_library_outlined,
          ),
          SizedBox(height: ManagerHeight.h14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tailor.portfolioImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: ManagerWidth.w6,
              mainAxisSpacing: ManagerHeight.h6,
            ),
            itemBuilder: (_, i) => _PortfolioTile(
              imageUrl: tailor.portfolioImages[i],
              index: i,
              allImages: tailor.portfolioImages,
            ),
          ),
        ],
      ),
    );
  }
}

class _PortfolioTile extends StatefulWidget {
  final String imageUrl;
  final int index;
  final List<String> allImages;

  const _PortfolioTile({
    required this.imageUrl,
    required this.index,
    required this.allImages,
  });

  @override
  State<_PortfolioTile> createState() => _PortfolioTileState();
}

class _PortfolioTileState extends State<_PortfolioTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.92,
      upperBound: 1.0,
    )..value = 1.0;
    _scale = _ctrl;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.reverse(),
      onTapUp: (_) {
        _ctrl.forward();
        _showFullScreen(context);
      },
      onTapCancel: () => _ctrl.forward(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r8),
          child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            fit: BoxFit.cover,
            placeholder: (_, __) => Container(
              color: const Color(0xFFEEEEEE),
            ),
            errorWidget: (_, __, ___) => Container(
              color: const Color(0xFFEEEEEE),
              child: Icon(
                Icons.broken_image_outlined,
                color: ManagerColors.greyWhiteColor,
                size: ManagerWidth.w24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showFullScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black87,
        pageBuilder: (_, __, ___) => _PortfolioFullScreen(
          images: widget.allImages,
          initialIndex: widget.index,
        ),
      ),
    );
  }
}

// ── Full-screen portfolio viewer ──────────────────────────────────────────────

class _PortfolioFullScreen extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const _PortfolioFullScreen(
      {required this.images, required this.initialIndex});

  @override
  State<_PortfolioFullScreen> createState() => _PortfolioFullScreenState();
}

class _PortfolioFullScreenState extends State<_PortfolioFullScreen> {
  late final PageController _page;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _page = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView.builder(
              controller: _page,
              itemCount: widget.images.length,
              onPageChanged: (i) => setState(() => _current = i),
              itemBuilder: (_, i) => Center(
                child: InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[i],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            // Close button
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              right: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
            // Dots indicator
            if (widget.images.length > 1)
              Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.images.length,
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      width: i == _current ? 18 : 7,
                      height: 7,
                      decoration: BoxDecoration(
                        color: i == _current
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
