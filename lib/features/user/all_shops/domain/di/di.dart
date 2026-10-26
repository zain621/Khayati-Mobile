import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/features/user/all_shops/data/data_source/all_shops_data_source.dart';
import 'package:app_mobile/features/user/all_shops/data/repository/all_shops_repository.dart';
import 'package:app_mobile/features/user/all_shops/domain/use_case/get_all_shops_use_case.dart';
import 'package:app_mobile/features/user/all_shops/presentation/controller/all_shops_controller.dart';

void initAllShops() {
  if (!GetIt.I.isRegistered<AllShopsDataSource>()) {
    instance.registerLazySingleton<AllShopsDataSource>(
      () => AllShopsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<AllShopsRepository>()) {
    instance.registerLazySingleton<AllShopsRepository>(
      () => AllShopsRepositoryImplement(
        instance<AllShopsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetAllShopsUseCase>()) {
    instance.registerFactory<GetAllShopsUseCase>(
      () => GetAllShopsUseCase(instance<AllShopsRepository>()),
    );
  }
  if (!Get.isRegistered<AllShopsController>()) {
    Get.put(AllShopsController(instance<GetAllShopsUseCase>()));
  }
}

void disposeAllShops() {
  if (GetIt.I.isRegistered<GetAllShopsUseCase>())
    instance.unregister<GetAllShopsUseCase>();
  if (GetIt.I.isRegistered<AllShopsRepository>())
    instance.unregister<AllShopsRepository>();
  if (GetIt.I.isRegistered<AllShopsDataSource>())
    instance.unregister<AllShopsDataSource>();
  if (Get.isRegistered<AllShopsController>()) Get.delete<AllShopsController>();
}
