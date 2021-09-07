import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tarbus_app/config/app_colors.dart';

class AppIcons {
  final BuildContext context;

  AppIcons(this.context);

  factory AppIcons.of(BuildContext context) {
    return AppIcons(context);
  }
  get busStopIcon => SvgPicture.asset(
        'assets/icons/icon_bus.svg',
        color: AppColors.of(context).fontColor,
        width: 20,
        height: 20,
      );
}
