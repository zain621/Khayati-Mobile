import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/network/app_api.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../../../../../core/storage/local/app_settings_prefs.dart';
import '../../../../providers/common_features/chat/data/data_source/chat_data_source.dart';
import '../../../../providers/common_features/chat/data/repository/chat_repository.dart';
import '../../../../providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../data/data_source/shop_details_data_source.dart';
import '../../data/repository/shop_details_repository.dart';
import '../../domain/use_case/get_shop_details_use_case.dart';
import '../../presentation/controller/shop_details_controller.dart';

void _initShopDetailsRequest() {
  if (!GetIt.I.isRegistered<ShopDetailsDataSource>()) {
    instance.registerLazySingleton<ShopDetailsDataSource>(
      () => ShopDetailsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ShopDetailsRepository>()) {
    instance.registerLazySingleton<ShopDetailsRepository>(
      () => ShopDetailsRepositoryImplement(
        instance<ShopDetailsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetShopDetailsUseCase>()) {
    instance.registerFactory<GetShopDetailsUseCase>(
      () => GetShopDetailsUseCase(instance<ShopDetailsRepository>()),
    );
  }
  // Chat data-layer deps needed for the contact/chat action
  if (!GetIt.I.isRegistered<ChatDataSource>()) {
    instance.registerLazySingleton<ChatDataSource>(
      () => ChatDataSourceImplement(instance<AppService>(), instance<Dio>()),
    );
  }
  if (!GetIt.I.isRegistered<ChatRepository>()) {
    instance.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplement(
        instance<ChatDataSource>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<CreateConversationUseCase>()) {
    instance.registerFactory<CreateConversationUseCase>(
      () => CreateConversationUseCase(instance<ChatRepository>()),
    );
  }
}

void _disposeShopDetailsRequest() {
  if (GetIt.I.isRegistered<GetShopDetailsUseCase>())
    instance.unregister<GetShopDetailsUseCase>();
  if (GetIt.I.isRegistered<ShopDetailsRepository>())
    instance.unregister<ShopDetailsRepository>();
  if (GetIt.I.isRegistered<ShopDetailsDataSource>())
    instance.unregister<ShopDetailsDataSource>();
}

void initShopDetails({required String shopId}) {
  _initShopDetailsRequest();
  if (!Get.isRegistered<ShopDetailsController>()) {
    Get.put(
      ShopDetailsController(
        instance<GetShopDetailsUseCase>(),
        shopId: shopId,
      ),
    );
  }
}

void disposeShopDetails() {
  _disposeShopDetailsRequest();
  Get.delete<ShopDetailsController>();
}
