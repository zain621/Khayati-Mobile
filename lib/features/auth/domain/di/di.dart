import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../data/data_source/customer_register_data_source.dart';
import '../../data/data_source/login_data_source.dart';
import '../../data/data_source/provider_register_data_source.dart';
import '../../data/data_source/complete_login_with_code_data_source.dart';
import '../../data/repository/customer_register_repository.dart';
import '../../data/repository/login_repository.dart';
import '../../data/repository/provider_register_repository.dart';
import '../../data/repository/complete_login_with_code_repository.dart';
import '../../presentation/controller/customer_register_controller.dart';
import '../../presentation/controller/login_controller.dart';
import '../../presentation/controller/provider_register_controller.dart';
import '../../presentation/controller/provider_verification_controller.dart';
import '../use_case/customer_register_use_case.dart';
import '../use_case/customer_register_verify_use_case.dart';
import '../use_case/get_categories_use_case.dart';
import '../use_case/login_use_case.dart';
import '../use_case/provider_register_use_case.dart';
import '../use_case/complete_login_with_code_use_case.dart';
import '../../data/data_source/forgot_password_data_source.dart';
import '../../data/repository/forgot_password_repository.dart';
import '../../presentation/controller/forgot_password_controller.dart';
import '../use_case/forgot_password_use_case.dart';
import '../use_case/verify_code_use_case.dart';
import '../use_case/resend_code_use_case.dart';
import '../use_case/reset_password_use_case.dart';

void initLoginRequest() {
  if (!GetIt.I.isRegistered<LoginDataSource>()) {
    instance.registerLazySingleton<LoginDataSource>(
      () => LoginDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<LoginRepository>()) {
    instance.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
      () => LoginUseCase(instance<LoginRepository>()),
    );
  }
}

void disposeLoginRequest() {
  if (GetIt.I.isRegistered<LoginUseCase>()) instance.unregister<LoginUseCase>();
  if (GetIt.I.isRegistered<LoginRepository>())
    instance.unregister<LoginRepository>();
  if (GetIt.I.isRegistered<LoginDataSource>())
    instance.unregister<LoginDataSource>();
}

void initLogin() {
  initLoginRequest();
  if (Get.isRegistered<LoginController>()) {
    Get.delete<LoginController>(force: true);
  }
  Get.put(LoginController(
    instance<LoginUseCase>(),
    instance<AppSettingsPrefs>(),
  ));
}

void disposeLogin() {
  disposeLoginRequest();
  Get.delete<LoginController>();
}

// ─────────────────────────────────────────────────
// Customer Register
// ─────────────────────────────────────────────────

void initCustomerRegisterRequest() {
  if (!GetIt.I.isRegistered<CustomerRegisterDataSource>()) {
    instance.registerLazySingleton<CustomerRegisterDataSource>(
      () => CustomerRegisterDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<CustomerRegisterRepository>()) {
    instance.registerLazySingleton<CustomerRegisterRepository>(
      () => CustomerRegisterRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<CustomerRegisterUseCase>()) {
    instance.registerFactory<CustomerRegisterUseCase>(
      () => CustomerRegisterUseCase(instance<CustomerRegisterRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CustomerRegisterVerifyUseCase>()) {
    instance.registerFactory<CustomerRegisterVerifyUseCase>(
      () =>
          CustomerRegisterVerifyUseCase(instance<CustomerRegisterRepository>()),
    );
  }
}

void disposeCustomerRegisterRequest() {
  if (GetIt.I.isRegistered<CustomerRegisterVerifyUseCase>())
    instance.unregister<CustomerRegisterVerifyUseCase>();
  if (GetIt.I.isRegistered<CustomerRegisterUseCase>())
    instance.unregister<CustomerRegisterUseCase>();
  if (GetIt.I.isRegistered<CustomerRegisterRepository>())
    instance.unregister<CustomerRegisterRepository>();
  if (GetIt.I.isRegistered<CustomerRegisterDataSource>())
    instance.unregister<CustomerRegisterDataSource>();
}

void initCustomerRegister() {
  initCustomerRegisterRequest();
  Get.put(CustomerRegisterController(
    instance<CustomerRegisterUseCase>(),
    instance<CustomerRegisterVerifyUseCase>(),
    instance<AppSettingsPrefs>(),
  ));
}

void disposeCustomerRegister() {
  disposeCustomerRegisterRequest();
  Get.delete<CustomerRegisterController>();
}

// ─────────────────────────────────────────────────
// Provider Register
// ─────────────────────────────────────────────────

void initProviderRegisterRequest() {
  if (!GetIt.I.isRegistered<ProviderRegisterDataSource>()) {
    instance.registerLazySingleton<ProviderRegisterDataSource>(
      () => ProviderRegisterDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ProviderRegisterRepository>()) {
    instance.registerLazySingleton<ProviderRegisterRepository>(
      () => ProviderRegisterRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<ProviderRegisterUseCase>()) {
    instance.registerFactory<ProviderRegisterUseCase>(
      () => ProviderRegisterUseCase(instance<ProviderRegisterRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetCategoriesUseCase>()) {
    instance.registerFactory<GetCategoriesUseCase>(
      () => GetCategoriesUseCase(instance<ProviderRegisterRepository>()),
    );
  }
}

void disposeProviderRegisterRequest() {
  if (GetIt.I.isRegistered<GetCategoriesUseCase>())
    instance.unregister<GetCategoriesUseCase>();
  if (GetIt.I.isRegistered<ProviderRegisterUseCase>())
    instance.unregister<ProviderRegisterUseCase>();
  if (GetIt.I.isRegistered<ProviderRegisterRepository>())
    instance.unregister<ProviderRegisterRepository>();
  if (GetIt.I.isRegistered<ProviderRegisterDataSource>())
    instance.unregister<ProviderRegisterDataSource>();
}

void initProviderRegister() {
  initProviderRegisterRequest();
  Get.put(ProviderRegisterController(
    instance<ProviderRegisterUseCase>(),
    instance<GetCategoriesUseCase>(),
  ));
}

void disposeProviderRegister() {
  disposeProviderRegisterRequest();
  Get.delete<ProviderRegisterController>();
}

// ─────────────────────────────────────────────────
// Forgot Password
// ─────────────────────────────────────────────────

void initForgotPasswordRequest() {
  if (!GetIt.I.isRegistered<ForgotPasswordDataSource>()) {
    instance.registerLazySingleton<ForgotPasswordDataSource>(
      () => ForgotPasswordDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ForgotPasswordRepository>()) {
    instance.registerLazySingleton<ForgotPasswordRepository>(
      () => ForgotPasswordRepositoryImplement(
          instance<ForgotPasswordDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<ForgotPasswordUseCase>()) {
    instance.registerFactory<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(instance<ForgotPasswordRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<VerifyCodeUseCase>()) {
    instance.registerFactory<VerifyCodeUseCase>(
      () => VerifyCodeUseCase(instance<ForgotPasswordRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ResendCodeUseCase>()) {
    instance.registerFactory<ResendCodeUseCase>(
      () => ResendCodeUseCase(instance<ForgotPasswordRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerFactory<ResetPasswordUseCase>(
      () => ResetPasswordUseCase(instance<ForgotPasswordRepository>()),
    );
  }
}

void disposeForgotPasswordRequest() {
  if (GetIt.I.isRegistered<ResetPasswordUseCase>())
    instance.unregister<ResetPasswordUseCase>();
  if (GetIt.I.isRegistered<ResendCodeUseCase>())
    instance.unregister<ResendCodeUseCase>();
  if (GetIt.I.isRegistered<VerifyCodeUseCase>())
    instance.unregister<VerifyCodeUseCase>();
  if (GetIt.I.isRegistered<ForgotPasswordUseCase>())
    instance.unregister<ForgotPasswordUseCase>();
  if (GetIt.I.isRegistered<ForgotPasswordRepository>())
    instance.unregister<ForgotPasswordRepository>();
  if (GetIt.I.isRegistered<ForgotPasswordDataSource>())
    instance.unregister<ForgotPasswordDataSource>();
}

void initForgotPassword() {
  initForgotPasswordRequest();
  Get.put(ForgotPasswordController(
    instance<ForgotPasswordUseCase>(),
    instance<VerifyCodeUseCase>(),
    instance<ResendCodeUseCase>(),
    instance<ResetPasswordUseCase>(),
  ));
}

void disposeForgotPassword() {
  disposeForgotPasswordRequest();
  Get.delete<ForgotPasswordController>();
}

// ─────────────────────────────────────────────────────────────────────────────
// Provider Login OTP (login/verify)
// ─────────────────────────────────────────────────────────────────────────────

void initCompleteLoginWithCodeRequest() {
  if (!GetIt.I.isRegistered<CompleteLoginWithCodeDataSource>()) {
    instance.registerLazySingleton<CompleteLoginWithCodeDataSource>(
      () => CompleteLoginWithCodeDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<CompleteLoginWithCodeRepository>()) {
    instance.registerLazySingleton<CompleteLoginWithCodeRepository>(
      () => CompleteLoginWithCodeRepositoryImplement(instance(), instance()),
    );
  }
  if (!GetIt.I.isRegistered<CompleteLoginWithCodeUseCase>()) {
    instance.registerFactory<CompleteLoginWithCodeUseCase>(
      () => CompleteLoginWithCodeUseCase(
          instance<CompleteLoginWithCodeRepository>()),
    );
  }
}

void disposeCompleteLoginWithCodeRequest() {
  if (GetIt.I.isRegistered<CompleteLoginWithCodeUseCase>())
    instance.unregister<CompleteLoginWithCodeUseCase>();
  if (GetIt.I.isRegistered<CompleteLoginWithCodeRepository>())
    instance.unregister<CompleteLoginWithCodeRepository>();
  if (GetIt.I.isRegistered<CompleteLoginWithCodeDataSource>())
    instance.unregister<CompleteLoginWithCodeDataSource>();
}

void initProviderVerification({required String phoneNumber}) {
  initCompleteLoginWithCodeRequest();
  initLoginRequest();
  if (Get.isRegistered<ProviderVerificationController>()) {
    Get.delete<ProviderVerificationController>(force: true);
  }
  Get.put(ProviderVerificationController(
    instance<CompleteLoginWithCodeUseCase>(),
    instance<LoginUseCase>(),
    instance<AppSettingsPrefs>(),
    phoneNumber,
  ));
}

void disposeProviderVerification() {
  disposeCompleteLoginWithCodeRequest();
  Get.delete<ProviderVerificationController>();
}
