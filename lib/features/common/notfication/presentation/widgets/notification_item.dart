import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final VoidCallback? onTap;

  const NotificationItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Notification Icon
                    Container(
                      height: ManagerHeight.h40,
                      width: ManagerWidth.w40,
                      decoration: BoxDecoration(
                        color: ManagerColors.secondaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.notifications_outlined,
                          color: ManagerColors.secondaryColor,
                          size: ManagerWidth.w20,
                        ),
                      ),
                    ),

                    SizedBox(width: ManagerWidth.w12),

                    /// Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Title row: text + time on far end
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: getBoldTextStyle(
                                    fontSize: ManagerFontSize.s13,
                                    color: isRead
                                        ? ManagerColors.greyWhiteColor
                                        : ManagerColors.black,
                                  ),
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w8),
                              Text(
                                time,
                                style: getRegularTextStyle(
                                  fontSize: ManagerFontSize.s10,
                                  color: ManagerColors.greyWhiteColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: ManagerHeight.h4),

                          Text(
                            description,
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s11,
                              color: ManagerColors.greyWhiteColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h12),

                /// Dotted divider
                CustomPaint(
                  size: const Size(double.infinity, 1),
                  painter: _DottedLinePainter(
                    color: ManagerColors.greyWhiteColor.withOpacity(0.4),
                    dashLength: 5,
                    dashGapLength: 4,
                    lineThickness: 0.7,
                  ),
                ),
              ],
            ),

            /// Unread dot
            if (!isRead)
              Positioned(
                top: ManagerHeight.h12,
                left: 0,
                child: Container(
                  width: ManagerWidth.w8,
                  height: ManagerHeight.h8,
                  decoration: BoxDecoration(
                    color: ManagerColors.redNew,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Dotted Line Painter ───────────────────────────────────────────────────────

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double dashLength;
  final double dashGapLength;
  final double lineThickness;

  const _DottedLinePainter({
    required this.color,
    this.dashLength = 5,
    this.dashGapLength = 3,
    this.lineThickness = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = lineThickness;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset((startX + dashLength).clamp(0, size.width), 0),
        paint,
      );
      startX += dashLength + dashGapLength;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter old) =>
      old.color != color ||
      old.dashLength != dashLength ||
      old.dashGapLength != dashGapLength ||
      old.lineThickness != lineThickness;
}
