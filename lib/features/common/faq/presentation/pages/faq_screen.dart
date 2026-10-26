import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/widgets/app_safe_area.dart';
import 'package:app_mobile/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
// FAQ Screen — الأسئلة الشائعة
// ─────────────────────────────────────────────────────────────────────────────

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  // Track which item is expanded (-1 = none)
  int _expandedIndex = 0;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  List<_FaqData> get _items => [
        _FaqData(
          question: ManagerStrings.faqQ1,
          subtitle: ManagerStrings.faqQ1Sub,
          answer: ManagerStrings.faqQ1Answer,
        ),
        _FaqData(
          question: ManagerStrings.faqQ2,
          subtitle: ManagerStrings.faqQ2Sub,
          answer: ManagerStrings.faqQ2Answer,
        ),
        _FaqData(
          question: ManagerStrings.faqQ3,
          subtitle: ManagerStrings.faqQ3Sub,
          answer: ManagerStrings.faqQ3Answer,
        ),
        _FaqData(
          question: ManagerStrings.faqQ4,
          subtitle: ManagerStrings.faqQ4Sub,
          answer: ManagerStrings.faqQ4Answer,
        ),
        _FaqData(
          question: ManagerStrings.faqQ5,
          subtitle: ManagerStrings.faqQ5Sub,
          answer: ManagerStrings.faqQ5Answer,
        ),
        _FaqData(
          question: ManagerStrings.faqQ6,
          subtitle: ManagerStrings.faqQ6Sub,
          answer: ManagerStrings.faqQ6Answer,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final items = _items;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: AppSafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFF5F7FA),
          body: Column(
            children: [
              // ── AppBar ─────────────────────────────────────────────────────
              CustomAppBar(
                title: ManagerStrings.faqTitle,
                subtitle: ManagerStrings.faqSubtitle,
                showBackButton: true,
                onBackPressed: () => Navigator.pop(context),
              ),

              // ── List ───────────────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16,
                    vertical: ManagerHeight.h16,
                  ),
                  child: Column(
                    children: items.asMap().entries.map((entry) {
                      final i = entry.key;
                      final data = entry.value;

                      // Staggered entrance: each item offset by 0.1
                      final start = (i * 0.10).clamp(0.0, 0.9);
                      final end = (start + 0.45).clamp(0.0, 1.0);
                      final anim = CurvedAnimation(
                        parent: _entranceController,
                        curve: Interval(start, end,
                            curve: Curves.easeOutCubic),
                      );

                      return Padding(
                        padding: EdgeInsets.only(bottom: ManagerHeight.h10),
                        child: FadeTransition(
                          opacity: anim,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.22),
                              end: Offset.zero,
                            ).animate(anim),
                            child: _FaqCard(
                              number: i + 1,
                              data: data,
                              isExpanded: _expandedIndex == i,
                              onTap: () => setState(() {
                                _expandedIndex =
                                    _expandedIndex == i ? -1 : i;
                              }),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
// Data model
// ══════════════════════════════════════════════════════════════════════════════

class _FaqData {
  final String question;
  final String subtitle;
  final String answer;

  const _FaqData({
    required this.question,
    required this.subtitle,
    required this.answer,
  });
}

// ══════════════════════════════════════════════════════════════════════════════
// FAQ Card — with animated expand/collapse
// ══════════════════════════════════════════════════════════════════════════════

class _FaqCard extends StatefulWidget {
  final int number;
  final _FaqData data;
  final bool isExpanded;
  final VoidCallback onTap;

  const _FaqCard({
    required this.number,
    required this.data,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<_FaqCard> createState() => _FaqCardState();
}

class _FaqCardState extends State<_FaqCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _expandCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _rotateAnim;

  @override
  void initState() {
    super.initState();
    _expandCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
      value: widget.isExpanded ? 1.0 : 0.0,
    );
    _fadeAnim = CurvedAnimation(
      parent: _expandCtrl,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    _rotateAnim = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(parent: _expandCtrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void didUpdateWidget(_FaqCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      widget.isExpanded ? _expandCtrl.forward() : _expandCtrl.reverse();
    }
  }

  @override
  void dispose() {
    _expandCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool expanded = widget.isExpanded;

    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          boxShadow: [
            BoxShadow(
              color: expanded
                  ? ManagerColors.primaryColor.withOpacity(0.12)
                  : ManagerColors.black.withOpacity(0.06),
              blurRadius: expanded ? 18 : 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Question row ───────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w14,
                  vertical: ManagerHeight.h14,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     // ── Number badge ───────────────────────────────────────
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 260),
                      curve: Curves.easeOutCubic,
                      width: ManagerWidth.w36,
                      height: ManagerHeight.h36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ManagerRadius.r8),
                        color: expanded
                            ? ManagerColors.primaryColor
                            : ManagerColors.primaryColor.withOpacity(0.08),
                        // shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${widget.number}',
                          style: getBoldTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: expanded
                                ? ManagerColors.white
                                : ManagerColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  

                    SizedBox(width: ManagerWidth.w12),

                    // ── Question + subtitle ────────────────────────────────
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.question,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: expanded
                                  ? ManagerColors.primaryColor
                                  : ManagerColors.black,
                            ),
                          ),
                          SizedBox(height: ManagerHeight.h3),
                          Text(
                            widget.data.subtitle,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.greyWhiteColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w12),
  // ── Chevron (animated rotate) ──────────────────────────
                    RotationTransition(
                      turns: _rotateAnim,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: ManagerFontSize.s14,
                        color: expanded
                            ? ManagerColors.primaryColor
                            : ManagerColors.greyWhiteColor.withOpacity(0.5),
                      ),
                    ),
                   
                  ],
                ),
              ),

              // ── Answer panel (animated size + fade) ───────────────────────
              AnimatedSize(
                duration: const Duration(milliseconds: 310),
                curve: Curves.easeOutCubic,
                child: expanded
                    ? FadeTransition(
                        opacity: _fadeAnim,
                        child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(
                            ManagerWidth.w14,
                            0,
                            ManagerWidth.w14,
                            ManagerHeight.h14,
                          ),
                          padding: EdgeInsets.all(ManagerWidth.w14),
                          decoration: BoxDecoration(
                            color:
                                ManagerColors.primaryColor.withOpacity(0.06),
                            borderRadius:
                                BorderRadius.circular(ManagerRadius.r12),
                            // border: Border.all(
                            //   color: ManagerColors.primaryColor
                            //       .withOpacity(0.12),
                            // ),
                          ),
                          child: Text(
                            widget.data.answer,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.primaryColor,
                            ),
                            textAlign: TextAlign.start,
                            // height: 1.7,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
