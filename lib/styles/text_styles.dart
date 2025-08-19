import 'package:flutter/material.dart';

abstract class WorkSansStyle {
  static const String fontFamily = 'WorkSans';

  // HEADLINES
  static const TextStyle headline1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 1.3,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.3,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.3,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.3,
  );

  // TITLES
  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 1.4,
  );

  // BODY TEXT
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.5,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
  );

  // LABELS
  static const TextStyle labelLarge = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 16,
    letterSpacing: 0.5,
  );

  static const TextStyle label = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.5,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    letterSpacing: 0.5,
  );

  // CAPTION / HINT TEXT
  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.grey,
  );

  // OVERLINE / TAGS
  static const TextStyle overline = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
    letterSpacing: 1.0,
    color: Colors.grey,
  );

  static const TextStyle overlineLight = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 11,
    color: Colors.black,
  );
}
