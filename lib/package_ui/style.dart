import 'package:flutter/material.dart';

// Font
const String fontName = 'Asap';

// Title sizes
const titleLargeTextSize = 32.0;
const titleMediumTextSize = 24.0;
const titleSmallTextSize = 16.0;

// Body sizes
const bodyLargeTextSize = 24.0;
const bodyMediumTextSize = 18.0;
const bodySmallTextSize = 12.0;

// Title styles
const titleLargeTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w800,
    fontSize: titleLargeTextSize,
    color: Colors.black);

const titleMediumTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: titleMediumTextSize,
    color: Colors.black);

const titleSmallTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w700,
    fontSize: titleSmallTextSize,
    color: Colors.black);

// Body styles
const bodyLargeTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w600,
    fontSize: bodyLargeTextSize,
    color: Colors.black);

const bodyMediumTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: bodyMediumTextSize,
    color: Colors.black);

const bodySmallTextStyle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w500,
    fontSize: bodySmallTextSize,
    color: Colors.black);

// App theme
ThemeData appTheme = ThemeData(
  colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF1E3264),
      onPrimary: Colors.white,
      secondary: Color(0xFF00C8BE),
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.black,
      background: Colors.white,
      onBackground: Color(0xFF1E3264),
      surface: Color(0xFF1E3264),
      onSurface: Color(0xFF1E3264)),
  textTheme: const TextTheme(
    titleLarge: titleLargeTextStyle,
    titleMedium: titleMediumTextStyle,
    titleSmall: titleSmallTextStyle,
    bodyLarge: bodyLargeTextStyle,
    bodyMedium: bodyMediumTextStyle,
    bodySmall: bodySmallTextStyle,
  ),
);
