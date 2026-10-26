import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/features/user/all_products/data/data_source/all_products_data_source.dart';
import 'package:app_mobile/features/user/all_products/data/repository/all_products_repository.dart';
import 'package:app_mobile/features/user/all_products/domain/use_case/get_all_products_use_case.dart';
import 'package:app_mobile/features/user/all_products/presentation/controller/all_products_controller.dart';

void initAllProducts() {
  if (!GetIt.I.isRegistered<AllProductsDataSource>()) {
    instance.registerLazySingleton<AllProductsDataSource>(
      () => AllProductsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<AllProductsRepository>()) {
    instance.registerLazySingleton<AllProductsRepository>(
      () => AllProductsRepositoryImplement(
        instance<AllProductsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetAllProductsUseCase>()) {
    instance.registerFactory<GetAllProductsUseCase>(
      () => GetAllProductsUseCase(instance<AllProductsRepository>()),
    );
  }
  if (!Get.isRegistered<AllProductsController>()) {
    Get.put(AllProductsController(instance<GetAllProductsUseCase>()));
  }
}

void disposeAllProducts() {
  if (GetIt.I.isRegistered<GetAllProductsUseCase>())
    instance.unregister<GetAllProductsUseCase>();
  if (GetIt.I.isRegistered<AllProductsRepository>())
    instance.unregister<AllProductsRepository>();
  if (GetIt.I.isRegistered<AllProductsDataSource>())
    instance.unregister<AllProductsDataSource>();
  if (Get.isRegistered<AllProductsController>())
    Get.delete<AllProductsController>();
}
