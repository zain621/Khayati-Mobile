import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/features/user/home_user/presentation/controller/home_user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Map preview on the user home screen.
///
/// A live [GoogleMap] cannot live here: home stays mounted in an
/// [IndexedStack], and that platform view aborts Dio ("no internet") on
/// every tab. The interactive map opens on expand / tap instead.
class HomeMapCardWidget extends StatelessWidget {
  final HomeUserController controller;
  final VoidCallback? onRefresh;
  final VoidCallback? onExpandTap;
  final double? mapHeight;

  const HomeMapCardWidget({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onExpandTap,
    this.mapHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double resolvedMapHeight = mapHeight ?? ManagerHeight.h200;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            GestureDetector(
              onTap: onExpandTap,
              child: SizedBox(
                height: resolvedMapHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const ColoredBox(color: Color(0xFFE8F0E6)),
                    CustomPaint(painter: _MapGridPainter()),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on_rounded,
                            size: ManagerWidth.w48,
                            color: ManagerColors.primaryColor,
                          ),
                          SizedBox(height: ManagerHeight.h8),
                          Obx(() {
                            final count =
                                controller.availableTailorsCount.value;
                            return Text(
                              '$count ${ManagerStrings.homeMapTailorCountSuffix}',
                              style: getMediumTextStyle(
                                fontSize: ManagerFontSize.s12,
                                color: ManagerColors.black,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ManagerWidth.w14,
        vertical: ManagerHeight.h12,
      ),
      color: ManagerColors.primaryColor,
      child: Row(
        children: [
          _LocationIconBox(),
          SizedBox(width: ManagerWidth.w12),
          Expanded(
            child: Obx(() {
              final count = controller.availableTailorsCount.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ManagerStrings.homeMapAvailableTailorsTitle,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.white,
                    ),
                  ),
                  SizedBox(height: ManagerHeight.h2),
                  Text(
                    '$count ${ManagerStrings.homeMapTailorCountSuffix}',
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s12,
                      color: ManagerColors.white.withOpacity(0.85),
                    ),
                  ),
                ],
              );
            }),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderActionButton(
                icon: Icons.open_in_full_rounded,
                onTap: onExpandTap,
              ),
              SizedBox(width: ManagerWidth.w8),
              _HeaderActionButton(
                icon: Icons.refresh_rounded,
                onTap: onRefresh,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFC5D5C2)
      ..strokeWidth = 1;
    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LocationIconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ManagerWidth.w42,
      height: ManagerHeight.h42,
      decoration: BoxDecoration(
        color: ManagerColors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(ManagerRadius.r12),
      ),
      child: Icon(
        Icons.location_on_rounded,
        color: ManagerColors.white,
        size: ManagerWidth.w24,
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderActionButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ManagerWidth.w38,
        height: ManagerHeight.h38,
        decoration: BoxDecoration(
          color: ManagerColors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(ManagerRadius.r10),
        ),
        child: Icon(
          icon,
          color: ManagerColors.white,
          size: ManagerWidth.w22,
        ),
      ),
    );
  }
}
