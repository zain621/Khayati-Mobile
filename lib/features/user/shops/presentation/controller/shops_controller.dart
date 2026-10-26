import 'package:get/get.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/shop_model.dart';
import '../../domain/use_case/get_shops_use_case.dart';
import '../../domain/use_case/get_top_shops_use_case.dart';

class ShopsController extends GetxController {
  final GetShopsUseCase _getShopsUseCase;
  final GetTopShopsUseCase _getTopShopsUseCase;

  ShopsController(this._getShopsUseCase, this._getTopShopsUseCase);

  // ── Shops list ─────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxList<ShopModel> shops = <ShopModel>[].obs;
  final RxList<AdModel> ads = <AdModel>[].obs;
  final RxInt total = 0.obs;

  // ── Top shops ──────────────────────────────────────────────────────────────
  final RxBool isTopLoading = false.obs;
  final RxList<TopShopModel> topShops = <TopShopModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchShops();
    fetchTopShops();
  }

  Future<void> fetchShops() async {
    isLoading.value = true;

    final result = await _getShopsUseCase.execute();

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) {
        shops.assignAll(data.items);
        ads.assignAll(data.ads);
        total.value = data.total;
      },
    );

    isLoading.value = false;
  }

  Future<void> fetchTopShops() async {
    isTopLoading.value = true;

    final result = await _getTopShopsUseCase.execute();

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) {
        topShops.assignAll(data.items);
      },
    );

    isTopLoading.value = false;
  }

  Future<void> refreshShops() async {
    await Future.wait([fetchShops(), fetchTopShops()]);
  }
}
