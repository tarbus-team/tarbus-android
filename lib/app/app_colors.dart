import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tarbus2021/utils/theme_provider.dart';

class AppColors {
  Color primaryColor;
  Color primaryLightColor;

  Color mainFontColor;

  Color gray;
  Color lightGrey;
  Color darkGrey;
  Color darkGrey2;

  Color iconColor;
  Color listIconColor;
  Color staticTabBarColor;
  Color staticDeparturesNames;

  Color staticTabBarFontColorActive;
  Color staticTabBarFontColorUnactive;

  Color tommorowLabelColor;

  Color lineColor;
  Color homeLinkColor;

  static AppColors instance(BuildContext context) {
    if (MyTheme.isDark) {
      return AppColors.dark();
    }
    return AppColors.light();
  }

  AppColors.light() {
    primaryColor = Color.fromRGBO(28, 81, 153, 1);
    primaryLightColor = Color.fromRGBO(28, 81, 153, 1);
    mainFontColor = Color.fromRGBO(10, 10, 10, 1);
    gray = Color.fromRGBO(80, 80, 80, 1);
    lightGrey = Color.fromRGBO(230, 230, 230, 1);
    darkGrey = Color.fromRGBO(20, 20, 20, 1);
    darkGrey2 = Color.fromRGBO(50, 50, 50, 1);
    iconColor = Color.fromRGBO(10, 10, 10, 1);
    lineColor = Color.fromRGBO(230, 230, 230, 1);
    staticTabBarColor = Color.fromRGBO(255, 255, 255, 1);
    staticDeparturesNames = Color.fromRGBO(50, 50, 50, 1);
    staticTabBarFontColorActive = Color.fromRGBO(10, 10, 10, 1);
    staticTabBarFontColorUnactive = Color.fromRGBO(10, 10, 10, 1);
    homeLinkColor = primaryColor;
    tommorowLabelColor = primaryColor;
  }

  AppColors.dark() {
    primaryColor = Color.fromRGBO(28, 81, 153, 1);
    primaryLightColor = Color.fromRGBO(115, 164, 229, 1);
    mainFontColor = Colors.grey[200];
    gray = Color.fromRGBO(80, 80, 80, 1);
    lightGrey = Color.fromRGBO(80, 80, 80, 1);
    darkGrey = Color.fromRGBO(20, 20, 20, 1);
    darkGrey2 = Color.fromRGBO(80, 80, 80, 1);
    iconColor = Color.fromRGBO(255, 255, 255, 0.5);
    staticTabBarColor = Color.fromRGBO(46, 46, 46, 1);
    staticDeparturesNames = Color.fromRGBO(150, 150, 150, 1);
    lineColor = Color.fromRGBO(230, 230, 230, 1);
    homeLinkColor = mainFontColor;
    tommorowLabelColor = Color.fromRGBO(250, 250, 250, 1);
    staticTabBarFontColorActive = Color.fromRGBO(250, 250, 250, 1);
    staticTabBarFontColorUnactive = Color.fromRGBO(250, 250, 250, 1);
  }
}
