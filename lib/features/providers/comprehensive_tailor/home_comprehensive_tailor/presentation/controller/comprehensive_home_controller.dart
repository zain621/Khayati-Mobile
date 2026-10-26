import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/comprehensive_home_model.dart';
import '../../domain/use_case/get_comprehensive_home_use_case.dart';
import '../../domain/use_case/change_availability_use_case.dart';

class ComprehensiveHomeController extends GetxController {
  final GetComprehensiveHomeUseCase _getHomeUseCase;
  final ChangeAvailabilityUseCase _changeAvailabilityUseCase;

  ComprehensiveHomeController(
    this._getHomeUseCase,
    this._changeAvailabilityUseCase,
  );

  // ── State ────────────────────────────────────────────────────────────────────

  /// True only on the very first fetch — drives the shimmer skeleton.
  final RxBool isFirstLoad = true.obs;

  /// True while the home data request is in flight — drives RefreshIndicator.
  final RxBool isLoading = false.obs;

  /// True while the availability PATCH is in flight — drives LoadingWidget overlay.
  final RxBool isChangingAvailability = false.obs;

  final Rxn<ComprehensiveHomeModel> homeData = Rxn();

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

    final Either<Failure, ComprehensiveHomeModel> result =
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

    final Either<Failure, ComprehensiveHomeModel> result =
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
          homeData.value = ComprehensiveHomeModel(
            fullName: homeData.value!.fullName,
            imageUrl: homeData.value!.imageUrl,
            withdrawableBalance: homeData.value!.withdrawableBalance,
            lastLoginAt: homeData.value!.lastLoginAt,
            averageRating: homeData.value!.averageRating,
            reviewsCount: homeData.value!.reviewsCount,
            rankLabel: homeData.value!.rankLabel,
            isAcceptingOrders: newValue,
            zoqakOrdersCount: homeData.value!.zoqakOrdersCount,
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
