import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/home_data_source.dart';
import '../../data/repository/home_repository.dart';
import '../../presentation/controller/home_user_controller.dart';
import '../use_case/get_home_use_case.dart';
import '../use_case/get_nearby_tailors_use_case.dart';

void _initHomeRequest() {
  if (!GetIt.I.isRegistered<HomeDataSource>()) {
    instance.registerLazySingleton<HomeDataSource>(
      () => HomeDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<HomeRepository>()) {
    instance.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImplement(
        instance<HomeDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetHomeUseCase>()) {
    instance.registerFactory<GetHomeUseCase>(
      () => GetHomeUseCase(instance<HomeRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetNearbyTailorsUseCase>()) {
    instance.registerFactory<GetNearbyTailorsUseCase>(
      () => GetNearbyTailorsUseCase(instance<HomeRepository>()),
    );
  }
}

void _disposeHomeRequest() {
  if (GetIt.I.isRegistered<GetHomeUseCase>())
    instance.unregister<GetHomeUseCase>();
  if (GetIt.I.isRegistered<GetNearbyTailorsUseCase>()) {
    instance.unregister<GetNearbyTailorsUseCase>();
  }
  if (GetIt.I.isRegistered<HomeRepository>())
    instance.unregister<HomeRepository>();
  if (GetIt.I.isRegistered<HomeDataSource>())
    instance.unregister<HomeDataSource>();
}

void initHomeUser({bool forceRefresh = false}) {
  _initHomeRequest();
  if (forceRefresh && Get.isRegistered<HomeUserController>()) {
    Get.delete<HomeUserController>(force: true);
  }
  if (!Get.isRegistered<HomeUserController>()) {
    Get.put(HomeUserController(
      instance<GetHomeUseCase>(),
      instance<GetNearbyTailorsUseCase>(),
      instance<AppSettingsPrefs>(),
    ));
  }
}

void disposeHomeUser() {
  _disposeHomeRequest();
  Get.delete<HomeUserController>();
}
