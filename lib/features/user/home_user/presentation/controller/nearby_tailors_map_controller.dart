import 'package:get/get.dart';
import 'package:app_mobile/core/error_handler/failure.dart';
import 'package:app_mobile/core/service/location_service.dart';
import 'package:app_mobile/core/util/app_snack_bar.dart';
import '../../domain/model/home_model.dart';
import '../../domain/use_case/get_nearby_tailors_use_case.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Loading phases shown in the UI
// ═══════════════════════════════════════════════════════════════════════════
enum MapLoadingPhase { idle, locating, fetching }

class NearbyTailorsMapController extends GetxController {
  final GetNearbyTailorsUseCase _getNearbyTailorsUseCase;
  final int limit;

  NearbyTailorsMapController(
    this._getNearbyTailorsUseCase, {
    this.limit = 5,
  });

  // ── State ────────────────────────────────────────────────────────────────
  final Rx<MapLoadingPhase> loadingPhase = MapLoadingPhase.locating.obs;
  final RxList<HomeTailorModel> tailors = <HomeTailorModel>[].obs;
  final Rxn<HomeTailorModel> selectedTailor = Rxn<HomeTailorModel>();
  final RxDouble radiusKm = 0.0.obs;

  // ── Resolved coordinates (updated after GPS resolves) ────────────────────
  final Rxn<LatLngPoint> userLocation = Rxn<LatLngPoint>();

  bool get isLoading => loadingPhase.value != MapLoadingPhase.idle;

  @override
  void onInit() {
    super.onInit();
    _resolveLocationAndFetch();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Step 1: resolve GPS → Step 2: fetch tailors
  // ─────────────────────────────────────────────────────────────────────────
  Future<void> _resolveLocationAndFetch() async {
    // Phase 1 – locate device
    loadingPhase.value = MapLoadingPhase.locating;
    final location = await LocationService.resolve();
    userLocation.value = location;

    // Phase 2 – fetch nearby tailors with resolved coords
    await _doFetch(location);
  }

  Future<void> _doFetch(LatLngPoint location) async {
    loadingPhase.value = MapLoadingPhase.fetching;
    try {
      final result = await _getNearbyTailorsUseCase.execute(
        latitude: location.latitude,
        longitude: location.longitude,
        limit: limit,
      );
      result.fold(
        (Failure failure) {
          AppSnackbar.error(failure.message);
          tailors.clear();
          selectedTailor.value = null;
        },
        (data) {
          tailors.assignAll(data.items);
          radiusKm.value = data.radiusKm;
          selectedTailor.value = null; // let user tap to select
        },
      );
    } finally {
      loadingPhase.value = MapLoadingPhase.idle;
    }
  }

  // ── Manual refresh (re-resolves location each time) ─────────────────────
  Future<void> fetchNearbyTailors() async {
    await _resolveLocationAndFetch();
  }

  void selectTailorById(String tailorId) {
    for (final tailor in tailors) {
      if (tailor.id == tailorId) {
        selectedTailor.value = tailor;
        return;
      }
    }
  }
}
