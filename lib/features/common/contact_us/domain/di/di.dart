import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/contact_us_data_source.dart';
import '../../data/repository/contact_us_repository.dart';
import '../../domain/use_case/contact_us_use_case.dart';
import '../../presentation/controller/contact_us_controller.dart';

void _initContactUsDeps() {
  if (!GetIt.I.isRegistered<ContactUsDataSource>()) {
    instance.registerLazySingleton<ContactUsDataSource>(
      () => ContactUsDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<ContactUsRepository>()) {
    instance.registerLazySingleton<ContactUsRepository>(
      () => ContactUsRepositoryImplement(instance<ContactUsDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<ContactUsUseCase>()) {
    instance.registerFactory<ContactUsUseCase>(
      () => ContactUsUseCase(instance<ContactUsRepository>()),
    );
  }
}

void _disposeContactUsDeps() {
  if (GetIt.I.isRegistered<ContactUsUseCase>()) {
    instance.unregister<ContactUsUseCase>();
  }
  if (GetIt.I.isRegistered<ContactUsRepository>()) {
    instance.unregister<ContactUsRepository>();
  }
  if (GetIt.I.isRegistered<ContactUsDataSource>()) {
    instance.unregister<ContactUsDataSource>();
  }
}

void initContactUs() {
  _initContactUsDeps();
  if (!Get.isRegistered<ContactUsController>()) {
    Get.put(ContactUsController(
      contactUsUseCase: instance<ContactUsUseCase>(),
    ));
  }
}

void disposeContactUs() {
  if (Get.isRegistered<ContactUsController>()) {
    Get.delete<ContactUsController>();
  }
  _disposeContactUsDeps();
}
