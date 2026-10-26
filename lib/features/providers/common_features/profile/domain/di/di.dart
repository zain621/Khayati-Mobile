import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/features/common/delete_account/domain/di/di.dart';
import 'package:app_mobile/features/common/logout/domain/di/di.dart';
import '../../data/data_source/provider_profile_data_source.dart';
import '../../data/data_source/portfolio_data_source.dart';
import '../../data/data_source/update_provider_profile_data_source.dart';
import '../../data/repository/provider_profile_repository.dart';
import '../../data/repository/portfolio_repository.dart';
import '../../data/repository/update_provider_profile_repository.dart';
import '../../presentation/controller/provider_profile_controller.dart';
import '../../presentation/controller/portfolio_controller.dart';
import '../../presentation/controller/update_provider_profile_controller.dart';
import '../use_case/provider_profile_use_case.dart';
import '../use_case/add_portfolio_images_use_case.dart';
import '../use_case/delete_portfolio_image_use_case.dart';
import '../use_case/add_specialization_use_case.dart';
import '../use_case/delete_specialization_use_case.dart';
import '../use_case/update_tailor_profile_use_case.dart';
import '../use_case/update_shop_profile_use_case.dart';

void initProviderProfileRequest() {
  if (!GetIt.I.isRegistered<ProviderProfileDataSource>()) {
    instance.registerLazySingleton<ProviderProfileDataSource>(
      () => ProviderProfileDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<ProviderProfileRepository>()) {
    instance.registerLazySingleton<ProviderProfileRepository>(
      () => ProviderProfileRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<ProviderProfileUseCase>()) {
    instance.registerFactory<ProviderProfileUseCase>(
      () => ProviderProfileUseCase(instance<ProviderProfileRepository>()),
    );
  }
}

void initPortfolioRequest() {
  if (!GetIt.I.isRegistered<PortfolioDataSource>()) {
    instance.registerLazySingleton<PortfolioDataSource>(
      () => PortfolioDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<PortfolioRepository>()) {
    instance.registerLazySingleton<PortfolioRepository>(
      () => PortfolioRepositoryImplement(
        instance<NetworkInfo>(),
        instance<PortfolioDataSource>(),
      ),
    );
  }
}

void disposeProviderProfileRequest() {
  if (GetIt.I.isRegistered<ProviderProfileUseCase>())
    instance.unregister<ProviderProfileUseCase>();
  if (GetIt.I.isRegistered<ProviderProfileRepository>())
    instance.unregister<ProviderProfileRepository>();
  if (GetIt.I.isRegistered<ProviderProfileDataSource>())
    instance.unregister<ProviderProfileDataSource>();
}

void disposePortfolioRequest() {
  if (GetIt.I.isRegistered<PortfolioRepository>())
    instance.unregister<PortfolioRepository>();
  if (GetIt.I.isRegistered<PortfolioDataSource>())
    instance.unregister<PortfolioDataSource>();
}

void initUpdateProviderProfileRequest() {
  if (!GetIt.I.isRegistered<UpdateProviderProfileDataSource>()) {
    instance.registerLazySingleton<UpdateProviderProfileDataSource>(
      () => UpdateProviderProfileDataSourceImplement(
        instance<AppService>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<UpdateProviderProfileRepository>()) {
    instance.registerLazySingleton<UpdateProviderProfileRepository>(
      () => UpdateProviderProfileRepositoryImplement(
        instance<NetworkInfo>(),
        instance<UpdateProviderProfileDataSource>(),
      ),
    );
  }
}

void disposeUpdateProviderProfileRequest() {
  if (GetIt.I.isRegistered<UpdateProviderProfileRepository>())
    instance.unregister<UpdateProviderProfileRepository>();
  if (GetIt.I.isRegistered<UpdateProviderProfileDataSource>())
    instance.unregister<UpdateProviderProfileDataSource>();
}

void initUpdateProviderProfile() {
  Get.put(
    UpdateProviderProfileController(
      UpdateTailorProfileUseCase(
          instance<UpdateProviderProfileRepository>()),
      UpdateShopProfileUseCase(
          instance<UpdateProviderProfileRepository>()),
      instance<AppSettingsPrefs>(),
    ),
  );
}

void disposeUpdateProviderProfile() {
  if (Get.isRegistered<UpdateProviderProfileController>())
    Get.delete<UpdateProviderProfileController>();
}

void initProviderProfile({bool forceRefresh = false}) {
  initProviderProfileRequest();
  initPortfolioRequest();
  initUpdateProviderProfileRequest();

  if (forceRefresh) {
    if (Get.isRegistered<PortfolioController>()) {
      Get.delete<PortfolioController>(force: true);
    }
    if (Get.isRegistered<ProviderProfileController>()) {
      Get.delete<ProviderProfileController>(force: true);
    }
  }

  if (!Get.isRegistered<ProviderProfileController>()) {
    Get.put(ProviderProfileController(
      instance<ProviderProfileUseCase>(),
      getLogoutUseCase(),
      getDeleteAccountUseCase(),
    ));
  }

  if (!Get.isRegistered<PortfolioController>()) {
    Get.put(PortfolioController(
      AddPortfolioImagesUseCase(instance<PortfolioRepository>()),
      DeletePortfolioImageUseCase(instance<PortfolioRepository>()),
      AddSpecializationUseCase(instance<PortfolioRepository>()),
      DeleteSpecializationUseCase(instance<PortfolioRepository>()),
      Get.find<ProviderProfileController>(),
    ));
  }
}

void disposeProviderProfile() {
  disposeUpdateProviderProfileRequest();
  disposePortfolioRequest();
  disposeProviderProfileRequest();
  if (Get.isRegistered<UpdateProviderProfileController>())
    Get.delete<UpdateProviderProfileController>();
  Get.delete<PortfolioController>();
  Get.delete<ProviderProfileController>();
}
