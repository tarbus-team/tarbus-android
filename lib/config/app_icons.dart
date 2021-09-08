import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  final BuildContext context;

  AppIcons(this.context);

  factory AppIcons.of(BuildContext context) {
    return AppIcons(context);
  }
  SvgPicture get busStopIcon => SvgPicture.asset(
        'assets/icons/icon_bus.svg',
        color: Colors.white,
        width: 20,
        height: 20,
      );
}
