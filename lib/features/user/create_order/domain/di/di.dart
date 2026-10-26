import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/create_order_data_source.dart';
import '../../data/repository/create_order_repository.dart';
import '../../presentation/controller/create_order_controller.dart';
import '../use_case/create_order_use_case.dart';

// ── Request-layer singletons ──────────────────────────────────────────────────

void initCreateOrderRequest() {
  if (!GetIt.I.isRegistered<CreateOrderDataSource>()) {
    instance.registerLazySingleton<CreateOrderDataSource>(
      () => CreateOrderDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<CreateOrderRepository>()) {
    instance.registerLazySingleton<CreateOrderRepository>(
      () => CreateOrderRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<CreateOrderUseCase>()) {
    instance.registerFactory<CreateOrderUseCase>(
      () => CreateOrderUseCase(instance<CreateOrderRepository>()),
    );
  }
}

void disposeCreateOrderRequest() {
  if (GetIt.I.isRegistered<CreateOrderUseCase>())
    instance.unregister<CreateOrderUseCase>();
  if (GetIt.I.isRegistered<CreateOrderRepository>())
    instance.unregister<CreateOrderRepository>();
  if (GetIt.I.isRegistered<CreateOrderDataSource>())
    instance.unregister<CreateOrderDataSource>();
}

// ── Feature lifecycle ─────────────────────────────────────────────────────────

void initCreateOrder() {
  initCreateOrderRequest();
  Get.put(CreateOrderController(instance<CreateOrderUseCase>()));
}

void disposeCreateOrder() {
  disposeCreateOrderRequest();
  Get.delete<CreateOrderController>();
}
