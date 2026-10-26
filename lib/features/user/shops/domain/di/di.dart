import 'package:app_mobile/features/user/shops/data/data_source/shops_data_source.dart';
import 'package:app_mobile/features/user/shops/data/repository/shops_repository.dart';
import 'package:app_mobile/features/user/shops/domain/use_case/get_shops_use_case.dart';
import 'package:app_mobile/features/user/shops/domain/use_case/get_top_shops_use_case.dart';
import 'package:app_mobile/features/user/shops/presentation/controller/shops_controller.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/core/network/app_api.dart';


void initShops() {
  if (!GetIt.I.isRegistered<ShopsDataSource>()) {
    instance.registerLazySingleton<ShopsDataSource>(
      () => ShopsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ShopsRepository>()) {
    instance.registerLazySingleton<ShopsRepository>(
      () => ShopsRepositoryImplement(
        instance<ShopsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetShopsUseCase>()) {
    instance.registerFactory<GetShopsUseCase>(
      () => GetShopsUseCase(instance<ShopsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetTopShopsUseCase>()) {
    instance.registerFactory<GetTopShopsUseCase>(
      () => GetTopShopsUseCase(instance<ShopsRepository>()),
    );
  }
  Get.put(ShopsController(
    instance<GetShopsUseCase>(),
    instance<GetTopShopsUseCase>(),
  ));
}

void disposeShops() {
  if (GetIt.I.isRegistered<GetTopShopsUseCase>())
    instance.unregister<GetTopShopsUseCase>();
  if (GetIt.I.isRegistered<GetShopsUseCase>())
    instance.unregister<GetShopsUseCase>();
  if (GetIt.I.isRegistered<ShopsRepository>())
    instance.unregister<ShopsRepository>();
  if (GetIt.I.isRegistered<ShopsDataSource>())
    instance.unregister<ShopsDataSource>();
  Get.delete<ShopsController>();
}
