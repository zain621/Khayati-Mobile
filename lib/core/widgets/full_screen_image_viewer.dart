import 'package:app_mobile/core/resources/manager_height.dart';
import 'package:app_mobile/core/resources/manager_width.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Opens a polished full-screen, zoomable, swipeable image gallery.
///
/// Reusable across the app wherever network images need a tap-to-preview
/// experience (tailor offers, portfolios, order galleries, …).
///
/// * Pinch / double-tap to zoom (via [InteractiveViewer]).
/// * Horizontal swipe to move between images.
/// * Tap the dimmed background or the close button to dismiss.
Future<void> showImagePreview(
  BuildContext context, {
  required List<String> images,
  int initialIndex = 0,
}) {
  if (images.isEmpty) return Future.value();
  final start = initialIndex.clamp(0, images.length - 1);
  return Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.black,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 220),
      reverseTransitionDuration: const Duration(milliseconds: 180),
      pageBuilder: (_, animation, __) => FadeTransition(
        opacity: animation,
        child: FullScreenImageViewer(images: images, initialIndex: start),
      ),
    ),
  );
}

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({
    super.key,
    required this.images,
    this.initialIndex = 0,
  });

  @override
  State<FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late final PageController _page;
  late final TransformationController _zoom;
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialIndex;
    _page = PageController(initialPage: widget.initialIndex);
    _zoom = TransformationController();
  }

  @override
  void dispose() {
    _page.dispose();
    _zoom.dispose();
    super.dispose();
  }

  void _onPageChanged(int i) {
    // Reset any active zoom when moving to another image.
    _zoom.value = Matrix4.identity();
    setState(() => _current = i);
  }

  @override
  Widget build(BuildContext context) {
    final hasMultiple = widget.images.length > 1;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // ── Image pager (tap on empty area dismisses) ──────────────────
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: PageView.builder(
              controller: _page,
              itemCount: widget.images.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (_, i) => InteractiveViewer(
                transformationController: i == _current ? _zoom : null,
                minScale: 1,
                maxScale: 4,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: widget.images[i],
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const Center(
                      child: SizedBox(
                        width: 28,
                        height: 28,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      ),
                    ),
                    errorWidget: (_, __, ___) => const Icon(
                      Icons.broken_image_outlined,
                      color: Colors.white54,
                      size: 48,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // ── Counter (e.g. "2 / 5") ─────────────────────────────────────
          if (hasMultiple)
            Positioned(
              top: MediaQuery.of(context).padding.top + ManagerHeight.h10,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w12,
                    vertical: ManagerHeight.h4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${_current + 1} / ${widget.images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

          // ── Close button ───────────────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + ManagerHeight.h8,
            right: ManagerWidth.w16,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),

          // ── Dots indicator ─────────────────────────────────────────────
          if (hasMultiple)
            Positioned(
              bottom: MediaQuery.of(context).padding.bottom + ManagerHeight.h24,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.images.length,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _current ? 18 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: i == _current
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
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
