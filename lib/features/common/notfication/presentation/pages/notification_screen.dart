import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/resources/manager_styles.dart'
    show getBoldTextStyle, getRegularTextStyle;
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/widgets/base_app_scaffold.dart';
import 'package:app_mobile/features/common/notfication/domain/di/di.dart';
import 'package:app_mobile/features/common/notfication/domain/model/notification_model.dart';
import 'package:app_mobile/features/common/notfication/presentation/controller/notification_controller.dart';
import 'package:app_mobile/features/common/notfication/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    initNotifications();
  }

  @override
  void dispose() {
    disposeNotifications();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();

    return BaseAppScaffold(
      title: ManagerStrings.notificationScreenTitle,
      subtitle: ManagerStrings.notificationScreenSubtitle,
      showBackButton: true,
      useScrollView: false,
      child: Obx(() {
        if (controller.isFirstLoad.value) {
          return const _NotificationShimmer();
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          color: ManagerColors.primaryColor,
          backgroundColor: ManagerColors.white,
          displacement: ManagerHeight.h18,
          child: controller.notifications.isEmpty
              ? const _NotificationRefreshViewport(
                  child: _NotificationEmptyState(),
                )
              : _NotificationList(
                  notifications: controller.notifications.toList(),
                  onTap: (n) => controller.onNotificationTap(n),
                ),
        );
      }),
    );
  }
}

class _NotificationRefreshViewport extends StatelessWidget {
  final Widget child;

  const _NotificationRefreshViewport({required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(
            parent: BouncingScrollPhysics(),
          ),
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Center(child: child),
          ),
        );
      },
    );
  }
}

// ─── Animated list ─────────────────────────────────────────────────────────────

class _NotificationList extends StatefulWidget {
  final List<NotificationModel> notifications;
  final void Function(NotificationModel notification) onTap;

  const _NotificationList({
    required this.notifications,
    required this.onTap,
  });

  @override
  State<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<_NotificationList>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  Animation<double> _itemFade(int index) {
    final start = (0.12 + index * 0.10).clamp(0.0, 0.85);
    final end = (start + 0.26).clamp(0.0, 1.0);
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _animController,
          curve: Interval(start, end, curve: Curves.easeOut)),
    );
  }

  Animation<Offset> _itemSlide(int index) {
    final start = (0.12 + index * 0.10).clamp(0.0, 0.85);
    final end = (start + 0.26).clamp(0.0, 1.0);
    return Tween<Offset>(
      begin: const Offset(0, 0.18),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
          parent: _animController,
          curve: Interval(start, end, curve: Curves.easeOutCubic)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, _) => ListView.builder(
        padding: EdgeInsets.only(
          left: ManagerWidth.w16,
          right: ManagerWidth.w16,
          top: ManagerHeight.h8,
          bottom: ManagerHeight.h24,
        ),
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: widget.notifications.length,
        itemBuilder: (context, index) {
          final n = widget.notifications[index];
          return FadeTransition(
            opacity: _itemFade(index),
            child: SlideTransition(
              position: _itemSlide(index),
              child: NotificationItem(
                title: n.title,
                description: n.body,
                time: _formatTime(n.createdAt),
                isRead: n.isRead,
                onTap: () => widget.onTap(n),
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      final diff = DateTime.now().difference(dt);
      if (diff.inMinutes < 1) return ManagerStrings.now;
      if (diff.inMinutes < 60) {
        return '${diff.inMinutes} ${ManagerStrings.minutesShort}';
      }
      if (diff.inHours < 24) {
        return '${diff.inHours} ${ManagerStrings.hoursShort}';
      }
      if (diff.inDays < 7) {
        return '${diff.inDays} ${ManagerStrings.daysShort}';
      }
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return isoDate;
    }
  }
}

// ─── Shimmer ───────────────────────────────────────────────────────────────────

class _NotificationShimmer extends StatelessWidget {
  const _NotificationShimmer();

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ManagerColors.greyWhiteColor.withOpacity(0.15),
      highlightColor: ManagerColors.greyWhiteColor.withOpacity(0.05),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w16,
          vertical: ManagerHeight.h8,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 8,
        itemBuilder: (_, __) => Padding(
          padding: EdgeInsets.symmetric(vertical: ManagerHeight.h8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: ManagerHeight.h40,
                width: ManagerWidth.w40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: ManagerWidth.w12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ManagerHeight.h14,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h6),
                    Container(
                      height: ManagerHeight.h12,
                      width: ManagerWidth.w200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    SizedBox(height: ManagerHeight.h6),
                    Container(
                      height: ManagerHeight.h12,
                      width: ManagerWidth.w100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Empty state ───────────────────────────────────────────────────────────────

class _NotificationEmptyState extends StatelessWidget {
  const _NotificationEmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.notifications_off_outlined,
          size: ManagerWidth.w64,
          color: ManagerColors.greyWhiteColor,
        ),
        SizedBox(height: ManagerHeight.h16),
        Text(
          ManagerStrings.notificationNoNotifications,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s18,
            color: ManagerColors.black,
          ),
        ),
        SizedBox(height: ManagerHeight.h8),
        Text(
          ManagerStrings.notificationNoNotificationsDescription,
          style: getRegularTextStyle(
            fontSize: ManagerFontSize.s14,
            color: ManagerColors.greyWhiteColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
