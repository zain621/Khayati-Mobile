import 'package:app_mobile/core/extensions/extensions.dart';
import '../../domain/model/notification_model.dart';
import '../response/notification_response.dart';

extension NotificationItemMapper on NotificationItemResponse {
  NotificationModel toDomain() => NotificationModel(
        id: id ?? '',
        type: type.onNull(),
        title: title.onNull(),
        body: body.onNull(),
        isRead: isRead ?? false,
        createdAt: createdAt.onNull(),
        readAt: readAt,
        data: data,
      );
}

extension NotificationListMapper on NotificationListResponse {
  NotificationListModel toDomain() => NotificationListModel(
        items: data?.items?.map((i) => i.toDomain()).toList() ?? [],
        total: data?.total ?? 0,
      );
}
