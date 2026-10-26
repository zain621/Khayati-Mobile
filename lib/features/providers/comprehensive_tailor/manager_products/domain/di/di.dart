import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/network/app_api.dart';
import 'package:app_mobile/core/service/translation_service.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../data/data_source/products_data_source.dart';
import '../../data/repository/products_repository.dart';
import '../../domain/model/product_model.dart';
import '../../presentation/controller/add_edit_product_controller.dart';
import '../../presentation/controller/manager_products_controller.dart';
import '../use_case/get_products_use_case.dart';
import '../use_case/delete_product_use_case.dart';
import '../use_case/activate_product_use_case.dart';
import '../use_case/cancel_product_use_case.dart';
import '../use_case/get_product_details_use_case.dart';
import '../use_case/create_shop_owner_product_use_case.dart';
import '../use_case/update_shop_owner_product_use_case.dart';
import '../use_case/add_variant_use_case.dart';
import '../use_case/update_variant_use_case.dart';
import '../use_case/delete_variant_use_case.dart';

/// Initialize products data layer dependencies.
void initProductsRequest() {
  if (!GetIt.I.isRegistered<ProductsDataSource>()) {
    instance.registerLazySingleton<ProductsDataSource>(
      () => ProductsDataSourceImplement(
        instance<AppService>(),
        instance<Dio>(),
        instance<AppSettingsPrefs>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<ProductsRepository>()) {
    instance.registerLazySingleton<ProductsRepository>(
      () => ProductsRepositoryImplement(instance<ProductsDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetProductsUseCase>()) {
    instance.registerFactory<GetProductsUseCase>(
      () => GetProductsUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<DeleteProductUseCase>()) {
    instance.registerFactory<DeleteProductUseCase>(
      () => DeleteProductUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ActivateProductUseCase>()) {
    instance.registerFactory<ActivateProductUseCase>(
      () => ActivateProductUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CancelProductUseCase>()) {
    instance.registerFactory<CancelProductUseCase>(
      () => CancelProductUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetProductDetailsUseCase>()) {
    instance.registerFactory<GetProductDetailsUseCase>(
      () => GetProductDetailsUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<CreateShopOwnerProductUseCase>()) {
    instance.registerFactory<CreateShopOwnerProductUseCase>(
      () => CreateShopOwnerProductUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateShopOwnerProductUseCase>()) {
    instance.registerFactory<UpdateShopOwnerProductUseCase>(
      () => UpdateShopOwnerProductUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<AddVariantUseCase>()) {
    instance.registerFactory<AddVariantUseCase>(
      () => AddVariantUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdateVariantUseCase>()) {
    instance.registerFactory<UpdateVariantUseCase>(
      () => UpdateVariantUseCase(instance<ProductsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<DeleteVariantUseCase>()) {
    instance.registerFactory<DeleteVariantUseCase>(
      () => DeleteVariantUseCase(instance<ProductsRepository>()),
    );
  }
}

/// Dispose products data layer dependencies.
void disposeProductsRequest() {
  if (GetIt.I.isRegistered<DeleteVariantUseCase>())              instance.unregister<DeleteVariantUseCase>();
  if (GetIt.I.isRegistered<UpdateVariantUseCase>())              instance.unregister<UpdateVariantUseCase>();
  if (GetIt.I.isRegistered<AddVariantUseCase>())                 instance.unregister<AddVariantUseCase>();
  if (GetIt.I.isRegistered<UpdateShopOwnerProductUseCase>())     instance.unregister<UpdateShopOwnerProductUseCase>();
  if (GetIt.I.isRegistered<CreateShopOwnerProductUseCase>())     instance.unregister<CreateShopOwnerProductUseCase>();
  if (GetIt.I.isRegistered<GetProductDetailsUseCase>())          instance.unregister<GetProductDetailsUseCase>();
  if (GetIt.I.isRegistered<CancelProductUseCase>())              instance.unregister<CancelProductUseCase>();
  if (GetIt.I.isRegistered<ActivateProductUseCase>())            instance.unregister<ActivateProductUseCase>();
  if (GetIt.I.isRegistered<DeleteProductUseCase>())              instance.unregister<DeleteProductUseCase>();
  if (GetIt.I.isRegistered<GetProductsUseCase>())                instance.unregister<GetProductsUseCase>();
  if (GetIt.I.isRegistered<ProductsRepository>())                instance.unregister<ProductsRepository>();
  if (GetIt.I.isRegistered<ProductsDataSource>())                instance.unregister<ProductsDataSource>();
}

/// Initialize manager products feature (data + controller).
void initManagerProducts() {
  initProductsRequest();
  Get.put(ManagerProductsController(
    instance<GetProductsUseCase>(),
    instance<DeleteProductUseCase>(),
    instance<ActivateProductUseCase>(),
    instance<CancelProductUseCase>(),
  ));
}

/// Dispose manager products feature.
void disposeManagerProducts() {
  disposeProductsRequest();
  Get.delete<ManagerProductsController>();
}

/// Initialize add/edit product screen controller.
void initAddEditProduct({ProductModel? product}) {
  if (Get.isRegistered<AddEditProductController>()) {
    Get.delete<AddEditProductController>();
  }
  Get.put(AddEditProductController(
    instance<GetProductDetailsUseCase>(),
    instance<CreateShopOwnerProductUseCase>(),
    instance<UpdateShopOwnerProductUseCase>(),
    instance<AddVariantUseCase>(),
    instance<UpdateVariantUseCase>(),
    instance<DeleteVariantUseCase>(),
    instance<TranslationService>(),
    editProduct: product,
  ));
}

/// Dispose add/edit product controller.
void disposeAddEditProduct() {
  if (Get.isRegistered<AddEditProductController>()) {
    Get.delete<AddEditProductController>();
  }
}
