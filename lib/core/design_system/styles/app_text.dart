import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// v2 type scale — Manrope. Ported from the I Need Doctor v2 design system.
///
/// letterSpacing values are the em values from the design converted to logical
/// pixels (e.g. -0.02em on 28px ≈ -0.56).
class AppText {
  static TextStyle _m({
    required double size,
    required FontWeight weight,
    double? height,
    double? letterSpacing,
    Color color = AppColors.ink,
  }) => GoogleFonts.manrope(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  static TextStyle get display => _m(
    size: 28,
    weight: FontWeight.w800,
    height: 1.2,
    letterSpacing: -0.56,
  );

  static TextStyle get title => _m(
    size: 20,
    weight: FontWeight.w800,
    height: 1.25,
    letterSpacing: -0.2,
  );

  static TextStyle get headline =>
      _m(size: 17, weight: FontWeight.w700, height: 1.3);

  static TextStyle get body =>
      _m(size: 15, weight: FontWeight.w500, height: 1.5);

  static TextStyle get bodyStrong =>
      _m(size: 15, weight: FontWeight.w700, height: 1.4);

  static TextStyle get caption =>
      _m(size: 13, weight: FontWeight.w500, height: 1.4, color: AppColors.ink2);

  static TextStyle get micro => _m(
    size: 11,
    weight: FontWeight.w700,
    letterSpacing: 0.6,
    color: AppColors.ink3,
  );

  /// Global Manrope text theme, applied at the app root.
  static TextTheme textTheme(TextTheme base) =>
      GoogleFonts.manropeTextTheme(base);
}
