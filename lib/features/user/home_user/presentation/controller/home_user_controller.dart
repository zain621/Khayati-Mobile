import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/service/location_service.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import '../../domain/model/home_model.dart';
import '../../domain/use_case/get_home_use_case.dart';
import '../../domain/use_case/get_nearby_tailors_use_case.dart';

class HomeUserController extends GetxController {
  final GetHomeUseCase _getHomeUseCase;
  final GetNearbyTailorsUseCase _getNearbyTailorsUseCase;
  final AppSettingsPrefs _appSettingsPrefs;

  HomeUserController(
    this._getHomeUseCase,
    this._getNearbyTailorsUseCase,
    this._appSettingsPrefs,
  );
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxBool hasLoadedOnce = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<HomeProductModel> products = <HomeProductModel>[].obs;
  final RxList<HomeShopModel> shops = <HomeShopModel>[].obs;
  final RxList<HomeTailorModel> tailors = <HomeTailorModel>[].obs;
  final RxList<HomeTailorModel> nearbyTailors = <HomeTailorModel>[].obs;
  final RxInt availableTailorsCount = 0.obs;

  /// True when the first load failed and there is nothing to show yet — the
  /// screen should render a full error/retry state instead of empty sections.
  bool get isEmpty =>
      products.isEmpty &&
      shops.isEmpty &&
      tailors.isEmpty &&
      nearbyTailors.isEmpty;

  // ── User info (loaded from local storage) ──
  final RxString userName = ''.obs;
  final RxString userAvatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserInfo();
    fetchHome();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Load user info from local prefs
  // ─────────────────────────────────────────────────────────────────────────
  void _loadUserInfo() {
    userName.value = _appSettingsPrefs.getUserFullName();
    userAvatar.value = _appSettingsPrefs.getUserImage() ?? '';
  }

  /// Reloads user name and avatar from SharedPrefs and pushes the new values
  /// reactively to any listening widget (e.g. the Home app bar).
  /// Called silently after a successful profile update.
  void reloadUserInfo() => _loadUserInfo();

  // ─────────────────────────────────────────────────────────────────────────
  // Fetch home data
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> fetchHome() async {
    final bool firstLoad = !hasLoadedOnce.value;
    if (firstLoad) {
      isLoading.value = true;
      hasError.value = false;
    }
    try {
      final Either<Failure, HomeModel> result = await _getHomeUseCase.execute();
      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          hasError.value = true;
          // Only nag with a snackbar when content is already on screen
          // (e.g. a failed pull-to-refresh). On a blank first load the
          // inline error/retry state carries the message instead.
          if (hasLoadedOnce.value) AppSnackbar.error(failure.message);
        },
        (data) {
          hasError.value = false;
          errorMessage.value = '';
          hasLoadedOnce.value = true;
          products.assignAll(data.latestProducts);
          shops.assignAll(data.shops);
          tailors.assignAll(data.bestTailors);
          nearbyTailors.assignAll(data.nearbyTailors);
          availableTailorsCount.value = data.availableTailorsCount;
        },
      );
    } finally {
      isLoading.value = false;
    }
    // GPS must not block the dashboard or keep the shimmer spinning.
    if (hasLoadedOnce.value) {
      unawaited(_fetchNearbyTailorsPreview());
    }
  }

  Future<void> _fetchNearbyTailorsPreview() async {
    try {
      final location = await LocationService.resolve();
      final result = await _getNearbyTailorsUseCase.execute(
        latitude: location.latitude,
        longitude: location.longitude,
        limit: 5,
      );

      result.fold(
        (_) {},
        (data) {
          nearbyTailors.assignAll(data.items);
          if (availableTailorsCount.value <= 0) {
            availableTailorsCount.value = data.items.length;
          }
        },
      );
    } catch (_) {
      // Nearby preview is optional — home content should still show.
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Pull-to-refresh: also refreshes loyalty points if controller is alive
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> refreshHome() async {
    _loadUserInfo();
    await fetchHome();
    _refreshLoyaltyIfRegistered();
  }

  void _refreshLoyaltyIfRegistered() {
    // Deferred import to avoid circular dependency — loyalty controller is
    // only alive when the loyalty screen is open, but if we are on home
    // and it's registered we trigger a refresh.
    try {
      final loyaltyCtrl = Get.find(tag: 'LoyaltyController');
      // ignore: avoid_dynamic_calls
      loyaltyCtrl.fetchLoyaltyPoints();
    } catch (_) {
      // LoyaltyController not registered — nothing to refresh
    }
  }
}
