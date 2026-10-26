import 'dart:async';

import 'package:get/get.dart';
import '../../domain/model/product_list_item_model.dart';
import '../../domain/use_case/get_all_products_use_case.dart';

class AllProductsController extends GetxController {
  final GetAllProductsUseCase _getAllProductsUseCase;

  AllProductsController(this._getAllProductsUseCase);

  static const int _perPage = 15;

  final RxList<ProductListItemModel> products = <ProductListItemModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  int _currentPage = 1;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchQuery.value = value;
      fetchProducts();
    });
  }

  Future<void> fetchProducts() async {
    _currentPage = 1;
    hasMore.value = true;
    errorMessage.value = '';
    isLoading.value = true;

    final result = await _getAllProductsUseCase.execute(
      page: _currentPage,
      perPage: _perPage,
      shopSearch: searchQuery.value.isEmpty ? null : searchQuery.value,
    );

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (data) {
        products.assignAll(data.items);
        hasMore.value = data.items.length >= _perPage;
        isLoading.value = false;
      },
    );
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    _currentPage++;

    final result = await _getAllProductsUseCase.execute(
      page: _currentPage,
      perPage: _perPage,
      shopSearch: searchQuery.value.isEmpty ? null : searchQuery.value,
    );

    result.fold(
      (failure) {
        _currentPage--;
        isLoadingMore.value = false;
      },
      (data) {
        products.addAll(data.items);
        hasMore.value = data.items.length >= _perPage;
        isLoadingMore.value = false;
      },
    );
  }

  Future<void> refreshProducts() async {
    await fetchProducts();
  }
}
