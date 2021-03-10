import 'package:flutter/material.dart';

class ThemeUtils {
  static bool isDark(BuildContext context) {
    var brightness = MediaQuery.platformBrightnessOf(context);
    var darkModeOn = brightness == Brightness.dark;
    if (darkModeOn) {
      return true;
    }
    return false;
  }
}
