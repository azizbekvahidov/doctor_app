import 'package:flutter/material.dart';

/// v2 design tokens — "calm medical-fintech" palette.
///
/// Ported from the I Need Doctor v2 design system. The legacy names from the
/// v1 (teal) palette are kept as aliases at the bottom, remapped to the nearest
/// v2 token, so screens not yet migrated keep compiling and pick up the new look.
class AppColors {
  // Brand
  static const Color primary = Color(0xFF2D5BE3);
  static const Color primaryPress = Color(0xFF234BC4);
  static const Color primaryTint = Color(0xFFEAF0FE);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // Ink (text)
  static const Color ink = Color(0xFF191A1E);
  static const Color ink2 = Color(0xFF70747C);
  static const Color ink3 = Color(0xFFA5A8AF);

  // Surfaces
  static const Color bg = Color(0xFFF7F5F2); // warm stone app background
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surface2 = Color(0xFFF1EFEA);
  static const Color border = Color(0xFFECE9E4);

  // Semantic
  static const Color success = Color(0xFF189E6C);
  static const Color successTint = Color(0xFFE7F6EF);
  static const Color warning = Color(0xFFE8A23D);
  static const Color warningTint = Color(0xFFFBF3E4);
  static const Color danger = Color(0xFFE5484D);
  static const Color dangerTint = Color(0xFFFDEBEC);
  static const Color star = Color(0xFFF5A623);

  static const Color white = Colors.white;

  // --- Legacy v1 aliases (remapped to v2 tokens) ---------------------------
  static const Color bottomItemColor = primary;
  static const Color messageBubble = primary;
  static const Color sendIcon = primary;
  static const Color grey = ink3;
  static const Color red = danger;
  static const Color lightGray = border;
  static const Color subTitleDark = ink2;
  static const Color subTitleLight = ink3;
  static const Color subtitleSecond = ink3;
}
