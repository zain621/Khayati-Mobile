import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import '../../data/data_source/logout_data_source.dart';
import '../../data/repository/logout_repository.dart';
import '../use_case/logout_use_case.dart';

void _initLogoutModule() {
  if (!GetIt.I.isRegistered<LogoutDataSource>()) {
    instance.registerLazySingleton<LogoutDataSource>(
      () => LogoutDataSourceImpl(instance<Dio>()),
    );
  }
  if (!GetIt.I.isRegistered<LogoutRepository>()) {
    instance.registerLazySingleton<LogoutRepository>(
      () => LogoutRepositoryImpl(instance<LogoutDataSource>()),
    );
  }
}

/// Returns a fresh [LogoutUseCase], initializing the module once.
LogoutUseCase getLogoutUseCase() {
  _initLogoutModule();
  return LogoutUseCase(instance<LogoutRepository>());
}
