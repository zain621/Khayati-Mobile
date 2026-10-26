import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/widgets/custom_confirm_dialog.dart';
import 'package:app_mobile/features/providers/comprehensive_tailor/manager_products/domain/di/di.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/model/product_model.dart';
import '../../domain/use_case/get_products_use_case.dart';
import '../../domain/use_case/delete_product_use_case.dart';
import '../../domain/use_case/activate_product_use_case.dart';
import '../../domain/use_case/cancel_product_use_case.dart';

/// Controller for managing products screen.
class ManagerProductsController extends GetxController {
  final GetProductsUseCase _getProductsUseCase;
  final DeleteProductUseCase _deleteProductUseCase;
  final ActivateProductUseCase _activateProductUseCase;
  final CancelProductUseCase _cancelProductUseCase;

  ManagerProductsController(
    this._getProductsUseCase,
    this._deleteProductUseCase,
    this._activateProductUseCase,
    this._cancelProductUseCase,
  );

  // State variables
  final RxBool isLoading = false.obs;
  final RxBool isActionLoading = false.obs;
  final RxBool isError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxInt totalProducts = 0.obs;

  // Filter state
  final RxInt selectedFilterIndex = 0.obs;
  final RxString searchQuery = ''.obs;

  // Search controller
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  /// Get filtered products based on selected filter and search query.
  List<ProductModel> get filteredProducts {
    List<ProductModel> result;

    switch (selectedFilterIndex.value) {
      case 1:
        result = products
            .where((p) => p.status == ProductStatus.active)
            .toList();
      case 2:
        result = products
            .where((p) => p.status == ProductStatus.inactive)
            .toList();
      case 3:
        result = products
            .where((p) => p.status == ProductStatus.outOfStock)
            .toList();
      default:
        result = products.toList();
    }

    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((p) =>
              p.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              p.category.name
                  .toLowerCase()
                  .contains(searchQuery.value.toLowerCase()))
          .toList();
    }

    return result;
  }

  /// Get count for each filter tab.
  int get allCount => products.length;
  int get activeCount =>
      products.where((p) => p.status == ProductStatus.active).length;
  int get inactiveCount =>
      products.where((p) => p.status == ProductStatus.inactive).length;
  int get outOfStockCount =>
      products.where((p) => p.status == ProductStatus.outOfStock).length;

  /// Fetch products from API.
  Future<void> fetchProducts() async {
    isLoading.value = true;
    isError.value = false;
    errorMessage.value = '';

    final result = await _getProductsUseCase.execute();

    result.fold(
      (failure) {
        isError.value = true;
        errorMessage.value = failure.message;
        AppSnackbar.error(failure.message);
      },
      (data) {
        products.assignAll(data.items);
        totalProducts.value = data.total;
      },
    );

    isLoading.value = false;
  }

  /// Refresh products (pull-to-refresh).
  Future<void> refreshProducts() async {
    await fetchProducts();
  }

  /// Update selected filter index.
  void setFilterIndex(int index) {
    selectedFilterIndex.value = index;
  }

  /// Update search query.
  void setSearchQuery(String query) {
    searchQuery.value = query;
  }

  /// Clear search query.
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  /// Handle edit product action — navigates to the edit screen.
  void handleEdit(ProductModel product) {
    initAddEditProduct(product: product);
    Get.toNamed(Routes.addEditProductScreen);
  }

  /// Handle pause/resume product — smart toggle based on current status.
  /// Active → show cancel dialog → call cancelProduct API.
  /// Inactive / OutOfStock → show activate dialog → call activateProduct API.
  Future<void> handlePause(ProductModel product) async {
    final context = Get.context;
    if (context == null) return;

    final bool isActive = product.status == ProductStatus.active;

    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: isActive
          ? ManagerStrings.managerProductsCancelDialogTitle
          : ManagerStrings.managerProductsActivateDialogTitle,
      subtitle: isActive
          ? ManagerStrings.managerProductsCancelDialogSubtitle
          : ManagerStrings.managerProductsActivateDialogSubtitle,
      confirmText: isActive
          ? ManagerStrings.managerProductsCancelDialogConfirm
          : ManagerStrings.managerProductsActivateDialogConfirm,
      cancelText: isActive
          ? ManagerStrings.managerProductsCancelDialogCancel
          : ManagerStrings.managerProductsActivateDialogCancel,
    );

    if (confirmed != true) return;

    bool actionSucceeded = false;
    isActionLoading.value = true;
    try {
      final result = isActive
          ? await _cancelProductUseCase.execute(product.id)
          : await _activateProductUseCase.execute(product.id);

      result.fold(
        (failure) => AppSnackbar.error(failure.message),
        (_) {
          actionSucceeded = true;
          AppSnackbar.success(
            isActive
                ? ManagerStrings.managerProductsCancelSuccess
                : ManagerStrings.managerProductsActivateSuccess,
            englishMessage: isActive
                ? ManagerStrings.managerProductsCancelSuccessEn
                : ManagerStrings.managerProductsActivateSuccessEn,
          );
        },
      );
    } finally {
      isActionLoading.value = false;
    }
    if (actionSucceeded) fetchProducts();
  }

  /// Handle delete product — shows confirmation dialog before deleting.
  Future<void> handleDelete(ProductModel product) async {
    final context = Get.context;
    if (context == null) return;

    final confirmed = await CustomConfirmDialog.show(
      context: context,
      title: ManagerStrings.managerProductsDeleteDialogTitle,
      subtitle: ManagerStrings.managerProductsDeleteDialogSubtitle,
      confirmText: ManagerStrings.managerProductsDeleteDialogConfirm,
      cancelText: ManagerStrings.managerProductsDeleteDialogCancel,
    );

    if (confirmed != true) return;

    bool actionSucceeded = false;
    isActionLoading.value = true;
    try {
      final result = await _deleteProductUseCase.execute(product.id);

      result.fold(
        (failure) => AppSnackbar.error(failure.message),
        (_) {
          actionSucceeded = true;
          AppSnackbar.success(
            ManagerStrings.managerProductsDeleteSuccess,
            englishMessage: ManagerStrings.managerProductsDeleteSuccessEn,
          );
        },
      );
    } finally {
      isActionLoading.value = false;
    }
    if (actionSucceeded) fetchProducts();
  }

  /// Handle add product action — navigates to the add product screen.
  void handleAddProduct() {
    initAddEditProduct();
    Get.toNamed(Routes.addEditProductScreen);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
