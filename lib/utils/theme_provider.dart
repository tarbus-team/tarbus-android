import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tarbus2021/utils/theme_utils.dart';

class MyTheme extends ChangeNotifier {
  static bool isDark = false;

  Future<ThemeMode> currentTheme(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (ThemeUtils.isDark(context)) {
      isDark = true;
    }
    if (prefs.containsKey('dark_mode') && prefs.getBool('dark_mode') != null) {
      isDark = prefs.getBool('dark_mode');
    }
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() async {
    isDark = !isDark;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('dark_mode', isDark);
    notifyListeners();
  }
}
