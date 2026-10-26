import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/order_tracking_data_source.dart';
import '../../data/repository/order_tracking_repository.dart';
import '../../presentation/controller/order_tracking_controller.dart';
import '../use_case/get_order_tracking_use_case.dart';
import '../use_case/get_order_tracking_detail_use_case.dart';
import '../use_case/update_order_tracking_status_use_case.dart';

void _initOrderTrackingDeps() {
  if (!GetIt.I.isRegistered<OrderTrackingDataSource>()) {
    instance.registerLazySingleton<OrderTrackingDataSource>(
      () => OrderTrackingDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<OrderTrackingRepository>()) {
    instance.registerLazySingleton<OrderTrackingRepository>(
      () => OrderTrackingRepositoryImplement(instance<OrderTrackingDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetOrderTrackingUseCase>()) {
    instance.registerFactory<GetOrderTrackingUseCase>(
      () => GetOrderTrackingUseCase(instance<OrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateOrderTrackingStatusUseCase>()) {
    instance.registerFactory<UpdateOrderTrackingStatusUseCase>(
      () => UpdateOrderTrackingStatusUseCase(instance<OrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetOrderTrackingDetailUseCase>()) {
    instance.registerFactory<GetOrderTrackingDetailUseCase>(
      () => GetOrderTrackingDetailUseCase(instance<OrderTrackingRepository>()),
    );
  }
}

void _disposeOrderTrackingDeps() {
  if (GetIt.I.isRegistered<GetOrderTrackingDetailUseCase>()) {
    instance.unregister<GetOrderTrackingDetailUseCase>();
  }
  if (GetIt.I.isRegistered<UpdateOrderTrackingStatusUseCase>()) {
    instance.unregister<UpdateOrderTrackingStatusUseCase>();
  }
  if (GetIt.I.isRegistered<GetOrderTrackingUseCase>()) {
    instance.unregister<GetOrderTrackingUseCase>();
  }
  if (GetIt.I.isRegistered<OrderTrackingRepository>()) {
    instance.unregister<OrderTrackingRepository>();
  }
  if (GetIt.I.isRegistered<OrderTrackingDataSource>()) {
    instance.unregister<OrderTrackingDataSource>();
  }
}

void initOrderTracking({bool forceRefresh = false}) {
  _initOrderTrackingDeps();
  if (forceRefresh && Get.isRegistered<OrderTrackingController>()) {
    Get.delete<OrderTrackingController>(force: true);
  }
  if (!Get.isRegistered<OrderTrackingController>()) {
    Get.put(
      OrderTrackingController(
        instance<GetOrderTrackingUseCase>(),
        instance<GetOrderTrackingDetailUseCase>(),
        instance<UpdateOrderTrackingStatusUseCase>(),
      ),
    );
  }
}

void disposeOrderTracking() {
  _disposeOrderTrackingDeps();
  Get.delete<OrderTrackingController>(force: true);
}
