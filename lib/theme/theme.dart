import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
      // background: Colors.grey.shade400,
      primary: Colors.blue[200]!,
      secondary: Colors.blue[50]!,
      tertiary: Colors.blue[60]),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
  ),
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    // background: Colors.grey.shade900,
    primary: Color(0xFF6B8A7A),
    secondary: Color(0xFFDAD3BE),
    tertiary: Color(0xFF254336),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
  ),
);
