import 'package:flutter/material.dart';

const COLOR_PRIMARY = Colors.deepOrangeAccent;
const COLOR_ACCENT = Colors.orange;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOR_PRIMARY,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.grey.withOpacity(0.1),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: Colors.white,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color?>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color?>(Colors.white),
  ),
);
