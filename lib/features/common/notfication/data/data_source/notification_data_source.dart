import '../../../../../core/network/app_api.dart';
import '../response/notification_response.dart';

abstract class NotificationDataSource {
  Future<NotificationListResponse> getNotifications(int limit, int offset);
  Future<MarkNotificationReadResponse> markAsRead(String notificationId);
}

class NotificationDataSourceImpl implements NotificationDataSource {
  final AppService _appService;

  NotificationDataSourceImpl(this._appService);

  @override
  Future<NotificationListResponse> getNotifications(
      int limit, int offset) async {
    return await _appService.getMyNotifications(limit, offset);
  }

  @override
  Future<MarkNotificationReadResponse> markAsRead(
      String notificationId) async {
    return await _appService.markNotificationAsRead(notificationId);
  }
}
