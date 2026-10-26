import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/storage/local/app_settings_prefs.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/shop_owner_home_model.dart';
import '../../domain/use_case/get_shop_owner_home_use_case.dart';
import '../../domain/use_case/change_shop_owner_availability_use_case.dart';

class ShopOwnerHomeController extends GetxController {
  final GetShopOwnerHomeUseCase _useCase;
  final ChangeShopOwnerAvailabilityUseCase _changeAvailabilityUseCase;
  final AppSettingsPrefs _prefs;

  ShopOwnerHomeController(
    this._useCase,
    this._changeAvailabilityUseCase,
    this._prefs,
  );

  // ── State ────────────────────────────────────────────────────────────────────

  /// True only during the very first fetch — drives the shimmer skeleton.
  final RxBool isFirstLoad = true.obs;

  /// True while any network request is in flight — drives the RefreshIndicator.
  final RxBool isLoading = false.obs;

  final Rxn<ShopOwnerHomeModel> homeData = Rxn();

  /// Reflects the shop open/closed status.
  final RxBool isShopOpen = false.obs;

  /// True while the availability toggle API call is in flight.
  final RxBool isChangingAvailability = false.obs;

  // ── Profile data from SharedPreferences (reactive so login switch updates UI)
  final RxString shopName = ''.obs;
  final RxnString shopLogoUrl = RxnString();

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    reloadShopIdentity();
    fetchHome();
  }

  /// Reloads shop name/logo from prefs (call after login / profile update).
  void reloadShopIdentity() {
    shopName.value = _prefs.getShopName();
    shopLogoUrl.value = _prefs.getShopLogo();
  }

  // ── Public API ────────────────────────────────────────────────────────────────

  /// First load — shows shimmer until data arrives.
  Future<void> fetchHome() async {
    isLoading.value = true;
    reloadShopIdentity();

    final Either<Failure, ShopOwnerHomeModel> result = await _useCase.execute();

    result.fold(
      (failure) {
        isFirstLoad.value = false;
        AppSnackbar.error(failure.message);
      },
      (data) {
        homeData.value = data;
        isShopOpen.value = data.isOpen;
        isFirstLoad.value = false;
      },
    );

    isLoading.value = false;
  }

  /// Pull-to-refresh — fast update, no shimmer.
  Future<void> refreshHome() async {
    isLoading.value = true;
    reloadShopIdentity();

    final Either<Failure, ShopOwnerHomeModel> result = await _useCase.execute();

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) {
        homeData.value = data;
        isShopOpen.value = data.isOpen;
      },
    );

    isLoading.value = false;
  }

  /// Toggles shop open/closed status via API.
  Future<void> changeAvailability(bool value) async {
    isChangingAvailability.value = true;
    final Either<Failure, bool> result =
        await _changeAvailabilityUseCase.execute(value);
    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (newValue) => isShopOpen.value = newValue,
    );
    isChangingAvailability.value = false;
  }

  // ── Helpers ───────────────────────────────────────────────────────────────────

  /// Returns lastLoginAt formatted as "DD-MM-YYYY".
  String get formattedLastLogin {
    final raw = homeData.value?.lastLoginAt;
    if (raw == null || raw.isEmpty) return '-';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return '${dt.day.toString().padLeft(2, '0')}-'
          '${dt.month.toString().padLeft(2, '0')}-'
          '${dt.year}';
    } catch (_) {
      return raw;
    }
  }

  /// Current balance as a formatted integer string (e.g. "4374").
  String get formattedBalance =>
      (homeData.value?.withdrawableBalance ?? 0).toStringAsFixed(0);

  /// Star rating as a formatted string (e.g. "4.5").
  String get formattedRating =>
      (homeData.value?.averageRating ?? 0).toStringAsFixed(1);

  int get reviewsCount => homeData.value?.reviewsCount ?? 0;
}
