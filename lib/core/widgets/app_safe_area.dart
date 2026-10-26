import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A platform-aware SafeArea wrapper.
///
/// On Android: [bottom] is always forced to `true`.
/// On iOS: [bottom] defaults to `false` (can be overridden).
class AppSafeArea extends StatelessWidget {
  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const AppSafeArea({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = false,
    this.left = true,
    this.right = true,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: defaultTargetPlatform == TargetPlatform.android ? true : bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}
