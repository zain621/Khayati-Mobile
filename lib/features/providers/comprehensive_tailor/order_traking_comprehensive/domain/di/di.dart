import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../../../../../constants/di/dependency_injection.dart';
import '../../../../../../core/network/app_api.dart';
import '../../../../../../core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/comprehensive_order_tracking_data_source.dart';
import '../../data/repository/comprehensive_order_tracking_repository.dart';
import '../../presentation/controller/comprehensive_order_tracking_controller.dart';
import '../use_case/get_comprehensive_orders_use_case.dart';
import '../use_case/get_comprehensive_order_detail_use_case.dart';
import '../use_case/update_comprehensive_order_stage_use_case.dart';
import '../use_case/update_comprehensive_zoqak_status_use_case.dart';
import '../use_case/get_zoqak_my_offer_by_order_use_case.dart';
import '../../../../../providers/common_features/chat/data/data_source/chat_data_source.dart';
import '../../../../../providers/common_features/chat/data/repository/chat_repository.dart';
import '../../../../../providers/common_features/chat/domain/use_case/create_conversation_use_case.dart';

void _initComprehensiveOrderTrackingDeps() {
  if (!GetIt.I.isRegistered<ComprehensiveOrderTrackingDataSource>()) {
    instance.registerLazySingleton<ComprehensiveOrderTrackingDataSource>(
      () => ComprehensiveOrderTrackingDataSourceImpl(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ComprehensiveOrderTrackingRepository>()) {
    instance.registerLazySingleton<ComprehensiveOrderTrackingRepository>(
      () => ComprehensiveOrderTrackingRepositoryImpl(
        instance<ComprehensiveOrderTrackingDataSource>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetComprehensiveOrdersUseCase>()) {
    instance.registerFactory<GetComprehensiveOrdersUseCase>(
      () => GetComprehensiveOrdersUseCase(
          instance<ComprehensiveOrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetComprehensiveOrderDetailUseCase>()) {
    instance.registerFactory<GetComprehensiveOrderDetailUseCase>(
      () => GetComprehensiveOrderDetailUseCase(
          instance<ComprehensiveOrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateComprehensiveOrderStageUseCase>()) {
    instance.registerFactory<UpdateComprehensiveOrderStageUseCase>(
      () => UpdateComprehensiveOrderStageUseCase(
          instance<ComprehensiveOrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateComprehensiveZoqakStatusUseCase>()) {
    instance.registerFactory<UpdateComprehensiveZoqakStatusUseCase>(
      () => UpdateComprehensiveZoqakStatusUseCase(
          instance<ComprehensiveOrderTrackingRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetZoqakMyOfferByOrderUseCase>()) {
    instance.registerFactory<GetZoqakMyOfferByOrderUseCase>(
      () => GetZoqakMyOfferByOrderUseCase(
          instance<ComprehensiveOrderTrackingRepository>()),
    );
  }
  // Chat deps for conversation creation
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

void _disposeComprehensiveOrderTrackingDeps() {
  if (GetIt.I.isRegistered<UpdateComprehensiveOrderStageUseCase>())
    instance.unregister<UpdateComprehensiveOrderStageUseCase>();
  if (GetIt.I.isRegistered<UpdateComprehensiveZoqakStatusUseCase>())
    instance.unregister<UpdateComprehensiveZoqakStatusUseCase>();
  if (GetIt.I.isRegistered<GetZoqakMyOfferByOrderUseCase>())
    instance.unregister<GetZoqakMyOfferByOrderUseCase>();
  if (GetIt.I.isRegistered<GetComprehensiveOrderDetailUseCase>())
    instance.unregister<GetComprehensiveOrderDetailUseCase>();
  if (GetIt.I.isRegistered<GetComprehensiveOrdersUseCase>())
    instance.unregister<GetComprehensiveOrdersUseCase>();
  if (GetIt.I.isRegistered<ComprehensiveOrderTrackingRepository>())
    instance.unregister<ComprehensiveOrderTrackingRepository>();
  if (GetIt.I.isRegistered<ComprehensiveOrderTrackingDataSource>())
    instance.unregister<ComprehensiveOrderTrackingDataSource>();
}

void initComprehensiveOrderTracking({bool forceRefresh = false}) {
  _initComprehensiveOrderTrackingDeps();
  if (forceRefresh &&
      Get.isRegistered<ComprehensiveOrderTrackingController>()) {
    Get.delete<ComprehensiveOrderTrackingController>(force: true);
  }
  if (!Get.isRegistered<ComprehensiveOrderTrackingController>()) {
    Get.put(
      ComprehensiveOrderTrackingController(
        instance<GetComprehensiveOrdersUseCase>(),
        instance<GetComprehensiveOrderDetailUseCase>(),
        instance<UpdateComprehensiveOrderStageUseCase>(),
        instance<UpdateComprehensiveZoqakStatusUseCase>(),
        instance<GetZoqakMyOfferByOrderUseCase>(),
        instance<CreateConversationUseCase>(),
      ),
    );
  }
}

void disposeComprehensiveOrderTracking() {
  _disposeComprehensiveOrderTrackingDeps();
  if (Get.isRegistered<ComprehensiveOrderTrackingController>()) {
    Get.delete<ComprehensiveOrderTrackingController>();
  }
}
