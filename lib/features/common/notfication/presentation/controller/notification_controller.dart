import 'package:get/get.dart';
import '../../../../../core/service/notification_navigator.dart';
import '../../../../../core/util/app_snack_bar.dart';
import '../../domain/model/notification_model.dart';
import '../../domain/use_case/get_notifications_use_case.dart';
import '../../domain/use_case/mark_notification_read_use_case.dart';

class NotificationController extends GetxController {
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkNotificationReadUseCase _markAsReadUseCase;

  NotificationController(
    this._getNotificationsUseCase,
    this._markAsReadUseCase,
  );

  // ── State ──────────────────────────────────────────────────────────────────

  static const int _pageSize = 20;

  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isFirstLoad = true.obs;
  final RxBool isRefreshing = false.obs;
  int _offset = 0;

  // ── Lifecycle ──────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // ── Fetch ──────────────────────────────────────────────────────────────────

  Future<void> fetchNotifications() async {
    isFirstLoad.value = true;
    _offset = 0;

    final result = await _getNotificationsUseCase.execute(
      GetNotificationsParams(limit: _pageSize, offset: _offset),
    );

    result.fold(
      (failure) {
        isFirstLoad.value = false;
        AppSnackbar.error(failure.message);
      },
      (data) {
        notifications.assignAll(data.items);
        isFirstLoad.value = false;
      },
    );
  }

  // ── Pull-to-refresh ────────────────────────────────────────────────────────

  Future<void> refreshNotifications() async {
    isRefreshing.value = true;
    _offset = 0;

    final result = await _getNotificationsUseCase.execute(
      GetNotificationsParams(limit: _pageSize, offset: _offset),
    );

    result.fold(
      (failure) {
        isRefreshing.value = false;
        AppSnackbar.error(failure.message);
      },
      (data) {
        notifications.assignAll(data.items);
        isRefreshing.value = false;
      },
    );
  }

  // ── Mark as read + deep link ───────────────────────────────────────────────

  Future<void> onNotificationTap(NotificationModel notification) async {
    await markAsRead(notification.id);
    final data = <String, dynamic>{
      'type': notification.type,
      ...?notification.data,
    };
    NotificationNavigator.openFromData(data);
  }

  Future<void> markAsRead(String notificationId) async {
    // Optimistically update local state immediately
    final index = notifications.indexWhere((n) => n.id == notificationId);
    if (index == -1) return;
    if (notifications[index].isRead) {
      // still allow navigation for already-read items via onNotificationTap
      return;
    }

    notifications[index] = notifications[index].copyWith(isRead: true);
    notifications.refresh();

    final result = await _markAsReadUseCase.execute(notificationId);
    result.fold(
      (failure) {
        // Revert on error
        notifications[index] = notifications[index].copyWith(isRead: false);
        notifications.refresh();
        AppSnackbar.error(failure.message);
      },
      (_) {},
    );
  }
}
