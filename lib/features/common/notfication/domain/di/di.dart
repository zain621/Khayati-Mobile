import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/network/app_api.dart';
import '../../data/data_source/notification_data_source.dart';
import '../../data/repository/notification_repository.dart';
import '../../presentation/controller/notification_controller.dart';
import '../use_case/get_notifications_use_case.dart';
import '../use_case/mark_notification_read_use_case.dart';

void _initNotificationDeps() {
  if (!GetIt.I.isRegistered<NotificationDataSource>()) {
    instance.registerLazySingleton<NotificationDataSource>(
      () => NotificationDataSourceImpl(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<NotificationRepository>()) {
    instance.registerLazySingleton<NotificationRepository>(
      () => NotificationRepositoryImpl(instance<NotificationDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetNotificationsUseCase>()) {
    instance.registerFactory<GetNotificationsUseCase>(
      () => GetNotificationsUseCase(instance<NotificationRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<MarkNotificationReadUseCase>()) {
    instance.registerFactory<MarkNotificationReadUseCase>(
      () => MarkNotificationReadUseCase(instance<NotificationRepository>()),
    );
  }
}

void _disposeNotificationDeps() {
  if (GetIt.I.isRegistered<MarkNotificationReadUseCase>())
    instance.unregister<MarkNotificationReadUseCase>();
  if (GetIt.I.isRegistered<GetNotificationsUseCase>())
    instance.unregister<GetNotificationsUseCase>();
  if (GetIt.I.isRegistered<NotificationRepository>())
    instance.unregister<NotificationRepository>();
  if (GetIt.I.isRegistered<NotificationDataSource>())
    instance.unregister<NotificationDataSource>();
}

void initNotifications() {
  _initNotificationDeps();
  if (!Get.isRegistered<NotificationController>()) {
    Get.put(
      NotificationController(
        instance<GetNotificationsUseCase>(),
        instance<MarkNotificationReadUseCase>(),
      ),
    );
  }
}

void disposeNotifications() {
  _disposeNotificationDeps();
  if (Get.isRegistered<NotificationController>()) {
    Get.delete<NotificationController>();
  }
}
