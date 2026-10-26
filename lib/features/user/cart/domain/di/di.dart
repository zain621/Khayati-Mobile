import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/internet_checker/interent_checker.dart';
import '../../data/data_source/cart_data_source.dart';
import '../../data/repository/cart_repository.dart';
import '../../domain/use_case/get_cart_use_case.dart';
import '../../domain/use_case/add_cart_item_use_case.dart';
import '../../domain/use_case/update_cart_item_use_case.dart';
import '../../domain/use_case/remove_cart_item_use_case.dart';
import '../../domain/use_case/apply_coupon_use_case.dart';
import '../../domain/use_case/remove_coupon_use_case.dart';
import '../../domain/use_case/checkout_use_case.dart';
import '../../presentation/controller/cart_controller.dart';

void _initCartDependencies() {
  if (!GetIt.I.isRegistered<CartDataSource>()) {
    instance.registerLazySingleton<CartDataSource>(
      () => CartDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<CartRepository>()) {
    instance.registerLazySingleton<CartRepository>(
      () => CartRepositoryImplement(
        instance<CartDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetCartUseCase>()) {
    instance.registerFactory<GetCartUseCase>(
      () => GetCartUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<AddCartItemUseCase>()) {
    instance.registerFactory<AddCartItemUseCase>(
      () => AddCartItemUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateCartItemUseCase>()) {
    instance.registerFactory<UpdateCartItemUseCase>(
      () => UpdateCartItemUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<RemoveCartItemUseCase>()) {
    instance.registerFactory<RemoveCartItemUseCase>(
      () => RemoveCartItemUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ApplyCouponUseCase>()) {
    instance.registerFactory<ApplyCouponUseCase>(
      () => ApplyCouponUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<RemoveCouponUseCase>()) {
    instance.registerFactory<RemoveCouponUseCase>(
      () => RemoveCouponUseCase(instance<CartRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CheckoutUseCase>()) {
    instance.registerFactory<CheckoutUseCase>(
      () => CheckoutUseCase(instance<CartRepository>()),
    );
  }
}

void _disposeCartDependencies() {
  if (GetIt.I.isRegistered<CheckoutUseCase>())
    instance.unregister<CheckoutUseCase>();
  if (GetIt.I.isRegistered<RemoveCouponUseCase>())
    instance.unregister<RemoveCouponUseCase>();
  if (GetIt.I.isRegistered<ApplyCouponUseCase>())
    instance.unregister<ApplyCouponUseCase>();
  if (GetIt.I.isRegistered<RemoveCartItemUseCase>())
    instance.unregister<RemoveCartItemUseCase>();
  if (GetIt.I.isRegistered<UpdateCartItemUseCase>())
    instance.unregister<UpdateCartItemUseCase>();
  if (GetIt.I.isRegistered<AddCartItemUseCase>())
    instance.unregister<AddCartItemUseCase>();
  if (GetIt.I.isRegistered<GetCartUseCase>())
    instance.unregister<GetCartUseCase>();
  if (GetIt.I.isRegistered<CartRepository>())
    instance.unregister<CartRepository>();
  if (GetIt.I.isRegistered<CartDataSource>())
    instance.unregister<CartDataSource>();
}

void initCart({bool forceRefresh = false}) {
  _initCartDependencies();
  if (forceRefresh && Get.isRegistered<CartController>()) {
    Get.delete<CartController>(force: true);
  }
  if (!Get.isRegistered<CartController>()) {
    Get.put(
      CartController(
        instance<GetCartUseCase>(),
        instance<AddCartItemUseCase>(),
        instance<UpdateCartItemUseCase>(),
        instance<RemoveCartItemUseCase>(),
        instance<ApplyCouponUseCase>(),
        instance<RemoveCouponUseCase>(),
        instance<CheckoutUseCase>(),
      ),
    );
  }
}

void disposeCart() {
  _disposeCartDependencies();
  Get.delete<CartController>();
}
