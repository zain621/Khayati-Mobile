import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/network/app_api.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../../data/data_source/search_data_source.dart';
import '../../data/repository/search_repository.dart';
import '../../domain/repository/search_repository.dart';
import '../../domain/use_case/search_use_case.dart';
import '../../domain/use_case/get_search_history_use_case.dart';
import '../../domain/use_case/delete_search_history_item_use_case.dart';
import '../../domain/use_case/clear_search_history_use_case.dart';
import '../../presentation/controller/search_controller.dart';

void _initSearchDependencies() {
  if (!GetIt.I.isRegistered<SearchDataSource>()) {
    instance.registerLazySingleton<SearchDataSource>(
      () => SearchDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<SearchRepository>()) {
    instance.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImplement(
        instance<SearchDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<SearchUseCase>()) {
    instance.registerFactory<SearchUseCase>(
      () => SearchUseCase(instance<SearchRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetSearchHistoryUseCase>()) {
    instance.registerFactory<GetSearchHistoryUseCase>(
      () => GetSearchHistoryUseCase(instance<SearchRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<DeleteSearchHistoryItemUseCase>()) {
    instance.registerFactory<DeleteSearchHistoryItemUseCase>(
      () => DeleteSearchHistoryItemUseCase(instance<SearchRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ClearSearchHistoryUseCase>()) {
    instance.registerFactory<ClearSearchHistoryUseCase>(
      () => ClearSearchHistoryUseCase(instance<SearchRepository>()),
    );
  }
}

void _disposeSearchDependencies() {
  if (GetIt.I.isRegistered<ClearSearchHistoryUseCase>())
    instance.unregister<ClearSearchHistoryUseCase>();
  if (GetIt.I.isRegistered<DeleteSearchHistoryItemUseCase>())
    instance.unregister<DeleteSearchHistoryItemUseCase>();
  if (GetIt.I.isRegistered<GetSearchHistoryUseCase>())
    instance.unregister<GetSearchHistoryUseCase>();
  if (GetIt.I.isRegistered<SearchUseCase>())
    instance.unregister<SearchUseCase>();
  if (GetIt.I.isRegistered<SearchRepository>())
    instance.unregister<SearchRepository>();
  if (GetIt.I.isRegistered<SearchDataSource>())
    instance.unregister<SearchDataSource>();
}

void initSearch() {
  _initSearchDependencies();
  if (!Get.isRegistered<SearchController>()) {
    Get.put(
      SearchController(
        instance<SearchUseCase>(),
        instance<GetSearchHistoryUseCase>(),
        instance<DeleteSearchHistoryItemUseCase>(),
        instance<ClearSearchHistoryUseCase>(),
      ),
    );
  }
}

void disposeSearch() {
  _disposeSearchDependencies();
  Get.delete<SearchController>();
}
