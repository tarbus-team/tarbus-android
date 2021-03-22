import 'package:flutter/material.dart';

class ThemeUtils {
  static bool isDark(BuildContext context) {
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    var darkModeOn = brightness == Brightness.dark;
    if (darkModeOn) {
      return true;
    }
    return false;
  }
}
