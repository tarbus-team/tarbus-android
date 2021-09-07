import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tarbus_app/config/theme.dart';

abstract class _GetAppConfigUseCase {
  Future getConfig();

  Future initConfig();

  Future changeLang(String? lang);

  Future updateTheme(ThemeMode mode);
}

class GetAppConfigUseCaseImpl extends ChangeNotifier
    implements _GetAppConfigUseCase {
  GetAppConfigUseCaseImpl() {
    getConfig();
  }

  /// Locator can be called here for services or any desired instance
  bool isLoading = true;
  bool isDarkTheme = false;
  late Box? prefs;
  late Map<String, dynamic> appConfig;
  late ThemeData themeData;
  String? locale;

  @override
  Future initConfig() async {
    try {
      await getConfig();
      updateTheme(ThemeMode.light);
      notifyListeners();
    } catch (err) {
      print("Error located at loading the configuration : $err");
      notifyListeners();
      return err;
    }
  }

  /// Private properties
  Future getConfig() async {
    try {
      prefs = Hive.box('configuration');
      locale = prefs!.get("language", defaultValue: "en");
      await refreshListeners();
      notifyListeners();
    } catch (err) {
      print("Error located at getting configuration : $err");

      return err;
    }
  }

  Future<void> refreshListeners() async {
    String themeModeString = prefs!.get("theme_mode", defaultValue: false);
    late ThemeMode themeMode;
    ThemeMode.values.forEach((e) {
      if (e.toString() == themeModeString) {
        themeMode = e;
      }
    });
    isDarkTheme = themeMode == ThemeMode.dark;
    themeData = isDarkTheme ? darkTheme : lightTheme;
  }

  @override
  Future changeLang(String? lang) async {
    try {
      prefs = Hive.box('configuration');
      await prefs!.put("language", lang!);
      await initConfig();
      notifyListeners();
    } catch (err) {
      print("Error located at changing the language : $err");
      return err;
    }
  }

  @override
  Future updateTheme(ThemeMode mode) async {
    try {
      prefs = Hive.box('configuration');
      prefs!.put("theme_mode", mode.toString());
      refreshListeners();
      notifyListeners();
    } catch (err) {
      print("Error located at updating the theme : $err");
      notifyListeners();
      return err;
    }
  }
}
