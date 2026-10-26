import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// ── Create Order App Bar
// ── Shows title, dynamic subtitle, progress steps, and decorative icon.
// ═══════════════════════════════════════════════════════════════════════════════

class CreateOrderAppBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onBackPressed;

  const CreateOrderAppBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ManagerColors.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
        bottom: ManagerHeight.h16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ManagerHeight.h12),

          // ── Title row ──────────────────────────────────────────────────
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: onBackPressed,
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

              SizedBox(width: ManagerWidth.w12),

              // Title & subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ManagerStrings.createOrderTitle,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.white,
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h2),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        currentPage == 0
                            ? ManagerStrings.createOrderSubtitlePage1
                            : ManagerStrings.createOrderSubtitlePage2,
                        key: ValueKey(currentPage),
                        style: getRegularTextStyle(
                          fontSize: ManagerFontSize.s11,
                          color: ManagerColors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Decorative icon
              Container(
                width: ManagerWidth.w40,
                height: ManagerHeight.h40,
                decoration: BoxDecoration(
                  color: ManagerColors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                ),
                child: Icon(
                  currentPage == 0
                      ? Icons.checkroom_rounded
                      : Icons.attach_money_rounded,
                  color: ManagerColors.white,
                  size: ManagerWidth.w22,
                ),
              ),
            ],
          ),

          SizedBox(height: ManagerHeight.h16),

          // ── Progress bar ────────────────────────────────────────────────
          Row(
            children: List.generate(totalPages, (index) {
              final isActive = index <= currentPage;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    height: ManagerHeight.h4,
                    decoration: BoxDecoration(
                      color: isActive
                          ? ManagerColors.white
                          : ManagerColors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(ManagerRadius.r4),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
