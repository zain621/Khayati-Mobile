import 'package:geolocator/geolocator.dart';

// ═══════════════════════════════════════════════════════════════════════════
// Fallback coordinates (Abu Dhabi, UAE) used only when the device
// location is unavailable or the user denies permission.
// ═══════════════════════════════════════════════════════════════════════════
const double _kFallbackLatitude = 24.4539;
const double _kFallbackLongitude = 54.3773;

class LatLngPoint {
  final double latitude;
  final double longitude;
  final bool isDeviceLocation;

  const LatLngPoint({
    required this.latitude,
    required this.longitude,
    required this.isDeviceLocation,
  });

  const LatLngPoint.fallback()
      : latitude = _kFallbackLatitude,
        longitude = _kFallbackLongitude,
        isDeviceLocation = false;
}

// ═══════════════════════════════════════════════════════════════════════════
// LocationService
// ─────────────────────────────────────────────────────────────────────────
// Resolves the device's current location. On permission denial or service
// unavailability, returns the fallback coordinates so the app never blocks.
// ═══════════════════════════════════════════════════════════════════════════
class LocationService {
  LocationService._();

  /// Returns the device's current [LatLngPoint].
  ///
  /// Never throws — on any error the [LatLngPoint.fallback] is returned.
  static Future<LatLngPoint> resolve() async {
    try {
      // ── 1. Check if location services are enabled on the device ──────
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return const LatLngPoint.fallback();

      // ── 2. Check / request permission ────────────────────────────────
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        return const LatLngPoint.fallback();
      }

      // ── 3. Fetch position ─────────────────────────────────────────────
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LatLngPoint(
        latitude: position.latitude,
        longitude: position.longitude,
        isDeviceLocation: true,
      );
    } catch (_) {
      return const LatLngPoint.fallback();
    }
  }
}
