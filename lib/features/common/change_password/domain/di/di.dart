import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/change_password_data_source.dart';
import '../../data/repository/change_password_repository.dart';
import '../../domain/use_case/change_password_use_case.dart';
import '../../presentation/controller/change_password_controller.dart';

void _initChangePasswordDeps() {
  if (!GetIt.I.isRegistered<ChangePasswordDataSource>()) {
    instance.registerLazySingleton<ChangePasswordDataSource>(
      () => ChangePasswordDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ChangePasswordRepository>()) {
    instance.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepositoryImplement(
          instance<ChangePasswordDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<ChangePasswordUseCase>()) {
    instance.registerFactory<ChangePasswordUseCase>(
      () => ChangePasswordUseCase(instance<ChangePasswordRepository>()),
    );
  }
}

void _disposeChangePasswordDeps() {
  if (GetIt.I.isRegistered<ChangePasswordUseCase>()) {
    instance.unregister<ChangePasswordUseCase>();
  }
  if (GetIt.I.isRegistered<ChangePasswordRepository>()) {
    instance.unregister<ChangePasswordRepository>();
  }
  if (GetIt.I.isRegistered<ChangePasswordDataSource>()) {
    instance.unregister<ChangePasswordDataSource>();
  }
}

void initChangePassword() {
  _initChangePasswordDeps();
  if (!Get.isRegistered<ChangePasswordController>()) {
    Get.put(ChangePasswordController(
      changePasswordUseCase: instance<ChangePasswordUseCase>(),
    ));
  }
}

void disposeChangePassword() {
  if (Get.isRegistered<ChangePasswordController>()) {
    Get.delete<ChangePasswordController>();
  }
  _disposeChangePasswordDeps();
}
