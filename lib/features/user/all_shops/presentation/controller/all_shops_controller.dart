import 'dart:async';

import 'package:get/get.dart';
import 'package:app_mobile/features/user/shops/domain/model/shop_model.dart';
import 'package:app_mobile/features/user/all_shops/domain/use_case/get_all_shops_use_case.dart';

class AllShopsController extends GetxController {
  final GetAllShopsUseCase _getAllShopsUseCase;

  AllShopsController(this._getAllShopsUseCase);

  static const int _perPage = 12;

  final RxList<ShopModel> shops = <ShopModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  final RxString sortBy = ''.obs;

  int _currentPage = 1;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    fetchShops();
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
      fetchShops();
    });
  }

  void onSortChanged(String value) {
    sortBy.value = value;
    fetchShops();
  }

  Future<void> fetchShops() async {
    _currentPage = 1;
    hasMore.value = true;
    errorMessage.value = '';
    isLoading.value = true;

    final result = await _getAllShopsUseCase.execute(
      page: _currentPage,
      perPage: _perPage,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
      orderBy: sortBy.value.isEmpty ? null : sortBy.value,
    );

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      (data) {
        shops.assignAll(data.items);
        hasMore.value = data.items.length >= _perPage;
        isLoading.value = false;
      },
    );
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    _currentPage++;

    final result = await _getAllShopsUseCase.execute(
      page: _currentPage,
      perPage: _perPage,
      search: searchQuery.value.isEmpty ? null : searchQuery.value,
      orderBy: sortBy.value.isEmpty ? null : sortBy.value,
    );

    result.fold(
      (failure) {
        _currentPage--;
        isLoadingMore.value = false;
      },
      (data) {
        shops.addAll(data.items);
        hasMore.value = data.items.length >= _perPage;
        isLoadingMore.value = false;
      },
    );
  }

  Future<void> refreshShops() async {
    await fetchShops();
  }
}
