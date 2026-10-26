import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../constants/di/dependency_injection.dart';
import '../../../../../core/network/app_api.dart';
import '../../../../../core/internet_checker/interent_checker.dart';
import '../../data/data_source/my_orders_data_source.dart';
import '../../data/repository/my_orders_repository.dart';
import '../../domain/use_case/get_user_orders_use_case.dart';
import '../../domain/use_case/get_zoqak_offers_use_case.dart';
import '../../domain/use_case/accept_zoqak_offer_use_case.dart';
import '../../domain/use_case/get_order_detail_use_case.dart';
import '../../presentation/controller/my_orders_controller.dart';
import '../../presentation/controller/order_details_controller.dart';

void _initMyOrdersDependencies() {
  if (!GetIt.I.isRegistered<MyOrdersDataSource>()) {
    instance.registerLazySingleton<MyOrdersDataSource>(
      () => MyOrdersDataSourceImplement(instance<AppService>()),
    );
  }
  if (!GetIt.I.isRegistered<MyOrdersRepository>()) {
    instance.registerLazySingleton<MyOrdersRepository>(
      () => MyOrdersRepositoryImplement(
        instance<MyOrdersDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetUserOrdersUseCase>()) {
    instance.registerFactory<GetUserOrdersUseCase>(
      () => GetUserOrdersUseCase(instance<MyOrdersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetZoqakOffersUseCase>()) {
    instance.registerFactory<GetZoqakOffersUseCase>(
      () => GetZoqakOffersUseCase(instance<MyOrdersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<AcceptZoqakOfferUseCase>()) {
    instance.registerFactory<AcceptZoqakOfferUseCase>(
      () => AcceptZoqakOfferUseCase(instance<MyOrdersRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetOrderDetailUseCase>()) {
    instance.registerFactory<GetOrderDetailUseCase>(
      () => GetOrderDetailUseCase(instance<MyOrdersRepository>()),
    );
  }
}

void _disposeMyOrdersDependencies() {
  if (GetIt.I.isRegistered<AcceptZoqakOfferUseCase>())
    instance.unregister<AcceptZoqakOfferUseCase>();
  if (GetIt.I.isRegistered<GetZoqakOffersUseCase>())
    instance.unregister<GetZoqakOffersUseCase>();
  if (GetIt.I.isRegistered<GetUserOrdersUseCase>())
    instance.unregister<GetUserOrdersUseCase>();
  if (GetIt.I.isRegistered<MyOrdersRepository>())
    instance.unregister<MyOrdersRepository>();
  if (GetIt.I.isRegistered<MyOrdersDataSource>())
    instance.unregister<MyOrdersDataSource>();
}

void initMyOrders({bool forceRefresh = false}) {
  _initMyOrdersDependencies();
  if (forceRefresh && Get.isRegistered<MyOrdersController>()) {
    Get.delete<MyOrdersController>(force: true);
  }
  if (!Get.isRegistered<MyOrdersController>()) {
    Get.put(
      MyOrdersController(
        instance<GetUserOrdersUseCase>(),
        instance<GetZoqakOffersUseCase>(),
        instance<AcceptZoqakOfferUseCase>(),
      ),
    );
  }
}

void disposeMyOrders() {
  _disposeMyOrdersDependencies();
  Get.delete<MyOrdersController>();
}

/// Creates a fresh [OrderDetailsController] scoped to a single detail screen.
/// Call this inside the screen's [initState]; delete it in [dispose].
OrderDetailsController createOrderDetailsController() {
  return Get.put(OrderDetailsController(instance<GetOrderDetailUseCase>()));
}
