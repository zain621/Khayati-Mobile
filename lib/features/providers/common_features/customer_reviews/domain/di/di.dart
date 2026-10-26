import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../../constants/di/dependency_injection.dart';
import '../../../../../../core/network/app_api.dart';
import '../../../../../../core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/customer_reviews_data_source.dart';
import '../../data/repository/customer_reviews_repository.dart';
import '../use_case/get_reviews_use_case.dart';
import '../../presentation/controller/customer_reviews_controller.dart';

void _initCustomerReviewsDeps() {
  if (!GetIt.I.isRegistered<CustomerReviewsDataSource>()) {
    instance.registerLazySingleton<CustomerReviewsDataSource>(
      () => CustomerReviewsDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<CustomerReviewsRepository>()) {
    instance.registerLazySingleton<CustomerReviewsRepository>(
      () => CustomerReviewsRepositoryImplement(
        instance(),
        instance(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetReviewsUseCase>()) {
    instance.registerFactory<GetReviewsUseCase>(
      () => GetReviewsUseCase(instance<CustomerReviewsRepository>()),
    );
  }
}

void _disposeCustomerReviewsDeps() {
  if (GetIt.I.isRegistered<GetReviewsUseCase>())
    instance.unregister<GetReviewsUseCase>();
  if (GetIt.I.isRegistered<CustomerReviewsRepository>())
    instance.unregister<CustomerReviewsRepository>();
  if (GetIt.I.isRegistered<CustomerReviewsDataSource>())
    instance.unregister<CustomerReviewsDataSource>();
}

void initCustomerReviews() {
  _initCustomerReviewsDeps();
  Get.put(CustomerReviewsController(instance<GetReviewsUseCase>()));
}

void disposeCustomerReviews() {
  _disposeCustomerReviewsDeps();
  Get.delete<CustomerReviewsController>();
}
