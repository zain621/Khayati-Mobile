import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/my_offers_data_source.dart';
import '../../data/repository/my_offers_repository.dart';
import '../../presentation/controller/my_offers_controller.dart';
import '../use_case/get_my_offers_use_case.dart';
import '../use_case/update_my_offer_use_case.dart';
import '../use_case/delete_my_offer_use_case.dart';
import '../use_case/get_order_detail_use_case.dart';

void _initMyOffersDeps() {
  if (!GetIt.I.isRegistered<MyOffersDataSource>()) {
    instance.registerLazySingleton<MyOffersDataSource>(
      () => MyOffersDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<MyOffersRepository>()) {
    instance.registerLazySingleton<MyOffersRepository>(
      () => MyOffersRepositoryImplement(instance<MyOffersDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetMyOffersUseCase>()) {
    instance.registerFactory<GetMyOffersUseCase>(
      () => GetMyOffersUseCase(instance<MyOffersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateMyOfferUseCase>()) {
    instance.registerFactory<UpdateMyOfferUseCase>(
      () => UpdateMyOfferUseCase(instance<MyOffersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<DeleteMyOfferUseCase>()) {
    instance.registerFactory<DeleteMyOfferUseCase>(
      () => DeleteMyOfferUseCase(instance<MyOffersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetOrderDetailUseCase>()) {
    instance.registerFactory<GetOrderDetailUseCase>(
      () => GetOrderDetailUseCase(instance<MyOffersRepository>()),
    );
  }
}

void _disposeMyOffersDeps() {
  if (GetIt.I.isRegistered<GetOrderDetailUseCase>())
    instance.unregister<GetOrderDetailUseCase>();
  if (GetIt.I.isRegistered<DeleteMyOfferUseCase>())
    instance.unregister<DeleteMyOfferUseCase>();
  if (GetIt.I.isRegistered<UpdateMyOfferUseCase>())
    instance.unregister<UpdateMyOfferUseCase>();
  if (GetIt.I.isRegistered<GetMyOffersUseCase>())
    instance.unregister<GetMyOffersUseCase>();
  if (GetIt.I.isRegistered<MyOffersRepository>())
    instance.unregister<MyOffersRepository>();
  if (GetIt.I.isRegistered<MyOffersDataSource>())
    instance.unregister<MyOffersDataSource>();
}

void initMyOffers() {
  _initMyOffersDeps();
  Get.put(MyOffersController(
    instance<GetMyOffersUseCase>(),
    instance<UpdateMyOfferUseCase>(),
    instance<DeleteMyOfferUseCase>(),
    instance<GetOrderDetailUseCase>(),
  ));
}

void disposeMyOffers() {
  _disposeMyOffersDeps();
  Get.delete<MyOffersController>();
}

