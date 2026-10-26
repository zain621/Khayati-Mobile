import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/independent_tailor_home_model.dart';
import '../../domain/use_case/get_independent_tailor_home_use_case.dart';
import '../../domain/use_case/change_independent_tailor_availability_use_case.dart';

class IndependentTailorHomeController extends GetxController {
  final GetIndependentTailorHomeUseCase _getHomeUseCase;
  final ChangeIndependentTailorAvailabilityUseCase _changeAvailabilityUseCase;

  IndependentTailorHomeController(
    this._getHomeUseCase,
    this._changeAvailabilityUseCase,
  );

  // ── State ────────────────────────────────────────────────────────────────────

  /// True only on the very first fetch — drives the shimmer skeleton.
  final RxBool isFirstLoad = true.obs;

  /// True while the home data request is in flight — drives RefreshIndicator.
  final RxBool isLoading = false.obs;

  /// True while the availability PATCH is in flight.
  final RxBool isChangingAvailability = false.obs;

  final Rxn<IndependentTailorHomeModel> homeData = Rxn();

  // ── Lifecycle ────────────────────────────────────────────────────────────────

  @override
  void onInit() {
    super.onInit();
    fetchHome();
  }

  // ── Public API ────────────────────────────────────────────────────────────────

  /// First load — shows shimmer until data arrives.
  Future<void> fetchHome() async {
    isLoading.value = true;

    final Either<Failure, IndependentTailorHomeModel> result =
        await _getHomeUseCase.execute();

    result.fold(
      (failure) {
        isFirstLoad.value = false;
        AppSnackbar.error(failure.message);
      },
      (data) {
        homeData.value = data;
        isFirstLoad.value = false;
      },
    );

    isLoading.value = false;
  }

  /// Pull-to-refresh — fast update, no shimmer.
  Future<void> refreshHome() async {
    isLoading.value = true;

    final Either<Failure, IndependentTailorHomeModel> result =
        await _getHomeUseCase.execute();

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (data) => homeData.value = data,
    );

    isLoading.value = false;
  }

  /// Toggle accepting-orders status via PATCH API.
  Future<void> changeAvailability(bool value) async {
    isChangingAvailability.value = true;

    final Either<Failure, bool> result =
        await _changeAvailabilityUseCase.execute(value);

    result.fold(
      (failure) => AppSnackbar.error(failure.message),
      (newValue) {
        if (homeData.value != null) {
          final d = homeData.value!;
          homeData.value = IndependentTailorHomeModel(
            fullName: d.fullName,
            imageUrl: d.imageUrl,
            withdrawableBalance: d.withdrawableBalance,
            lastLoginAt: d.lastLoginAt,
            averageRating: d.averageRating,
            reviewsCount: d.reviewsCount,
            rankLabel: d.rankLabel,
            isAcceptingOrders: newValue,
            isAvailable: d.isAvailable,
            zoqakOrdersCount: d.zoqakOrdersCount,
            zoqakAvailableForOffersCount: d.zoqakAvailableForOffersCount,
            reviews: d.reviews,
          );
        }
      },
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
}
