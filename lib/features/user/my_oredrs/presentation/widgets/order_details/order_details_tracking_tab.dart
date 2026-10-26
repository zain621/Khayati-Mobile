import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/my_oredrs/domain/model/order_details_model.dart';
import 'package:app_mobile/features/user/my_oredrs/presentation/widgets/order_details/order_details_colors.dart';
import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// OrderDetailsTrackingTab
// RTL timeline: dots on the RIGHT, cards on the LEFT
// Staggered slide + fade animation for each step
// ─────────────────────────────────────────────────────────────────────────────

class OrderDetailsTrackingTab extends StatefulWidget {
  final List<OrderTrackingStep> steps;
  final int completedCount;
  const OrderDetailsTrackingTab({
    super.key,
    required this.steps,
    required this.completedCount,
  });

  @override
  State<OrderDetailsTrackingTab> createState() =>
      _OrderDetailsTrackingTabState();
}

class _OrderDetailsTrackingTabState extends State<OrderDetailsTrackingTab>
    with TickerProviderStateMixin {
  late final AnimationController _headerController;
  late final Animation<double> _headerFade;
  late final Animation<Offset> _headerSlide;

  late final List<AnimationController> _stepControllers;
  late final List<Animation<double>> _stepFades;
  late final List<Animation<Offset>> _stepSlides;

  @override
  void initState() {
    super.initState();
    final steps = widget.steps;

    // ── Header animation ──
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _headerFade = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOut,
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));

    // ── Step animations (staggered) ──
    _stepControllers = List.generate(
      steps.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
      ),
    );
    _stepFades = _stepControllers
        .map((c) => CurvedAnimation(parent: c, curve: Curves.easeOut))
        .toList();
    _stepSlides = _stepControllers
        .map(
          (c) => Tween<Offset>(
            begin: const Offset(0.15, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic)),
        )
        .toList();

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;
    _headerController.forward();
    for (int i = 0; i < _stepControllers.length; i++) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (!mounted) return;
      _stepControllers[i].forward();
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    for (final c in _stepControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final steps = widget.steps;
    final completed = widget.completedCount;
    final total = steps.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section header + counter ──────────────────────────────────
        SlideTransition(
          position: _headerSlide,
          child: FadeTransition(
            opacity: _headerFade,
            child: Row(
              children: [
                Container(
                  width: ManagerWidth.w30,
                  height: ManagerHeight.h30,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(ManagerRadius.r8),
                  ),
                  child: Icon(
                    Icons.alt_route_rounded,
                    size: ManagerFontSize.s15,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                SizedBox(width: ManagerWidth.w8),
                Text(
                  ManagerStrings.orderDetailsTrackingSection,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s14,
                    color: ManagerColors.black,
                  ),
                ),
                const Spacer(),
                _StepsCounter(completed: completed, total: total),
              ],
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h16),

        // ── Animated progress bar ─────────────────────────────────
        SlideTransition(
          position: _headerSlide,
          child: FadeTransition(
            opacity: _headerFade,
            child: _TrackingProgressBar(
              completed: completed,
              total: total,
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h20),

        // ── Timeline ─────────────────────────────────────────────────
        ...List.generate(
          steps.length,
          (i) => SlideTransition(
            position: _stepSlides[i],
            child: FadeTransition(
              opacity: _stepFades[i],
              child: _TimelineStep(
                step: steps[i],
                isLast: i == steps.length - 1,
              ),
            ),
          ),
        ),

        SizedBox(height: ManagerHeight.h24),
      ],
    );
  }
}

// ── Animated progress bar ─────────────────────────────────────────────

class _TrackingProgressBar extends StatefulWidget {
  final int completed;
  final int total;
  const _TrackingProgressBar({
    required this.completed,
    required this.total,
  });

  @override
  State<_TrackingProgressBar> createState() => _TrackingProgressBarState();
}

class _TrackingProgressBarState extends State<_TrackingProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    final ratio =
        widget.total > 0 ? widget.completed / widget.total : 0.0;
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _progress = Tween<double>(begin: 0, end: ratio).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 120), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            ManagerStrings.orderDetailsProgressLabel,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s11,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
          const Spacer(),
          AnimatedBuilder(
            animation: _progress,
            builder: (_, __) => Text(
              '${(_progress.value * widget.total).round()} / ${widget.total}',
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s11,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: ManagerHeight.h6),
      ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r10),
        child: AnimatedBuilder(
          animation: _progress,
          builder: (_, __) => LinearProgressIndicator(
            value: _progress.value,
            minHeight: 6,
            backgroundColor: kOdLineColor,
            color: kOdCompletedDot,
          ),
        ),
      ),
    ]);
  }
}

// ── Steps counter pill ─────────────────────────────────────────────────────

class _StepsCounter extends StatelessWidget {
  final int completed;
  final int total;
  const _StepsCounter({required this.completed, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: ManagerColors.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Text(
        '$completed ${ManagerStrings.orderDetailsStepsOf} $total',
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s11,
          color: ManagerColors.primaryColor,
        ),
      ),
    );
  }
}

// ── Timeline step ──────────────────────────────────────────────────────────

class _TimelineStep extends StatelessWidget {
  final OrderTrackingStep step;
  final bool isLast;

  const _TimelineStep({
    required this.step,
    required this.isLast,
  });

  Color get _dotColor {
    switch (step.state) {
      case OrderTrackingStepState.completed:
        return kOdCompletedDot;
      case OrderTrackingStepState.current:
        return kOdCurrentDot;
      case OrderTrackingStepState.pending:
        return kOdPendingDot;
    }
  }

  Color get _lineBelow {
    if (step.isCompleted) return kOdCompletedDot.withOpacity(0.35);
    return kOdLineColor;
  }

  @override
  Widget build(BuildContext context) {
    const double dotSize = 36;
    const double pendingDotSize = 28;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Dot + connector line (FIRST in Row → renders on RIGHT in RTL) ──
          SizedBox(
            width: dotSize,
            child: Column(
              children: [
                SizedBox(height: ManagerHeight.h6),
                _TimelineDot(
                  state: step.state,
                  color: _dotColor,
                  icon: step.icon,
                  size: step.isPending ? pendingDotSize : dotSize,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.5,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      decoration: BoxDecoration(
                        color: _lineBelow,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          SizedBox(width: ManagerWidth.w12),

          // ── Content card (SECOND in Row → renders on LEFT in RTL) ──
          Expanded(
            child: _StepCard(step: step),
          ),
        ],
      ),
    );
  }
}

// ── Step card ──────────────────────────────────────────────────────────────

class _StepCard extends StatelessWidget {
  final OrderTrackingStep step;
  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: ManagerHeight.h12),
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      decoration: BoxDecoration(
        color: step.isCurrent
            ? ManagerColors.primaryColor.withOpacity(0.04)
            : step.isPending
                ? const Color(0xFFF8F9FA)
                : ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
        border: Border.all(
          color: step.isCurrent
              ? ManagerColors.primaryColor.withOpacity(0.20)
              : step.isPending
                  ? const Color(0xFFE8E8E8)
                  : const Color(0xFFEEEEEE),
          width: 1,
        ),
        boxShadow: step.isPending
            ? null
            : [
                BoxShadow(
                  color: ManagerColors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── Title row + badge ────────────────────────
          Row(
            children: [
              // Badge (start = left in RTL visual)
              if (step.isCompleted)
                _StepBadge(
                  label: ManagerStrings.orderDetailsStepCompleted,
                  bg: kOdPaidBg,
                  textColor: kOdSuccessText,
                ),
              if (step.isCurrent)
                _StepBadge(
                  label: ManagerStrings.orderDetailsStepCurrent,
                  bg: ManagerColors.primaryColor.withOpacity(0.10),
                  textColor: ManagerColors.primaryColor,
                ),
              const Spacer(),
              // Title (end = right in RTL visual)
              Flexible(
                child: Text(
                  step.title,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s13,
                    color: step.isPending
                        ? ManagerColors.greyWhiteColor
                        : ManagerColors.black,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),

          // ── Description ────────────────────────────
          if (step.description.isNotEmpty) ...[
            SizedBox(height: ManagerHeight.h6),
            Text(
              step.description,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s11,
                color: step.isPending
                    ? ManagerColors.greyWhiteColor.withOpacity(0.5)
                    : ManagerColors.greyWhiteColor,
              ),
              textAlign: TextAlign.end,
            ),
          ],

          // ── Date ────────────────────────────────────
          if (step.dateTime.isNotEmpty) ...[
            SizedBox(height: ManagerHeight.h8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  step.dateTime,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s10,
                    color: ManagerColors.greyWhiteColor.withOpacity(0.7),
                  ),
                ),
                SizedBox(width: ManagerWidth.w4),
                Icon(
                  Icons.access_time_rounded,
                  size: ManagerFontSize.s12,
                  color: ManagerColors.greyWhiteColor.withOpacity(0.6),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ── Timeline dot (animated pulse for 'current' state) ─────────────────────

class _TimelineDot extends StatefulWidget {
  final OrderTrackingStepState state;
  final Color color;
  final IconData? icon;
  final double size;

  const _TimelineDot({
    required this.state,
    required this.color,
    this.icon,
    this.size = 36,
  });

  @override
  State<_TimelineDot> createState() => _TimelineDotState();
}

class _TimelineDotState extends State<_TimelineDot>
    with SingleTickerProviderStateMixin {
  AnimationController? _pulse;
  Animation<double>? _scale;
  Animation<double>? _ringOpacity;

  @override
  void initState() {
    super.initState();
    if (widget.state == OrderTrackingStepState.current) {
      _pulse = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1000),
      )..repeat(reverse: true);
      _scale = Tween<double>(begin: 1.0, end: 1.25).animate(
        CurvedAnimation(parent: _pulse!, curve: Curves.easeInOut),
      );
      _ringOpacity = Tween<double>(begin: 0.50, end: 0.08).animate(
        CurvedAnimation(parent: _pulse!, curve: Curves.easeInOut),
      );
    }
  }

  @override
  void dispose() {
    _pulse?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final color = widget.color;
    final icon = widget.icon;

    if (widget.state == OrderTrackingStepState.completed) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.30),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon ?? Icons.check_rounded,
          size: size * 0.5,
          color: ManagerColors.white,
        ),
      );
    }

    if (widget.state == OrderTrackingStepState.current) {
      return AnimatedBuilder(
        animation: _pulse!,
        builder: (_, __) => SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing outer ring
              Transform.scale(
                scale: _scale!.value,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: _ringOpacity!.value),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Solid inner dot
              Container(
                width: size * 0.70,
                height: size * 0.70,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  icon ?? Icons.location_on_rounded,
                  size: size * 0.38,
                  color: ManagerColors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ── Pending ──
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: kOdPendingDot,
        shape: BoxShape.circle,
      ),
      child: icon != null
          ? Icon(
              icon,
              size: size * 0.45,
              color: Colors.white.withValues(alpha: 0.7),
            )
          : null,
    );
  }
}

// ── Step badge ────────────────────────────────────────────────────────────

class _StepBadge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color textColor;

  const _StepBadge({
    required this.label,
    required this.bg,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w10,
        vertical: ManagerHeight.h4,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
      ),
      child: Text(
        label,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s10,
          color: textColor,
        ),
      ),
    );
  }
}
