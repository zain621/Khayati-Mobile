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
import '../../data/data_source/tailor_details_data_source.dart';
import '../../data/repository/tailor_details_repository.dart';
import '../../domain/use_case/get_tailor_details_use_case.dart';
import '../../presentation/controller/tailor_details_controller.dart';

void _initTailorDetailsDependencies() {
  if (!GetIt.I.isRegistered<TailorDetailsDataSource>()) {
    instance.registerLazySingleton<TailorDetailsDataSource>(
      () => TailorDetailsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<TailorDetailsRepository>()) {
    instance.registerLazySingleton<TailorDetailsRepository>(
      () => TailorDetailsRepositoryImplement(
        instance<TailorDetailsDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetTailorDetailsUseCase>()) {
    instance.registerFactory<GetTailorDetailsUseCase>(
      () => GetTailorDetailsUseCase(instance<TailorDetailsRepository>()),
    );
  }
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

void _disposeTailorDetailsDependencies() {
  if (GetIt.I.isRegistered<GetTailorDetailsUseCase>())
    instance.unregister<GetTailorDetailsUseCase>();
  if (GetIt.I.isRegistered<TailorDetailsRepository>())
    instance.unregister<TailorDetailsRepository>();
  if (GetIt.I.isRegistered<TailorDetailsDataSource>())
    instance.unregister<TailorDetailsDataSource>();
}

void initTailorDetails({required String tailorId}) {
  _initTailorDetailsDependencies();
  if (!Get.isRegistered<TailorDetailsController>()) {
    Get.put(
      TailorDetailsController(
        instance<GetTailorDetailsUseCase>(),
        tailorId: tailorId,
      ),
    );
  }
}

void disposeTailorDetails() {
  _disposeTailorDetailsDependencies();
  Get.delete<TailorDetailsController>();
}
