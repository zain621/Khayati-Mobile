import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../../data/data_source/loyalty_data_source.dart';
import '../../data/repository/loyalty_repository.dart';
import '../../domain/use_case/get_loyalty_points_use_case.dart';
import '../../domain/use_case/get_loyalty_rewards_use_case.dart';
import '../../domain/use_case/redeem_loyalty_use_case.dart';
import '../../domain/use_case/get_unused_codes_use_case.dart';
import '../../presentation/controller/loyalty_controller.dart';

void _initLoyaltyRequest() {
  if (!GetIt.I.isRegistered<LoyaltyDataSource>()) {
    instance.registerLazySingleton<LoyaltyDataSource>(
      () => LoyaltyDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<LoyaltyRepository>()) {
    instance.registerLazySingleton<LoyaltyRepository>(
      () => LoyaltyRepositoryImplement(
        instance<LoyaltyDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetLoyaltyPointsUseCase>()) {
    instance.registerFactory<GetLoyaltyPointsUseCase>(
      () => GetLoyaltyPointsUseCase(instance<LoyaltyRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetLoyaltyRewardsUseCase>()) {
    instance.registerFactory<GetLoyaltyRewardsUseCase>(
      () => GetLoyaltyRewardsUseCase(instance<LoyaltyRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<RedeemLoyaltyUseCase>()) {
    instance.registerFactory<RedeemLoyaltyUseCase>(
      () => RedeemLoyaltyUseCase(instance<LoyaltyRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetUnusedCodesUseCase>()) {
    instance.registerFactory<GetUnusedCodesUseCase>(
      () => GetUnusedCodesUseCase(instance<LoyaltyRepository>()),
    );
  }
}

void _disposeLoyaltyRequest() {
  if (GetIt.I.isRegistered<GetUnusedCodesUseCase>())
    instance.unregister<GetUnusedCodesUseCase>();
  if (GetIt.I.isRegistered<RedeemLoyaltyUseCase>())
    instance.unregister<RedeemLoyaltyUseCase>();
  if (GetIt.I.isRegistered<GetLoyaltyRewardsUseCase>())
    instance.unregister<GetLoyaltyRewardsUseCase>();
  if (GetIt.I.isRegistered<GetLoyaltyPointsUseCase>())
    instance.unregister<GetLoyaltyPointsUseCase>();
  if (GetIt.I.isRegistered<LoyaltyRepository>())
    instance.unregister<LoyaltyRepository>();
  if (GetIt.I.isRegistered<LoyaltyDataSource>())
    instance.unregister<LoyaltyDataSource>();
}

void initLoyalty({bool forceRefresh = false}) {
  _initLoyaltyRequest();
  if (forceRefresh && Get.isRegistered<LoyaltyController>()) {
    Get.delete<LoyaltyController>(force: true);
  }
  if (!Get.isRegistered<LoyaltyController>()) {
    Get.put(
      LoyaltyController(
        instance<GetLoyaltyPointsUseCase>(),
        instance<GetLoyaltyRewardsUseCase>(),
        instance<RedeemLoyaltyUseCase>(),
        instance<GetUnusedCodesUseCase>(),
      ),
    );
  }
}

void disposeLoyalty() {
  _disposeLoyaltyRequest();
  Get.delete<LoyaltyController>();
}
