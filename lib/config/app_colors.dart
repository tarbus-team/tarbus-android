import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/config/app_config.dart';

class AppColors {
  late final Color primaryColor;
  late final Color primaryLight;
  late final Color breakpoint;
  late final Color borderColor;
  late final Color fontColor;
  late final Color backgroundDark;
  late final Color headlineColor;

  static AppColors of(BuildContext context) {
    bool isDarkTheme = context.read<GetAppConfigUseCaseImpl>().isDarkTheme;
    if (isDarkTheme) {
      return AppColors.dark();
    }
    return AppColors.light();
  }

  AppColors.light() {
    primaryColor = Color(0xff014F9D);
    primaryLight = Color(0xffE6EDF5);
    breakpoint = Color(0xffE6EDF5);
    borderColor = Color(0xffD8D8D8);
    fontColor = Color(0xff000000);
    headlineColor = Color(0xff000000);
    backgroundDark = Color(0xffffffff);
  }

  AppColors.dark() {
    primaryColor = Color(0xff4f7acf);
    primaryLight = Color(0xff212121);
    headlineColor = Color(0xffffffff);
    borderColor = Color(0xFF000000);
    fontColor = Color(0xB3ffffff);
    backgroundDark = Color(0xff212121);
    breakpoint = Color.fromRGBO(80, 80, 80, 1);
  }
}
