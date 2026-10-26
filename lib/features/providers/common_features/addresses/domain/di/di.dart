import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import '../../data/data_source/address_data_source.dart';
import '../../data/repository/address_repository.dart';
import '../../presentation/controller/address_controller.dart';
import '../use_case/get_address_use_case.dart';
import '../use_case/create_address_use_case.dart';
import '../use_case/update_address_use_case.dart';

void _initAddressDeps() {
  if (!GetIt.I.isRegistered<AddressDataSource>()) {
    instance.registerLazySingleton<AddressDataSource>(
      () => AddressDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<AddressRepository>()) {
    instance.registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImplement(instance<AddressDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetAddressUseCase>()) {
    instance.registerFactory<GetAddressUseCase>(
      () => GetAddressUseCase(instance<AddressRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CreateAddressUseCase>()) {
    instance.registerFactory<CreateAddressUseCase>(
      () => CreateAddressUseCase(instance<AddressRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateAddressUseCase>()) {
    instance.registerFactory<UpdateAddressUseCase>(
      () => UpdateAddressUseCase(instance<AddressRepository>()),
    );
  }
}

void _disposeAddressDeps() {
  if (GetIt.I.isRegistered<UpdateAddressUseCase>()) instance.unregister<UpdateAddressUseCase>();
  if (GetIt.I.isRegistered<CreateAddressUseCase>()) instance.unregister<CreateAddressUseCase>();
  if (GetIt.I.isRegistered<GetAddressUseCase>()) instance.unregister<GetAddressUseCase>();
  if (GetIt.I.isRegistered<AddressRepository>()) instance.unregister<AddressRepository>();
  if (GetIt.I.isRegistered<AddressDataSource>()) instance.unregister<AddressDataSource>();
}

void initAddress() {
  _initAddressDeps();
  if (!Get.isRegistered<AddressController>()) {
    Get.put(AddressController(
      getAddressUseCase: instance<GetAddressUseCase>(),
      createAddressUseCase: instance<CreateAddressUseCase>(),
      updateAddressUseCase: instance<UpdateAddressUseCase>(),
    ));
  }
}

void disposeAddress() {
  if (Get.isRegistered<AddressController>()) Get.delete<AddressController>();
  _disposeAddressDeps();
}
