import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:theme_provider/theme_provider.dart';
// import 'theme_constants.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

// if(data?.isEmpty ?? true)

// bool isEmpty(String? s) => s==null || s.isEmpty;

// widget?.cameras?.isEmpty == true