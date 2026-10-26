import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/shop_owner_home_data_source.dart';
import '../../data/repository/shop_owner_home_repository.dart';
import '../../presentation/controller/shop_owner_home_controller.dart';
import '../use_case/get_shop_owner_home_use_case.dart';
import '../use_case/change_shop_owner_availability_use_case.dart';

void _initShopOwnerHomeRequest() {
  if (!GetIt.I.isRegistered<ShopOwnerHomeDataSource>()) {
    instance.registerLazySingleton<ShopOwnerHomeDataSource>(
      () => ShopOwnerHomeDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ShopOwnerHomeRepository>()) {
    instance.registerLazySingleton<ShopOwnerHomeRepository>(
      () => ShopOwnerHomeRepositoryImplement(
        instance<ShopOwnerHomeDataSource>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetShopOwnerHomeUseCase>()) {
    instance.registerFactory<GetShopOwnerHomeUseCase>(
      () => GetShopOwnerHomeUseCase(instance<ShopOwnerHomeRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ChangeShopOwnerAvailabilityUseCase>()) {
    instance.registerFactory<ChangeShopOwnerAvailabilityUseCase>(
      () => ChangeShopOwnerAvailabilityUseCase(
          instance<ShopOwnerHomeRepository>()),
    );
  }
}

void _disposeShopOwnerHomeRequest() {
  if (GetIt.I.isRegistered<ChangeShopOwnerAvailabilityUseCase>())
    instance.unregister<ChangeShopOwnerAvailabilityUseCase>();
  if (GetIt.I.isRegistered<GetShopOwnerHomeUseCase>())
    instance.unregister<GetShopOwnerHomeUseCase>();
  if (GetIt.I.isRegistered<ShopOwnerHomeRepository>())
    instance.unregister<ShopOwnerHomeRepository>();
  if (GetIt.I.isRegistered<ShopOwnerHomeDataSource>())
    instance.unregister<ShopOwnerHomeDataSource>();
}

void initShopOwnerHome({bool forceRefresh = false}) {
  _initShopOwnerHomeRequest();
  if (forceRefresh && Get.isRegistered<ShopOwnerHomeController>()) {
    Get.delete<ShopOwnerHomeController>(force: true);
  }
  if (!Get.isRegistered<ShopOwnerHomeController>()) {
    Get.put(
      ShopOwnerHomeController(
        instance<GetShopOwnerHomeUseCase>(),
        instance<ChangeShopOwnerAvailabilityUseCase>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
}

void disposeShopOwnerHome() {
  if (Get.isRegistered<ShopOwnerHomeController>()) {
    Get.delete<ShopOwnerHomeController>(force: true);
  }
  _disposeShopOwnerHomeRequest();
}
