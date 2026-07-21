import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Legacy type scale, now backed by Manrope (v2 design system).
///
/// The class keeps its original name and member set so screens that haven't
/// been migrated to [AppText] still restyle to the new font. New code should
/// prefer `AppText`.
abstract class WorkSansStyle {
  static TextStyle _m(
    double size,
    FontWeight weight, {
    double? height,
    double? letterSpacing,
    Color? color,
  }) => GoogleFonts.manrope(
    fontSize: size,
    fontWeight: weight,
    height: height,
    letterSpacing: letterSpacing,
    color: color,
  );

  // HEADLINES
  static TextStyle get headline1 => _m(32, FontWeight.w800, height: 1.2);
  static TextStyle get headline2 => _m(28, FontWeight.w800, height: 1.2);
  static TextStyle get headline3 => _m(24, FontWeight.w700, height: 1.25);
  static TextStyle get headline4 => _m(20, FontWeight.w700, height: 1.25);
  static TextStyle get headline5 => _m(16, FontWeight.w700, height: 1.3);

  // TITLES
  static TextStyle get titleLarge => _m(22, FontWeight.w700, height: 1.3);
  static TextStyle get titleMedium => _m(18, FontWeight.w600, height: 1.35);
  static TextStyle get titleSmall => _m(16, FontWeight.w600, height: 1.4);

  // BODY
  static TextStyle get bodyLarge => _m(18, FontWeight.w500, height: 1.5);
  static TextStyle get body => _m(16, FontWeight.w500, height: 1.5);
  static TextStyle get bodySmall => _m(14, FontWeight.w500, height: 1.4);

  // LABELS
  static TextStyle get labelLarge =>
      _m(16, FontWeight.w700, letterSpacing: 0.2);
  static TextStyle get label => _m(14, FontWeight.w600, letterSpacing: 0.2);
  static TextStyle get labelSmall => _m(12, FontWeight.w600, letterSpacing: 0.2);

  // CAPTION / OVERLINE
  static TextStyle get caption =>
      _m(12, FontWeight.w500, color: const Color(0xFFA5A8AF));
  static TextStyle get overline => _m(
    10,
    FontWeight.w700,
    letterSpacing: 1.0,
    color: const Color(0xFFA5A8AF),
  );
  static TextStyle get overlineLight =>
      _m(11, FontWeight.w500, color: const Color(0xFF191A1E));
}
