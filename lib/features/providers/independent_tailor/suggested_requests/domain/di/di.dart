import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/suggested_requests_data_source.dart';
import '../../data/repository/suggested_requests_repository.dart';
import '../../presentation/controller/suggested_requests_controller.dart';
import '../use_case/get_orders_use_case.dart';
import '../use_case/submit_offer_use_case.dart';

void _initSuggestedRequestsDeps() {
  if (!GetIt.I.isRegistered<SuggestedRequestsDataSource>()) {
    instance.registerLazySingleton<SuggestedRequestsDataSource>(
      () => SuggestedRequestsDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<SuggestedRequestsRepository>()) {
    instance.registerLazySingleton<SuggestedRequestsRepository>(
      () => SuggestedRequestsRepositoryImplement(
        instance(),
        instance(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetOrdersUseCase>()) {
    instance.registerFactory<GetOrdersUseCase>(
      () => GetOrdersUseCase(instance<SuggestedRequestsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<SubmitOfferUseCase>()) {
    instance.registerFactory<SubmitOfferUseCase>(
      () => SubmitOfferUseCase(instance<SuggestedRequestsRepository>()),
    );
  }
}

void _disposeSuggestedRequestsDeps() {
  if (GetIt.I.isRegistered<SubmitOfferUseCase>())
    instance.unregister<SubmitOfferUseCase>();
  if (GetIt.I.isRegistered<GetOrdersUseCase>())
    instance.unregister<GetOrdersUseCase>();
  if (GetIt.I.isRegistered<SuggestedRequestsRepository>())
    instance.unregister<SuggestedRequestsRepository>();
  if (GetIt.I.isRegistered<SuggestedRequestsDataSource>())
    instance.unregister<SuggestedRequestsDataSource>();
}

void initSuggestedRequests() {
  _initSuggestedRequestsDeps();
  Get.put(SuggestedRequestsController(
    instance<GetOrdersUseCase>(),
    instance<SubmitOfferUseCase>(),
  ));
}

void disposeSuggestedRequests() {
  _disposeSuggestedRequestsDeps();
  Get.delete<SuggestedRequestsController>();
}
