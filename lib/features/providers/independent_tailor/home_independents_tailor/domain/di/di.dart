import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/independent_tailor_home_data_source.dart';
import '../../data/repository/independent_tailor_home_repository.dart';
import '../../presentation/controller/independent_tailor_home_controller.dart';
import '../use_case/get_independent_tailor_home_use_case.dart';
import '../use_case/change_independent_tailor_availability_use_case.dart';

void _initIndependentTailorHomeDeps() {
  if (!GetIt.I.isRegistered<IndependentTailorHomeDataSource>()) {
    instance.registerLazySingleton<IndependentTailorHomeDataSource>(
      () => IndependentTailorHomeDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<IndependentTailorHomeRepository>()) {
    instance.registerLazySingleton<IndependentTailorHomeRepository>(
      () => IndependentTailorHomeRepositoryImplement(
        instance<IndependentTailorHomeDataSource>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetIndependentTailorHomeUseCase>()) {
    instance.registerFactory<GetIndependentTailorHomeUseCase>(
      () => GetIndependentTailorHomeUseCase(
        instance<IndependentTailorHomeRepository>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<ChangeIndependentTailorAvailabilityUseCase>()) {
    instance.registerFactory<ChangeIndependentTailorAvailabilityUseCase>(
      () => ChangeIndependentTailorAvailabilityUseCase(
        instance<IndependentTailorHomeRepository>(),
      ),
    );
  }
}

void _disposeIndependentTailorHomeDeps() {
  if (GetIt.I.isRegistered<ChangeIndependentTailorAvailabilityUseCase>())
    instance.unregister<ChangeIndependentTailorAvailabilityUseCase>();
  if (GetIt.I.isRegistered<GetIndependentTailorHomeUseCase>())
    instance.unregister<GetIndependentTailorHomeUseCase>();
  if (GetIt.I.isRegistered<IndependentTailorHomeRepository>())
    instance.unregister<IndependentTailorHomeRepository>();
  if (GetIt.I.isRegistered<IndependentTailorHomeDataSource>())
    instance.unregister<IndependentTailorHomeDataSource>();
}

void initIndependentTailorHome({bool forceRefresh = false}) {
  _initIndependentTailorHomeDeps();
  if (forceRefresh && Get.isRegistered<IndependentTailorHomeController>()) {
    Get.delete<IndependentTailorHomeController>(force: true);
  }
  if (!Get.isRegistered<IndependentTailorHomeController>()) {
    Get.put(
      IndependentTailorHomeController(
        instance<GetIndependentTailorHomeUseCase>(),
        instance<ChangeIndependentTailorAvailabilityUseCase>(),
      ),
    );
  }
}

void disposeIndependentTailorHome() {
  _disposeIndependentTailorHomeDeps();
  Get.delete<IndependentTailorHomeController>(force: true);
}
