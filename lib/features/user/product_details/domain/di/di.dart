import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/features/providers/common_features/chat/data/data_source/chat_data_source.dart';
import 'package:app_mobile/features/providers/common_features/chat/data/repository/chat_repository.dart';
import 'package:app_mobile/features/providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';
import '../../data/data_source/product_details_data_source.dart';
import '../../data/repository/product_details_repository.dart';
import '../../domain/use_case/get_product_details_use_case.dart';
import '../../presentation/controller/product_details_controller.dart';

void _initProductDetailsDependencies() {
  if (!GetIt.I.isRegistered<ProductDetailsDataSource>()) {
    instance.registerLazySingleton<ProductDetailsDataSource>(
      () => ProductDetailsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ProductDetailsRepository>()) {
    instance.registerLazySingleton<ProductDetailsRepository>(
      () => ProductDetailsRepositoryImplement(
        instance<ProductDetailsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetProductDetailsUseCase>()) {
    instance.registerFactory<GetProductDetailsUseCase>(
      () => GetProductDetailsUseCase(instance<ProductDetailsRepository>()),
    );
  }
  // Chat deps for contact-shop action
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

void _disposeProductDetailsDependencies() {
  if (GetIt.I.isRegistered<GetProductDetailsUseCase>())
    instance.unregister<GetProductDetailsUseCase>();
  if (GetIt.I.isRegistered<ProductDetailsRepository>())
    instance.unregister<ProductDetailsRepository>();
  if (GetIt.I.isRegistered<ProductDetailsDataSource>())
    instance.unregister<ProductDetailsDataSource>();
}

void initProductDetails({required String productId}) {
  _initProductDetailsDependencies();
  if (!Get.isRegistered<ProductDetailsController>()) {
    Get.put(
      ProductDetailsController(
        instance<GetProductDetailsUseCase>(),
        productId,
      ),
    );
  }
}

void disposeProductDetails() {
  _disposeProductDetailsDependencies();
  Get.delete<ProductDetailsController>();
}
