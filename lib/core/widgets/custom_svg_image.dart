import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// A reusable widget for displaying SVG images across the app.
///
/// Usage:
/// ```dart
/// CustomSvgImage(
///   path: 'assets/images/icon.svg',
///   width: 24,
///   height: 24,
///   color: Colors.blue,
/// )
/// ```
class CustomSvgImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  const CustomSvgImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
