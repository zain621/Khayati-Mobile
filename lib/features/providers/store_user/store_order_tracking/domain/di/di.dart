import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../constants/di/dependency_injection.dart';
import '../../../../../../core/network/app_api.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/di/di.dart'
    as chat_di;
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../data/data_source/shop_owner_orders_data_source.dart';
import '../../data/repository/shop_owner_orders_repository.dart';
import '../../presentation/controller/store_order_tracking_controller.dart';
import '../use_case/get_shop_owner_orders_use_case.dart';
import '../use_case/update_order_stage_use_case.dart';

void _initShopOwnerOrdersRequest() {
  if (!GetIt.I.isRegistered<ShopOwnerOrdersDataSource>()) {
    instance.registerLazySingleton<ShopOwnerOrdersDataSource>(
      () => ShopOwnerOrdersDataSourceImpl(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ShopOwnerOrdersRepository>()) {
    instance.registerLazySingleton<ShopOwnerOrdersRepository>(
      () => ShopOwnerOrdersRepositoryImpl(
        instance<ShopOwnerOrdersDataSource>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetShopOwnerOrdersUseCase>()) {
    instance.registerFactory<GetShopOwnerOrdersUseCase>(
      () => GetShopOwnerOrdersUseCase(instance<ShopOwnerOrdersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateOrderStageUseCase>()) {
    instance.registerFactory<UpdateOrderStageUseCase>(
      () => UpdateOrderStageUseCase(instance<ShopOwnerOrdersRepository>()),
    );
  }
}

void _disposeShopOwnerOrdersRequest() {
  if (GetIt.I.isRegistered<UpdateOrderStageUseCase>())
    instance.unregister<UpdateOrderStageUseCase>();
  if (GetIt.I.isRegistered<GetShopOwnerOrdersUseCase>())
    instance.unregister<GetShopOwnerOrdersUseCase>();
  if (GetIt.I.isRegistered<ShopOwnerOrdersRepository>())
    instance.unregister<ShopOwnerOrdersRepository>();
  if (GetIt.I.isRegistered<ShopOwnerOrdersDataSource>())
    instance.unregister<ShopOwnerOrdersDataSource>();
}

void initStoreOrderTracking({bool forceRefresh = false}) {
  _initShopOwnerOrdersRequest();
  chat_di.initProviderChat();
  if (forceRefresh && Get.isRegistered<StoreOrderTrackingController>()) {
    Get.delete<StoreOrderTrackingController>(force: true);
  }
  if (!Get.isRegistered<StoreOrderTrackingController>()) {
    Get.put(
      StoreOrderTrackingController(
        instance<GetShopOwnerOrdersUseCase>(),
        instance<UpdateOrderStageUseCase>(),
        instance<CreateConversationUseCase>(),
      ),
    );
  }
}

void disposeStoreOrderTracking() {
  if (Get.isRegistered<StoreOrderTrackingController>()) {
    Get.delete<StoreOrderTrackingController>();
  }
  _disposeShopOwnerOrdersRequest();
}
