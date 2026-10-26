import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:app_mobile/constants/di/dependency_injection.dart';
import 'package:app_mobile/core/resources/manager_colors.dart';
import 'package:app_mobile/core/resources/manager_font_size.dart';
import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_radius.dart';
import 'package:app_mobile/core/resources/manager_strings.dart';
import 'package:app_mobile/core/resources/manager_styles.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:app_mobile/core/routes/routes.dart';
import 'package:app_mobile/core/service/location_service.dart';
import '../../domain/model/home_model.dart';
import '../../domain/use_case/get_nearby_tailors_use_case.dart';
import '../controller/nearby_tailors_map_controller.dart';

// ═══════════════════════════════════════════════════════════════════════════
// ── Screen
// ═══════════════════════════════════════════════════════════════════════════

class NearbyTailorsMapScreen extends StatefulWidget {
  final int limit;

  const NearbyTailorsMapScreen({
    super.key,
    this.limit = 5,
  });

  @override
  State<NearbyTailorsMapScreen> createState() => _NearbyTailorsMapScreenState();
}

class _NearbyTailorsMapScreenState extends State<NearbyTailorsMapScreen>
    with SingleTickerProviderStateMixin {
  late final NearbyTailorsMapController _controller;
  GoogleMapController? _mapController;

  BitmapDescriptor? _normalMarker;
  BitmapDescriptor? _selectedMarker;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      NearbyTailorsMapController(
        instance<GetNearbyTailorsUseCase>(),
        limit: widget.limit,
      ),
      tag: 'nearby_tailors_map',
    );
    _buildMarkerIcons();
    // Animate camera to user location once GPS resolves
    _controller.userLocation.listen((loc) {
      if (loc != null && _mapController != null) {
        _mapController!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(loc.latitude, loc.longitude),
              zoom: 13.8,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    if (Get.isRegistered<NearbyTailorsMapController>(
        tag: 'nearby_tailors_map')) {
      Get.delete<NearbyTailorsMapController>(tag: 'nearby_tailors_map');
    }
    super.dispose();
  }

  // ── Custom Marker Icons ─────────────────────────────────────────────────

  Future<void> _buildMarkerIcons() async {
    final normal = await _drawPinMarker(ManagerColors.primaryColor, false);
    final selected = await _drawPinMarker(ManagerColors.secondaryColor, true);
    if (mounted) {
      setState(() {
        _normalMarker = normal;
        _selectedMarker = selected;
      });
    }
  }

  Future<BitmapDescriptor> _drawPinMarker(Color color, bool isSelected) async {
    const double canvasW = 90.0;
    const double canvasH = 110.0;
    const double cx = canvasW / 2;
    const double circleR = 32.0;
    const double circleY = circleR + 6;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromLTWH(0, 0, canvasW, canvasH));

    // Drop shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(isSelected ? 0.25 : 0.18)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(cx + 1.5, circleY + 2), circleR, shadowPaint);

    // Outer ring (selected glow)
    if (isSelected) {
      final glowPaint = Paint()..color = color.withOpacity(0.22);
      canvas.drawCircle(Offset(cx, circleY), circleR + 8, glowPaint);
    }

    // Main circle
    canvas.drawCircle(Offset(cx, circleY), circleR, Paint()..color = color);

    // White inner circle
    canvas.drawCircle(
        Offset(cx, circleY), circleR * 0.52, Paint()..color = Colors.white);

    // Scissors icon path (simplified – two crossed pill shapes)
    _drawScissorsIcon(canvas, cx, circleY, circleR * 0.30, Colors.white, color);

    // Pin needle
    final needlePath = Path()
      ..moveTo(cx - 9, circleY + circleR - 4)
      ..lineTo(cx + 9, circleY + circleR - 4)
      ..lineTo(cx, canvasH - 6)
      ..close();
    canvas.drawPath(needlePath, Paint()..color = color);

    // Needle inner highlight
    final needleHighlight = Path()
      ..moveTo(cx - 4, circleY + circleR - 1)
      ..lineTo(cx + 4, circleY + circleR - 1)
      ..lineTo(cx, canvasH - 14)
      ..close();
    canvas.drawPath(
        needleHighlight, Paint()..color = Colors.white.withOpacity(0.25));

    final picture = recorder.endRecording();
    final img =
        await picture.toImage(canvasW.toInt(), canvasH.toInt());
    final bytes = await img.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  void _drawScissorsIcon(Canvas canvas, double cx, double cy, double size,
      Color bgColor, Color fgColor) {
    final p = Paint()
      ..color = fgColor
      ..strokeWidth = size * 0.28
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Blade 1 – top-left to bottom-right
    canvas.drawLine(
      Offset(cx - size * 0.7, cy - size * 0.5),
      Offset(cx + size * 0.7, cy + size * 0.5),
      p,
    );
    // Blade 2 – top-right to bottom-left
    canvas.drawLine(
      Offset(cx + size * 0.7, cy - size * 0.5),
      Offset(cx - size * 0.7, cy + size * 0.5),
      p,
    );
    // Center circle
    canvas.drawCircle(Offset(cx, cy), size * 0.22, Paint()..color = bgColor);
    canvas.drawCircle(Offset(cx, cy), size * 0.13, Paint()..color = fgColor);
  }

  // ── Markers ─────────────────────────────────────────────────────────────

  Set<Marker> _buildMarkers(
      List<HomeTailorModel> tailors, String? selectedId) {
    return tailors
        .where((t) => t.latitude != null && t.longitude != null)
        .map((tailor) {
      final isSelected = tailor.id == selectedId;
      return Marker(
        markerId: MarkerId(tailor.id),
        position: LatLng(tailor.latitude!, tailor.longitude!),
        icon: isSelected
            ? (_selectedMarker ?? BitmapDescriptor.defaultMarkerWithHue(40))
            : (_normalMarker ??
                BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueCyan)),
        zIndex: isSelected ? 1.0 : 0.0,
        onTap: () {
          _controller.selectTailorById(tailor.id);
          _animateToTailor(tailor);
        },
      );
    }).toSet();
  }

  Future<void> _animateToTailor(HomeTailorModel tailor) async {
    final lat = tailor.latitude;
    final lng = tailor.longitude;
    if (lat == null || lng == null || _mapController == null) return;
    await _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 15.5),
      ),
    );
  }

  // ── Initial camera position (center of Saudi Arabia until GPS resolves) ─
  static const CameraPosition _kSaudiCenter = CameraPosition(
    target: LatLng(23.8859, 45.0792),
    zoom: 5.5,
  );

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: ManagerColors.backgroundTabBar,
      body: SafeArea(
        top: false,
        bottom: true,
        child: Obx(() {
          final tailors = _controller.tailors;
          final selectedTailor = _controller.selectedTailor.value;
          final phase = _controller.loadingPhase.value;
          final isLoading = phase != MapLoadingPhase.idle;
          final selectedId = selectedTailor?.id;

          return Stack(
            children: [
              // ── Full-screen map ─────────────────────────────────────────
              Positioned.fill(
                child: GoogleMap(
                  initialCameraPosition: _kSaudiCenter,
                  onMapCreated: (c) {
                    _mapController = c;
                    // If location already resolved before map was ready
                    final loc = _controller.userLocation.value;
                    if (loc != null) {
                      c.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                            target: LatLng(loc.latitude, loc.longitude),
                            zoom: 13.8,
                          ),
                        ),
                      );
                    }
                  },
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  compassEnabled: false,
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  markers: _buildMarkers(tailors, selectedId),
                  onTap: (_) => _controller.selectedTailor.value = null,
                ),
              ),

              // ── Top gradient overlay ────────────────────────────────────
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: _TopOverlay(
                  topPad: topPad,
                  tailorCount: tailors.length,
                  loadingPhase: phase,
                  onRefresh: _controller.fetchNearbyTailors,
                ),
              ),

              // ── Bottom tailor card ──────────────────────────────────────
              AnimatedPositioned(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                left: 0,
                right: 0,
                bottom: selectedTailor != null ? 0 : -400,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 260),
                  opacity: selectedTailor != null ? 1.0 : 0.0,
                  child: selectedTailor != null
                      ? _TailorDetailCard(
                          key: ValueKey(selectedTailor.id),
                          tailor: selectedTailor,
                          onClose: () =>
                              _controller.selectedTailor.value = null,
                          onViewProfile: () {
                            final id = selectedTailor.id;
                            if (id.isNotEmpty) {
                              Navigator.pushNamed(
                                context,
                                Routes.tailorDetailsScreen,
                                arguments: id,
                              );
                            }
                          },
                        )
                      : const SizedBox.shrink(),
                ),
              ),

              // ── Loading overlay ─────────────────────────────────────────
              if (isLoading && tailors.isEmpty)
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: ManagerColors.white,
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                              color: ManagerColors.primaryColor),
                          SizedBox(height: ManagerHeight.h10),
                          Text(
                            phase == MapLoadingPhase.locating
                                ? ManagerStrings.locatingYou
                                : ManagerStrings.searchingTailors,
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s12,
                              color: ManagerColors.greyWhiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ── Top Overlay (floating header on map)
// ═══════════════════════════════════════════════════════════════════════════

class _TopOverlay extends StatelessWidget {
  final double topPad;
  final int tailorCount;
  final MapLoadingPhase loadingPhase;
  final VoidCallback onRefresh;

  const _TopOverlay({
    required this.topPad,
    required this.tailorCount,
    required this.loadingPhase,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.55),
            Colors.black.withOpacity(0.0),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
      padding: EdgeInsets.only(
        top: topPad + 8,
        left: ManagerWidth.w16,
        right: ManagerWidth.w16,
        bottom: ManagerHeight.h20,
      ),
      child: Row(
        children: [
          // Back button
          _CircleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          SizedBox(width: ManagerWidth.w12),

          // Title
          Expanded(
            child: Text(
              ManagerStrings.nearbyTailorsTitle,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Count chip
          if (tailorCount > 0) ...[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: ManagerWidth.w10,
                  vertical: ManagerHeight.h4),
              decoration: BoxDecoration(
                color: ManagerColors.secondaryColor,
                borderRadius: BorderRadius.circular(ManagerRadius.r20),
              ),
              child: Text(
                '$tailorCount ${ManagerStrings.tailorsCount}',
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s11,
                  color: ManagerColors.white,
                ),
              ),
            ),
            SizedBox(width: ManagerWidth.w8),
          ],

          // Refresh button (shows locating icon while GPS is resolving)
          _CircleButton(
            icon: loadingPhase == MapLoadingPhase.locating
                ? Icons.my_location_rounded
                : Icons.refresh_rounded,
            onTap: onRefresh,
            isLoading: loadingPhase != MapLoadingPhase.idle,
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isLoading;

  const _CircleButton({
    required this.icon,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.35), width: 1),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: ManagerColors.white,
                ),
              )
            : Icon(icon, color: ManagerColors.white, size: 18),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ── Rich Tailor Detail Card
// ═══════════════════════════════════════════════════════════════════════════

class _TailorDetailCard extends StatelessWidget {
  final HomeTailorModel tailor;
  final VoidCallback onClose;
  final VoidCallback onViewProfile;

  const _TailorDetailCard({
    super.key,
    required this.tailor,
    required this.onClose,
    required this.onViewProfile,
  });

  String _roleLabel(String role) {
    return switch (role) {
      'comprehensive_tailor' => ManagerStrings.comprehensiveTailorRole,
      'independent_tailor' => ManagerStrings.independentTailorRole,
      _ => role,
    };
  }

  @override
  Widget build(BuildContext context) {
    final dist = tailor.distanceKm;
    final distText =
        dist != null ? '${dist.toStringAsFixed(1)} ${ManagerStrings.kmUnit}' : '--';

    return Container(
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.14),
            blurRadius: 24,
            spreadRadius: 0,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Drag handle + close ───────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(
                top: ManagerHeight.h12,
                left: ManagerWidth.w16,
                right: ManagerWidth.w16),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: ManagerColors.greyWhiteColor.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color:
                          ManagerColors.greyWhiteColor.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: ManagerColors.greyWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Main content ──────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ManagerWidth.w20, vertical: ManagerHeight.h16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Profile row ─────────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with status ring
                    _AvatarWithStatus(
                      imageUrl: tailor.imageUrl,
                      isAvailable: tailor.isAvailable,
                    ),
                    SizedBox(width: ManagerWidth.w14),

                    // Info column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            tailor.name,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s15,
                              color: ManagerColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ManagerHeight.h4),

                          // Role + Availability badges
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: [
                              _Badge(
                                label: _roleLabel(tailor.role),
                                bg: ManagerColors.primaryColor
                                    .withOpacity(0.09),
                                fg: ManagerColors.primaryColor,
                              ),
                              _Badge(
                                label: tailor.isAvailable
                                    ? ManagerStrings.availableNow
                                    : ManagerStrings.unavailableNow,
                                bg: tailor.isAvailable
                                    ? const Color(0xFFE8F5E9)
                                    : ManagerColors.greyWhiteColor
                                        .withOpacity(0.12),
                                fg: tailor.isAvailable
                                    ? const Color(0xFF2E7D32)
                                    : ManagerColors.greyWhiteColor,
                                dot: true,
                                dotColor: tailor.isAvailable
                                    ? const Color(0xFF4CAF50)
                                    : ManagerColors.greyWhiteColor,
                              ),
                            ],
                          ),
                          SizedBox(height: ManagerHeight.h6),

                          // Rating row
                          Row(
                            children: [
                              ...List.generate(5, (i) {
                                final full = i < tailor.rating.floor();
                                final half = !full &&
                                    i < tailor.rating &&
                                    tailor.rating - i >= 0.5;
                                return Icon(
                                  full
                                      ? Icons.star_rounded
                                      : half
                                          ? Icons.star_half_rounded
                                          : Icons.star_outline_rounded,
                                  color: ManagerColors.secondaryColor,
                                  size: 16,
                                );
                              }),
                              SizedBox(width: ManagerWidth.w4),
                              Text(
                                '${tailor.rating.toStringAsFixed(1)}',
                                style: getBoldTextStyle(
                                  fontSize: ManagerFontSize.s12,
                                  color: ManagerColors.black,
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w4),
                              Text(
                                '(${tailor.reviewCount})',
                                style: getRegularTextStyle(
                                  fontSize: ManagerFontSize.s11,
                                  color: ManagerColors.greyWhiteColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ManagerHeight.h16),

                // ── Stats row ────────────────────────────────────────────
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ManagerHeight.h12,
                      horizontal: ManagerWidth.w8),
                  decoration: BoxDecoration(
                    color: ManagerColors.backgroundTabBar,
                    borderRadius:
                        BorderRadius.circular(ManagerRadius.r14),
                  ),
                  child: Row(
                    children: [
                      _StatItem(
                        icon: Icons.location_on_rounded,
                        iconColor: ManagerColors.primaryColor,
                        value: distText,
                        label: ManagerStrings.distanceLabel,
                      ),
                      _VertDivider(),
                      _StatItem(
                        icon: Icons.check_circle_outline_rounded,
                        iconColor: const Color(0xFF4CAF50),
                        value: '${tailor.completedOrdersCount}',
                        label: ManagerStrings.completedOrderLabel,
                      ),
                      _VertDivider(),
                      _StatItem(
                        icon: Icons.local_offer_outlined,
                        iconColor: ManagerColors.secondaryColor,
                        value: '${tailor.offersCount}',
                        label: ManagerStrings.viewLabel,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ManagerHeight.h16),

                // ── CTA Button ───────────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: ManagerHeight.h48,
                  child: ElevatedButton.icon(
                    onPressed: onViewProfile,
                    icon: const Icon(Icons.person_rounded, size: 18),
                    label: Text(
                      ManagerStrings.viewProfile,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s13,
                        color: ManagerColors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ManagerColors.primaryColor,
                      foregroundColor: ManagerColors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ManagerRadius.r14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ── Supporting Widgets
// ═══════════════════════════════════════════════════════════════════════════

class _AvatarWithStatus extends StatelessWidget {
  final String? imageUrl;
  final bool isAvailable;

  const _AvatarWithStatus(
      {required this.imageUrl, required this.isAvailable});

  @override
  Widget build(BuildContext context) {
    final bool hasImg = imageUrl != null &&
        imageUrl!.trim().isNotEmpty &&
        imageUrl != 'null';
    return Stack(
      children: [
        Container(
          width: 68,
          height: 68,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isAvailable
                  ? ManagerColors.primaryColor
                  : ManagerColors.greyWhiteColor.withOpacity(0.4),
              width: 2.5,
            ),
          ),
          child: ClipOval(
            child: hasImg
                ? CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 68,
                    height: 68,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) =>
                        _PersonPlaceholder(size: 68),
                  )
                : _PersonPlaceholder(size: 68),
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: isAvailable
                  ? const Color(0xFF4CAF50)
                  : ManagerColors.greyWhiteColor,
              shape: BoxShape.circle,
              border: Border.all(color: ManagerColors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}

class _PersonPlaceholder extends StatelessWidget {
  final double size;
  const _PersonPlaceholder({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: ManagerColors.primaryColor.withOpacity(0.08),
      alignment: Alignment.center,
      child: Icon(
        Icons.person_rounded,
        size: size * 0.5,
        color: ManagerColors.primaryColor.withOpacity(0.45),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final bool dot;
  final Color? dotColor;

  const _Badge({
    required this.label,
    required this.bg,
    required this.fg,
    this.dot = false,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w8, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (dot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                  color: dotColor ?? fg, shape: BoxShape.circle),
            ),
            SizedBox(width: ManagerWidth.w4),
          ],
          Text(
            label,
            style: getMediumTextStyle(
              fontSize: ManagerFontSize.s10,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatItem({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(height: ManagerHeight.h4),
          Text(
            value,
            style: getBoldTextStyle(
              fontSize: ManagerFontSize.s13,
              color: ManagerColors.black,
            ),
          ),
          SizedBox(height: ManagerHeight.h2),
          Text(
            label,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s10,
              color: ManagerColors.greyWhiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _VertDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 40,
      color: ManagerColors.greyWhiteColor.withOpacity(0.25),
    );
  }
}
