import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/features/common/delete_account/domain/di/di.dart';
import 'package:app_mobile/features/common/logout/domain/di/di.dart';
import '../../data/data_source/user_profile_data_source.dart';
import '../../data/repository/user_profile_repository.dart';
import '../../presentation/controller/update_user_profile_controller.dart';
import '../../presentation/controller/user_profile_controller.dart';
import '../use_case/update_user_profile_use_case.dart';
import '../use_case/user_profile_use_case.dart';

// ── Common request-layer singletons (shared by fetch & update) ────────────────

void initUserProfileRequest() {
  if (!GetIt.I.isRegistered<UserProfileDataSource>()) {
    instance.registerLazySingleton<UserProfileDataSource>(
      () => UserProfileDataSourceImplement(instance<AppService>(), instance<Dio>()),
    );
  }
  if (!GetIt.I.isRegistered<UserProfileRepository>()) {
    instance.registerLazySingleton<UserProfileRepository>(
      () => UserProfileRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<UserProfileUseCase>()) {
    instance.registerFactory<UserProfileUseCase>(
      () => UserProfileUseCase(instance<UserProfileRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateUserProfileUseCase>()) {
    instance.registerFactory<UpdateUserProfileUseCase>(
      () => UpdateUserProfileUseCase(instance<UserProfileRepository>()),
    );
  }
}

void disposeUserProfileRequest() {
  if (GetIt.I.isRegistered<UpdateUserProfileUseCase>())
    instance.unregister<UpdateUserProfileUseCase>();
  if (GetIt.I.isRegistered<UserProfileUseCase>())
    instance.unregister<UserProfileUseCase>();
  if (GetIt.I.isRegistered<UserProfileRepository>())
    instance.unregister<UserProfileRepository>();
  if (GetIt.I.isRegistered<UserProfileDataSource>())
    instance.unregister<UserProfileDataSource>();
}

// ── Fetch profile ──────────────────────────────────────────────────────────────

void initUserProfile({bool forceRefresh = false}) {
  initUserProfileRequest();
  if (forceRefresh && Get.isRegistered<UserProfileController>()) {
    Get.delete<UserProfileController>(force: true);
  }
  if (!Get.isRegistered<UserProfileController>()) {
    Get.put(UserProfileController(
      instance<UserProfileUseCase>(),
      getLogoutUseCase(),
      getDeleteAccountUseCase(),
    ));
  }
}

void disposeUserProfile() {
  disposeUserProfileRequest();
  Get.delete<UserProfileController>();
}

// ── Update profile ─────────────────────────────────────────────────────────────

void initUpdateUserProfile({
  required String initialFullName,
  required String phone,
  String? initialImage,
}) {
  initUserProfileRequest();
  Get.put(
    UpdateUserProfileController(
      instance<UpdateUserProfileUseCase>(),
      instance<AppSettingsPrefs>(),
      initialFullName: initialFullName,
      phone: phone,
      initialImage: initialImage,
    ),
  );
}

void disposeUpdateUserProfile() {
  if (GetIt.I.isRegistered<UpdateUserProfileUseCase>())
    instance.unregister<UpdateUserProfileUseCase>();
  Get.delete<UpdateUserProfileController>();
}
