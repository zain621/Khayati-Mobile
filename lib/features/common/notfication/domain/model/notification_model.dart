class NotificationModel {
  final String id;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final String createdAt;
  final String? readAt;
  final Map<String, dynamic>? data;

  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
    this.readAt,
    this.data,
  });

  NotificationModel copyWith({bool? isRead}) => NotificationModel(
        id: id,
        type: type,
        title: title,
        body: body,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt,
        readAt: readAt,
        data: data,
      );
}

class NotificationListModel {
  final List<NotificationModel> items;
  final int total;

  const NotificationListModel({required this.items, required this.total});
}
