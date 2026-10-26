import 'dart:async';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

/// Result returned when the user picks a location on the map.
class MapPickerResult {
  final double latitude;
  final double longitude;
  final String displayText;

  MapPickerResult({
    required this.latitude,
    required this.longitude,
    required this.displayText,
  });
}

class MapPickerScreen extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const MapPickerScreen({super.key, this.initialLatitude, this.initialLongitude});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final Completer<GoogleMapController> _mapController = Completer();

  // Default to Abu Dhabi, UAE
  static const _defaultLat = 24.4539;
  static const _defaultLng = 54.3773;

  late LatLng _selectedPosition;
  bool _isLocating = true;

  @override
  void initState() {
    super.initState();
    _selectedPosition = LatLng(
      widget.initialLatitude ?? _defaultLat,
      widget.initialLongitude ?? _defaultLng,
    );
    if (widget.initialLatitude == null) {
      _goToCurrentLocation();
    } else {
      _isLocating = false;
    }
  }

  Future<void> _goToCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        setState(() => _isLocating = false);
        return;
      }
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      if (!mounted) return;
      final newPos = LatLng(position.latitude, position.longitude);
      setState(() {
        _selectedPosition = newPos;
        _isLocating = false;
      });
      final controller = await _mapController.future;
      if (!mounted) return;
      controller.animateCamera(CameraUpdate.newLatLng(newPos));
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLocating = false);
    }
  }

  void _onCameraMove(CameraPosition position) {
    _selectedPosition = position.target;
  }

  void _confirmLocation() {
    final result = MapPickerResult(
      latitude: _selectedPosition.latitude,
      longitude: _selectedPosition.longitude,
      displayText:
          '${_selectedPosition.latitude.toStringAsFixed(5)}, ${_selectedPosition.longitude.toStringAsFixed(5)}',
    );
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Map ─────────────────────────────────────────────────────────
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) => _mapController.complete(controller),
            onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            mapType: MapType.normal,
          ),

          // ── Center pin ──────────────────────────────────────────────────
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Icon(
                Icons.location_on,
                size: 48,
                color: ManagerColors.primaryColor,
              ),
            ),
          ),

          // ── Back button ─────────────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 12,
            right: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: ManagerWidth.w42,
                height: ManagerHeight.h42,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.circular(ManagerRadius.r10),
                  boxShadow: [
                    BoxShadow(
                      color: ManagerColors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: const Icon(Icons.close_rounded, color: ManagerColors.black),
              ),
            ),
          ),

          // ── My location button ──────────────────────────────────────────
          Positioned(
            bottom: 100,
            right: 16,
            child: GestureDetector(
              onTap: _goToCurrentLocation,
              child: Container(
                width: ManagerWidth.w48,
                height: ManagerHeight.h48,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ManagerColors.black.withOpacity(0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: _isLocating
                    ? Padding(
                        padding: const EdgeInsets.all(12),
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: ManagerColors.primaryColor,
                        ),
                      )
                    : const Icon(Icons.my_location, color: ManagerColors.primaryColor),
              ),
            ),
          ),

          // ── Confirm button ──────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: ManagerColors.white,
              padding: EdgeInsets.fromLTRB(
                ManagerWidth.w16,
                ManagerHeight.h12,
                ManagerWidth.w16,
                MediaQuery.of(context).padding.bottom + ManagerHeight.h12,
              ),
              child: GestureDetector(
                onTap: _confirmLocation,
                child: Container(
                  height: ManagerHeight.h48,
                  decoration: BoxDecoration(
                    color: ManagerColors.primaryColor,
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  ),
                  child: Center(
                    child: Text(
                      ManagerStrings.mapPickerConfirm,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s15,
                        color: ManagerColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
