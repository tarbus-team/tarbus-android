import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/config/app_config.dart';

class AppColors {
  late final Color primaryColor;
  late final Color primaryLight;
  late final Color primaryLightDarker;
  late final Color borderColor;

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
    primaryLightDarker = Color(0xffCFDDEC);
    borderColor = Color(0xffD8D8D8);
  }

  AppColors.dark() {
    primaryColor = Color(0xff014F9D);
    primaryLight = Color(0xffE6EDF5);
    primaryLightDarker = Color(0xffCFDDEC);
    borderColor = Color(0xffD8D8D8);
  }
}
