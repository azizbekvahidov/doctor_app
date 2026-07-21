import 'package:flutter/material.dart';

/// v2 corner radii.
class AppRadii {
  static const double card = 20;
  static const double input = 14;
  static const double pill = 9999;
  static const double sheet = 28;

  static BorderRadius get cardR => BorderRadius.circular(card);
  static BorderRadius get inputR => BorderRadius.circular(input);
  static BorderRadius get pillR => BorderRadius.circular(pill);
  static BorderRadius get sheetTop =>
      const BorderRadius.vertical(top: Radius.circular(sheet));
}

/// v2 elevation.
class AppShadows {
  // 0 8px 24px -14px rgba(23,26,31,.16)
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x29171A1F),
      offset: Offset(0, 8),
      blurRadius: 24,
      spreadRadius: -14,
    ),
  ];

  // 0 16px 40px -16px rgba(23,26,31,.24)
  static const List<BoxShadow> float = [
    BoxShadow(
      color: Color(0x3D171A1F),
      offset: Offset(0, 16),
      blurRadius: 40,
      spreadRadius: -16,
    ),
  ];
}
