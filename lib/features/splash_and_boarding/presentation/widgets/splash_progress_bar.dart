import 'package:flutter/material.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_width.dart';

/// Dashed track + sliding fill — same motif as the HTML splash mock,
/// using the app's existing primary/secondary colors.
class SplashProgressBar extends StatefulWidget {
  const SplashProgressBar({super.key});

  @override
  State<SplashProgressBar> createState() => _SplashProgressBarState();
}

class _SplashProgressBarState extends State<SplashProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fill;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
    _fill = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.8, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = ManagerWidth.w110;
    final height = ManagerHeight.h14;
    const accent = ManagerColors.secondaryColor;

    return SizedBox(
      width: width,
      height: height,
      child: AnimatedBuilder(
        animation: _fill,
        builder: (context, _) {
          return CustomPaint(
            size: Size(width, height),
            painter: _DashedProgressPainter(
              progress: _fill.value,
              accent: accent,
              fill: accent.withValues(alpha: 0.35),
            ),
          );
        },
      ),
    );
  }
}

class _DashedProgressPainter extends CustomPainter {
  final double progress;
  final Color accent;
  final Color fill;

  _DashedProgressPainter({
    required this.progress,
    required this.accent,
    required this.fill,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(2));

    // Track background (transparent dashes feel)
    final dashPaint = Paint()
      ..color = accent
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, dashPaint);

    // Vertical dash marks across the track
    const gap = 4.0;
    const dash = 1.0;
    double x = 4;
    final markPaint = Paint()
      ..color = accent
      ..strokeWidth = 1;
    while (x < size.width - 4) {
      canvas.drawLine(
        Offset(x, 2),
        Offset(x, size.height - 2),
        markPaint,
      );
      x += gap + dash;
    }

    // Fill sweep
    final fillWidth = (size.width * progress).clamp(0.0, size.width);
    if (fillWidth > 0) {
      final fillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, fillWidth, size.height),
        const Radius.circular(2),
      );
      canvas.drawRRect(fillRect, Paint()..color = fill);

      // Leading edge accent
      canvas.drawRect(
        Rect.fromLTWH(fillWidth - 2, 0, 2, size.height),
        Paint()..color = accent,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedProgressPainter oldDelegate) =>
      oldDelegate.progress != progress ||
      oldDelegate.accent != accent ||
      oldDelegate.fill != fill;
}
