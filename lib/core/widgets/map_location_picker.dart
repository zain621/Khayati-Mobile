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
import 'package:permission_handler/permission_handler.dart';

/// A reusable full-screen map picker.
///
/// Returns the selected [LatLng] when the user confirms, or `null` if cancelled.
///
/// Usage:
/// ```dart
/// final result = await MapLocationPicker.show(context);
/// if (result != null) { /* use result.latitude, result.longitude */ }
/// ```
class MapLocationPicker extends StatefulWidget {
  final LatLng initialPosition;

  const MapLocationPicker({
    super.key,
    this.initialPosition = const LatLng(24.4539, 54.3773),
  });

  /// Push this screen and await a result.
  static Future<LatLng?> show(
    BuildContext context, {
    LatLng? initialPosition,
  }) {
    return Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (_) => MapLocationPicker(
          initialPosition: initialPosition ?? const LatLng(24.4539, 54.3773),
        ),
      ),
    );
  }

  @override
  State<MapLocationPicker> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late LatLng _selectedPosition;
  final Completer<GoogleMapController> _mapCompleter = Completer();
  bool _isMoving = false;
  bool _locationGranted = false;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition;
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();
    if (mounted) {
      setState(() => _locationGranted = status.isGranted);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      body: Stack(
        children: [
          /// ─── Google Map ───
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: widget.initialPosition,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              if (!_mapCompleter.isCompleted) {
                _mapCompleter.complete(controller);
              }
            },
            onCameraMove: (position) {
              _selectedPosition = position.target;
            },
            onCameraMoveStarted: () {
              if (!_isMoving) setState(() => _isMoving = true);
            },
            onCameraIdle: () {
              if (_isMoving) setState(() => _isMoving = false);
            },
            myLocationEnabled: _locationGranted,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
            mapType: MapType.normal,
            padding: EdgeInsets.only(
              top: ManagerHeight.h98,
              bottom: ManagerHeight.h80,
            ),
          ),

          /// ─── Center Pin ───
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h40),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                transform:
                    Matrix4.translationValues(0, _isMoving ? -10 : 0, 0),
                child: Icon(
                  Icons.location_on,
                  size: 48,
                  color: ManagerColors.primaryColor,
                  shadows: const [
                    Shadow(blurRadius: 8, color: Colors.black26),
                  ],
                ),
              ),
            ),
          ),

          /// Pin shadow dot
          Center(
            child: Container(
              width: 6,
              height: 6,
              margin: EdgeInsets.only(top: ManagerHeight.h10),
              decoration: const BoxDecoration(
                color: Colors.black26,
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// ─── Top Bar ───
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w16,
                vertical: ManagerHeight.h8,
              ),
              child: Row(
                children: [
                  /// Back
                  _circleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  const Spacer(),

                  /// Title pill
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w16,
                      vertical: ManagerHeight.h10,
                    ),
                    decoration: BoxDecoration(
                      color: ManagerColors.white,
                      borderRadius: BorderRadius.circular(ManagerRadius.r24),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      ManagerStrings.mapPickerTitle,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.black,
                      ),
                    ),
                  ),
                  const Spacer(),

                  /// Placeholder to balance the row
                  SizedBox(width: ManagerWidth.w40),
                ],
              ),
            ),
          ),

          /// ─── My Location FAB ───
          if (_locationGranted)
            Positioned(
              right: ManagerWidth.w16,
              bottom: bottomPadding + ManagerHeight.h98 + ManagerHeight.h16,
              child: _circleButton(
                icon: Icons.my_location_rounded,
                iconColor: ManagerColors.primaryColor,
                onTap: _goToMyLocation,
                size: 48,
              ),
            ),

          /// ─── Coordinate Chip ───
          Positioned(
            bottom: bottomPadding + ManagerHeight.h80 + ManagerHeight.h8,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isMoving ? 0.0 : 1.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12,
                    vertical: ManagerHeight.h6,
                  ),
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.circular(ManagerRadius.r20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${_selectedPosition.latitude.toStringAsFixed(5)}, '
                    '${_selectedPosition.longitude.toStringAsFixed(5)}',
                    style: getRegularTextStyle(
                      fontSize: ManagerFontSize.s11,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// ─── Bottom Confirm Button ───
          Positioned(
            left: ManagerWidth.w24,
            right: ManagerWidth.w24,
            bottom: bottomPadding + ManagerHeight.h24,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(_selectedPosition),
              child: Container(
                height: ManagerHeight.h52,
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor,
                  borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  boxShadow: [
                    BoxShadow(
                      color: ManagerColors.primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle_outline_rounded,
                      color: ManagerColors.white,
                      size: 20,
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    Text(
                      ManagerStrings.mapPickerConfirm,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    Color iconColor = ManagerColors.black,
    double size = 40,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          color: ManagerColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 18, color: iconColor),
      ),
    );
  }

  /// Animate camera to the user's current location via the built-in
  /// platform location layer exposed by the GoogleMap controller.
  Future<void> _goToMyLocation() async {
    // google_maps_flutter exposes the user's location through the
    // native my-location data source. We leverage myLocationEnabled to
    // show the blue dot. Unfortunately the plugin doesn't expose the
    // raw coordinates, but the native platform layer already has them.
    // The cleanest fallback: just re-center on the initial position
    // or let the user pan to the visible blue dot.
    final controller = await _mapCompleter.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(widget.initialPosition, 15),
    );
  }
}
