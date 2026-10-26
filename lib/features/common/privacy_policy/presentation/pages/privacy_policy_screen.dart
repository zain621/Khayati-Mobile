import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/features/common/about_app/presentation/widgets/about_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Privacy Policy Screen — سياسة الخصوصية
// ─────────────────────────────────────────────────────────────────────────────

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── Staggered helpers ──────────────────────────────────────────────────────
  Animation<double> _interval(double start, double end) => CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

  Widget _fadeSlide(
    Widget child, {
    required double start,
    required double end,
    Offset from = const Offset(0, 0.16),
  }) {
    final anim = _interval(start, end);
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(begin: from, end: Offset.zero).animate(anim),
        child: child,
      ),
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Column(
            children: [
              // ── Header ─────────────────────────────────────────────────────
              AboutAppBarWidget(
                title: ManagerStrings.privacyTitle,
                subtitle: ManagerStrings.privacySubtitle,
                showBackButton: true,
                onBackPressed: () => Navigator.pop(context),
              ),

              // ── Scrollable body ────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16,
                    vertical: ManagerHeight.h20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Intro card ──────────────────────────────────────────
                      _fadeSlide(
                        _PrivacyIntroCard(),
                        start: 0.0,
                        end: 0.40,
                        from: const Offset(0, 0.14),
                      ),

                      SizedBox(height: ManagerHeight.h14),

                      // ── Section 1 ───────────────────────────────────────────
                      _fadeSlide(
                        _PolicySectionCard(
                          number: '1',
                          title: ManagerStrings.privacy1Title,
                          body: ManagerStrings.privacy1Body,
                        ),
                        start: 0.15,
                        end: 0.50,
                      ),

                      SizedBox(height: ManagerHeight.h12),

                      // ── Section 2 ───────────────────────────────────────────
                      _fadeSlide(
                        _PolicySectionCard(
                          number: '2',
                          title: ManagerStrings.privacy2Title,
                          body: ManagerStrings.privacy2Body,
                        ),
                        start: 0.25,
                        end: 0.60,
                      ),

                      SizedBox(height: ManagerHeight.h12),

                      // ── Section 3 ───────────────────────────────────────────
                      _fadeSlide(
                        _PolicySectionCard(
                          number: '3',
                          title: ManagerStrings.privacy3Title,
                          body: ManagerStrings.privacy3Body,
                        ),
                        start: 0.35,
                        end: 0.70,
                      ),

                      SizedBox(height: ManagerHeight.h12),

                      // ── Section 4 ───────────────────────────────────────────
                      _fadeSlide(
                        _PolicySectionCard(
                          number: '4',
                          title: ManagerStrings.privacy4Title,
                          body: ManagerStrings.privacy4Body,
                        ),
                        start: 0.45,
                        end: 0.80,
                      ),

                      SizedBox(height: ManagerHeight.h16),

                      // ── Last updated footer ─────────────────────────────────
                      _fadeSlide(
                        _LastUpdatedBadge(),
                        start: 0.60,
                        end: 0.90,
                        from: const Offset(0, 0.10),
                      ),

                      SizedBox(height: ManagerHeight.h16),
                    ],
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
// Intro card — title + intro paragraph with background image
// ══════════════════════════════════════════════════════════════════════════════

class _PrivacyIntroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background fabric pattern
          Align(
            alignment: Alignment.topLeft,
            child: Opacity(
              opacity: 0.55,
              child: Image.asset(
                ManagerImages.updateProfileBackground,
                fit: BoxFit.contain,
                height: ManagerHeight.h90,
              ),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title row
                Row(
                  children: [
                    Container(
                      width: ManagerWidth.w34,
                      height: ManagerHeight.h34,
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor.withOpacity(0.09),
                        borderRadius: BorderRadius.circular(ManagerRadius.r10),
                      ),
                      child: Icon(
                        Icons.shield_outlined,
                        color: ManagerColors.primaryColor,
                        size: ManagerFontSize.s18,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w10),
                    Text(
                      ManagerStrings.privacyIntroTitle,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h12),

                // Thin divider
                Container(
                  height: 1,
                  color: ManagerColors.primaryColor.withOpacity(0.08),
                ),

                SizedBox(height: ManagerHeight.h12),

                // Intro paragraph
                Text(
                  ManagerStrings.privacyIntroBody,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.black.withOpacity(0.72),
                  ),
                  textAlign: TextAlign.start,
                  textDirection: Directionality.of(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Policy section card — numbered badge + title + body
// ══════════════════════════════════════════════════════════════════════════════

class _PolicySectionCard extends StatelessWidget {
  final String number;
  final String title;
  final String body;

  const _PolicySectionCard({
    required this.number,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle top-left background tint
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: ManagerWidth.w6,
              height: double.infinity,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ManagerRadius.r16),
                  bottomRight: Radius.circular(ManagerRadius.r16),
                  topLeft: Radius.circular(ManagerRadius.r16),
                  bottomLeft: Radius.circular(ManagerRadius.r16),
                ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(
              right: ManagerWidth.w16,
              left: ManagerWidth.w20,
              top: ManagerHeight.h14,
              bottom: ManagerHeight.h16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header row: number badge + title ───────────────────────
                Row(
                  children: [
                    // Number badge
                    Container(
                      width: ManagerWidth.w28,
                      height: ManagerHeight.h28,
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor,
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                      ),
                      child: Center(
                        child: Text(
                          number,
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s13,
                            color: ManagerColors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w10),
                    // Title
                    Expanded(
                      child: Text(
                        title,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s13,
                          color: ManagerColors.black,
                        ),
                        textDirection: Directionality.of(context),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h10),

                // Thin divider
                Container(
                  height: 1,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.15),
                ),

                SizedBox(height: ManagerHeight.h10),

                // ── Body text ──────────────────────────────────────────────
                Text(
                  body,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s12,
                    color: ManagerColors.black.withOpacity(0.70),
                  ),
                  textAlign: TextAlign.start,
                  textDirection: Directionality.of(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Last updated badge
// ══════════════════════════════════════════════════════════════════════════════

class _LastUpdatedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h8,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.primaryColor.withOpacity(0.07),
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
          border: Border.all(
            color: ManagerColors.primaryColor.withOpacity(0.15),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.access_time_rounded,
              size: ManagerFontSize.s13,
              color: ManagerColors.primaryColor,
            ),
            SizedBox(width: ManagerWidth.w6),
            Text(
              ManagerStrings.privacyLastUpdated,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
