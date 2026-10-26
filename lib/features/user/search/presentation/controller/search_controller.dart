import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import '../../domain/model/search_model.dart';
import '../../domain/model/search_history_model.dart';
import '../../domain/use_case/search_use_case.dart';
import '../../domain/use_case/get_search_history_use_case.dart';
import '../../domain/use_case/delete_search_history_item_use_case.dart';
import '../../domain/use_case/clear_search_history_use_case.dart';

enum SearchType { all, products, shops, tailors }

extension SearchTypeExt on SearchType {
  String get value {
    switch (this) {
      case SearchType.all:
        return 'all';
      case SearchType.products:
        return 'products';
      case SearchType.shops:
        return 'shops';
      case SearchType.tailors:
        return 'tailors';
    }
  }
}

class SearchController extends GetxController {
  final SearchUseCase _searchUseCase;
  final GetSearchHistoryUseCase _getHistoryUseCase;
  final DeleteSearchHistoryItemUseCase _deleteHistoryItemUseCase;
  final ClearSearchHistoryUseCase _clearHistoryUseCase;

  SearchController(
    this._searchUseCase,
    this._getHistoryUseCase,
    this._deleteHistoryItemUseCase,
    this._clearHistoryUseCase,
  );

  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocus = FocusNode();

  final RxString query = ''.obs;
  final Rx<SearchType> selectedType = SearchType.all.obs;
  final Rxn<SearchModel> results = Rxn();
  final RxList<SearchHistoryModel> history = <SearchHistoryModel>[].obs;
  final RxBool isSearching = false.obs;
  final RxBool isLoadingHistory = false.obs;
  final RxBool isDeletingAll = false.obs;

  Timer? _debounce;

  bool get hasQuery => query.value.trim().isNotEmpty;
  bool get hasResults => results.value != null;

  List<SearchProductModel> get filteredProducts {
    final r = results.value;
    if (r == null) return [];
    return r.products;
  }

  List<SearchShopModel> get filteredShops {
    final r = results.value;
    if (r == null) return [];
    return r.shops;
  }

  List<SearchTailorModel> get filteredTailors {
    final r = results.value;
    if (r == null) return [];
    return r.tailors;
  }

  @override
  void onReady() {
    super.onReady();
    loadHistory();
    searchFocus.requestFocus();
  }

  @override
  void onClose() {
    _debounce?.cancel();
    searchTextController.dispose();
    searchFocus.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    query.value = value;
    _debounce?.cancel();
    if (value.trim().isEmpty) {
      results.value = null;
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _executeSearch(value.trim(), selectedType.value.value);
    });
  }

  void selectType(SearchType type) {
    selectedType.value = type;
    if (hasQuery) {
      _executeSearch(query.value.trim(), type.value);
    }
  }

  void fillFromHistory(String historyQuery) {
    searchTextController.text = historyQuery;
    query.value = historyQuery;
    _executeSearch(historyQuery, selectedType.value.value);
  }

  Future<void> _executeSearch(String q, String type) async {
    isSearching.value = true;
    final result = await _searchUseCase.execute(SearchParams(query: q, type: type));
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) => results.value = data,
    );
    isSearching.value = false;
  }

  Future<void> loadHistory() async {
    isLoadingHistory.value = true;
    final result = await _getHistoryUseCase.execute();
    result.fold(
      (failure) {},
      (data) => history.assignAll(data),
    );
    isLoadingHistory.value = false;
  }

  Future<void> deleteHistoryItem(String historyId) async {
    final result = await _deleteHistoryItemUseCase.execute(historyId);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        history.removeWhere((e) => e.id == historyId);
        AppSnackbar.success(
          ManagerStrings.searchDeleteHistorySuccess,
          englishMessage: ManagerStrings.searchDeleteHistorySuccessEn,
        );
      },
    );
  }

  Future<void> clearHistory() async {
    isDeletingAll.value = true;
    final result = await _clearHistoryUseCase.execute();
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (_) {
        history.clear();
        AppSnackbar.success(
          ManagerStrings.searchClearAllSuccess,
          englishMessage: ManagerStrings.searchClearAllSuccessEn,
        );
      },
    );
    isDeletingAll.value = false;
  }
}
