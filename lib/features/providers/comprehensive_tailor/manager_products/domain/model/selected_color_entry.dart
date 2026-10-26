import 'package:flutter/material.dart';

/// Represents a color entry selected for a product (name + hex code).
class SelectedColorEntry {
  final String nameAr;
  final String hexCode;

  const SelectedColorEntry({required this.nameAr, required this.hexCode});

  /// Convert hex string to Flutter [Color].
  Color toColor() {
    try {
      final hex = hexCode.trim().replaceAll('#', '');
      return Color(int.parse('FF$hex', radix: 16));
    } catch (_) {
      return const Color(0xFF9E9E9E);
    }
  }

  /// Returns the hex code normalized to "#RRGGBB" uppercase format.
  String get cleanHex {
    final h = hexCode.trim().toUpperCase();
    return h.startsWith('#') ? h : '#$h';
  }

  @override
  bool operator ==(Object other) =>
      other is SelectedColorEntry &&
      other.hexCode.toUpperCase() == hexCode.toUpperCase();

  @override
  int get hashCode => hexCode.toUpperCase().hashCode;
}
