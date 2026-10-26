import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/comprehensive_home_data_source.dart';
import '../../data/repository/comprehensive_home_repository.dart';
import '../../domain/use_case/get_comprehensive_home_use_case.dart';
import '../../domain/use_case/change_availability_use_case.dart';
import '../../presentation/controller/comprehensive_home_controller.dart';

void _initComprehensiveHomeDeps() {
  if (!GetIt.I.isRegistered<ComprehensiveHomeDataSource>()) {
    instance.registerLazySingleton<ComprehensiveHomeDataSource>(
      () => ComprehensiveHomeDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ComprehensiveHomeRepository>()) {
    instance.registerLazySingleton<ComprehensiveHomeRepository>(
      () => ComprehensiveHomeRepositoryImplement(
        instance<ComprehensiveHomeDataSource>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetComprehensiveHomeUseCase>()) {
    instance.registerFactory<GetComprehensiveHomeUseCase>(
      () => GetComprehensiveHomeUseCase(
        instance<ComprehensiveHomeRepository>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<ChangeAvailabilityUseCase>()) {
    instance.registerFactory<ChangeAvailabilityUseCase>(
      () => ChangeAvailabilityUseCase(
        instance<ComprehensiveHomeRepository>(),
      ),
    );
  }
}

void _disposeComprehensiveHomeDeps() {
  if (GetIt.I.isRegistered<ChangeAvailabilityUseCase>())
    instance.unregister<ChangeAvailabilityUseCase>();
  if (GetIt.I.isRegistered<GetComprehensiveHomeUseCase>())
    instance.unregister<GetComprehensiveHomeUseCase>();
  if (GetIt.I.isRegistered<ComprehensiveHomeRepository>())
    instance.unregister<ComprehensiveHomeRepository>();
  if (GetIt.I.isRegistered<ComprehensiveHomeDataSource>())
    instance.unregister<ComprehensiveHomeDataSource>();
}

void initComprehensiveHome({bool forceRefresh = false}) {
  _initComprehensiveHomeDeps();
  if (forceRefresh && Get.isRegistered<ComprehensiveHomeController>()) {
    Get.delete<ComprehensiveHomeController>(force: true);
  }
  if (!Get.isRegistered<ComprehensiveHomeController>()) {
    Get.put(
      ComprehensiveHomeController(
        instance<GetComprehensiveHomeUseCase>(),
        instance<ChangeAvailabilityUseCase>(),
      ),
    );
  }
}

void disposeComprehensiveHome() {
  _disposeComprehensiveHomeDeps();
  Get.delete<ComprehensiveHomeController>(force: true);
}
