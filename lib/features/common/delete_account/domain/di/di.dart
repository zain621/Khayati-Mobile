import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import '../../data/data_source/delete_account_data_source.dart';
import '../../data/repository/delete_account_repository.dart';
import '../use_case/delete_account_use_case.dart';

void _initDeleteAccountModule() {
  if (!GetIt.I.isRegistered<DeleteAccountDataSource>()) {
    instance.registerLazySingleton<DeleteAccountDataSource>(
      () => DeleteAccountDataSourceImpl(instance<Dio>()),
    );
  }
  if (!GetIt.I.isRegistered<DeleteAccountRepository>()) {
    instance.registerLazySingleton<DeleteAccountRepository>(
      () => DeleteAccountRepositoryImpl(instance<DeleteAccountDataSource>()),
    );
  }
}

/// Returns a fresh [DeleteAccountUseCase], initializing the module once.
DeleteAccountUseCase getDeleteAccountUseCase() {
  _initDeleteAccountModule();
  return DeleteAccountUseCase(instance<DeleteAccountRepository>());
}
