import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_icons.dart';
import 'package:app_mobile/core/resources/manager_images.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_svg_image.dart';
import 'package:app_mobile/features/common/about_app/presentation/widgets/about_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
// About App Screen — عن التطبيق
// ─────────────────────────────────────────────────────────────────────────────

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ── Staggered animation helpers ────────────────────────────────────────────
  Animation<double> _interval(double start, double end) => CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeOutCubic),
      );

  Widget _fadeSlide(
    Widget child, {
    required double start,
    required double end,
    Offset from = const Offset(0, 0.18),
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
          backgroundColor: ManagerColors.white,
          body: Column(
            children: [
              AboutAppBarWidget(
                title: ManagerStrings.aboutAppTitle,
                subtitle: ManagerStrings.aboutAppSubtitle,
                showBackButton: true,
                onBackPressed: () => Navigator.pop(context),
              ),
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
                      // ── Stats row ──────────────────────────────────────────
                      _fadeSlide(
                        _StatsRow(),
                        start: 0.0,
                        end: 0.45,
                        from: const Offset(0, 0.14),
                      ),

                      SizedBox(height: ManagerHeight.h20),

                      // ── About section ──────────────────────────────────────
                      // _fadeSlide(
                      //   _SectionLabel(
                      //     icon: Icons.info_outline_rounded,
                      //     label: ManagerStrings.aboutAppSectionAbout,
                      //   ),
                      //   start: 0.15,
                      //   end: 0.55,
                      // ),
                      SizedBox(height: ManagerHeight.h8),
                      _fadeSlide(
                        _AboutCard(),
                        start: 0.2,
                        end: 0.6,
                      ),

                      SizedBox(height: ManagerHeight.h20),

                      SizedBox(height: ManagerHeight.h8),
                      _fadeSlide(
                        _FeaturesCard(),
                        start: 0.35,
                        end: 0.72,
                      ),

                      SizedBox(height: ManagerHeight.h20),

                      // ── Branding footer ────────────────────────────────────
                      _fadeSlide(
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(ManagerRadius.r12),
                          child: Image.asset(
                            ManagerImages.aboutUsImage,
                            width: double.infinity,
                            height: ManagerHeight.h124,
                            fit: BoxFit.cover,
                          ),
                        ),
                        start: 0.55,
                        end: 0.88,
                        from: const Offset(0, 0.22),
                      ),

                      SizedBox(height: ManagerHeight.h8),
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
// Stats row — 3 cards
// ══════════════════════════════════════════════════════════════════════════════

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: ManagerIcons.completedOrderIcon,
          value: '+180k',
          label: ManagerStrings.aboutAppStatOrders,
        ),
        SizedBox(width: ManagerWidth.w10),
        _StatCard(
          icon: ManagerIcons.independentTailorIcon,
          value: '85',
          label: ManagerStrings.aboutAppStatTailors,
        ),
        SizedBox(width: ManagerWidth.w10),
        _StatCard(
          icon: ManagerIcons.raylIcon,
          value: '180',
          label: ManagerStrings.aboutAppStatUsers,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: ManagerHeight.h14,
          horizontal: ManagerWidth.w6,
        ),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r14),
          boxShadow: [
            BoxShadow(
              color: ManagerColors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: ManagerWidth.w40,
              height: ManagerHeight.h40,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor.withOpacity(0.09),
                borderRadius: BorderRadius.circular(ManagerRadius.r10),
              ),
              child: Padding(
                padding: EdgeInsets.all(ManagerWidth.w10),
                child: CustomSvgImage(
                  color: ManagerColors.primaryColor,
                  path: icon,
                  width: ManagerWidth.w20,
                  height: ManagerHeight.h20,
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h8),
            Text(
              value,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s15,
                color: ManagerColors.primaryColor,
              ),
            ),
            SizedBox(height: ManagerHeight.h3),
            Text(
              label,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s10,
                color: ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// About description card
// ══════════════════════════════════════════════════════════════════════════════

class _AboutCard extends StatelessWidget {
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
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              ManagerImages.updateProfileBackground,
              fit: BoxFit.contain,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16, vertical: ManagerHeight.h14),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      size: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                    SizedBox(width: ManagerWidth.w6),
                    Text(
                      ManagerStrings.aboutAppSectionAbout,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ManagerHeight.h8),
                Text(
                  ManagerStrings.aboutAppDescription,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: ManagerColors.black.withOpacity(0.75),
                  ),
                  textAlign: TextAlign.start,
                  // height: 1.7,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Features card — list of 4 items
// ══════════════════════════════════════════════════════════════════════════════

class _FeaturesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final features = [
      _FeatureData(
        icon: Icons.verified_outlined,
        iconBg: ManagerColors.primaryColor.withOpacity(0.09),
        iconColor: ManagerColors.primaryColor,
        title: ManagerStrings.aboutAppFeature1Title,
        subtitle: ManagerStrings.aboutAppFeature1Sub,
      ),
      _FeatureData(
        icon: Icons.tune_rounded,
        iconBg: ManagerColors.primaryColor.withOpacity(0.09),
        iconColor: ManagerColors.primaryColor,
        title: ManagerStrings.aboutAppFeature2Title,
        subtitle: ManagerStrings.aboutAppFeature2Sub,
      ),
      _FeatureData(
        icon: Icons.star_half_rounded,
        iconBg: ManagerColors.primaryColor.withOpacity(0.09),
        iconColor: ManagerColors.primaryColor,
        title: ManagerStrings.aboutAppFeature3Title,
        subtitle: ManagerStrings.aboutAppFeature3Sub,
      ),
      _FeatureData(
        icon: Icons.chat_bubble_outline_rounded,
        iconBg: ManagerColors.primaryColor.withOpacity(0.09),
        iconColor: ManagerColors.primaryColor,
        title: ManagerStrings.aboutAppFeature4Title,
        subtitle: ManagerStrings.aboutAppFeature4Sub,
      ),
    ];

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
          // Background image
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
              ManagerImages.updateProfileBackground,
              fit: BoxFit.contain,
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w16,
              vertical: ManagerHeight.h14,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Section title ─────────────────────────────────────────
                Row(
                  children: [
                    Icon(
                      Icons.star_outline_rounded,
                      size: ManagerFontSize.s16,
                      color: ManagerColors.primaryColor,
                    ),
                    SizedBox(width: ManagerWidth.w6),
                    Text(
                      ManagerStrings.aboutAppSectionFeatures,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ManagerHeight.h8),
                // ── Features list ────────────────────────────────────────
                ...features.asMap().entries.map((entry) {
                  final i = entry.key;
                  final f = entry.value;
                  return _FeatureItem(
                    data: f,
                    isLast: i == features.length - 1,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _FeatureData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}

class _FeatureItem extends StatelessWidget {
  final _FeatureData data;
  final bool isLast;

  const _FeatureItem({required this.data, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w14,
            vertical: ManagerHeight.h14,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: ManagerWidth.w44,
                height: ManagerHeight.h44,
                decoration: BoxDecoration(
                  color: data.iconBg,
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                ),
                child: Icon(
                  data.icon,
                  color: data.iconColor,
                  size: ManagerFontSize.s22,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h4),
                    Text(
                      data.subtitle,
                      style: getRegularTextStyle(
                        fontSize: ManagerFontSize.s12,
                        color: ManagerColors.greyWhiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            thickness: 0.7,
            indent: ManagerWidth.w70,
            color: ManagerColors.greyWhiteColor.withOpacity(0.15),
          ),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// Branding footer card
// ══════════════════════════════════════════════════════════════════════════════

// ══════════════════════════════════════════════════════════════════════════════
// Shared section label
// ══════════════════════════════════════════════════════════════════════════════

// ignore: unused_element
class _SectionLabel extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SectionLabel({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: ManagerFontSize.s16,
          color: ManagerColors.greyWhiteColor,
        ),
        SizedBox(width: ManagerWidth.w6),
        Text(
          label,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s13,
            color: ManagerColors.greyWhiteColor,
          ),
        ),
      ],
    );
  }
}
