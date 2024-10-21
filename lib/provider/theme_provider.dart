
import 'package:flutter/material.dart';

import '../main.dart';

class ThemeProvider extends ChangeNotifier {
  String themeMode = preferences.getString("themeMode") ?? "System";

  void changeTheme(String mode) {
    themeMode = mode;
    preferences.setString("themeMode", mode);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    String themeMode = preferences.getString("themeMode") ?? "System";
    if (themeMode == "Dark") {
      return ThemeMode.dark;
    }
    if (themeMode == "Light") {
      return ThemeMode.light;
    }

    return ThemeMode.system;
  }
}
