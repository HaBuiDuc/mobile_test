import 'package:flutter/material.dart';
import 'package:mobile_test/src/core/theme/color_palette.dart';

class AppTheme {
  static final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorPalette.white,
    appBarTheme: const AppBarTheme(backgroundColor: ColorPalette.white),
  );
}