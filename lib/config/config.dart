import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  AppConfig({
    @required this.centerMapCoords,
    @required this.darkThemeColors,
    @required this.brandColors,
    @required this.themeColors,
    @required Widget child,
  }) : super(child: child);

  final LatLng centerMapCoords;
  final BrandColors brandColors;
  final MaterialColor themeColors;
  final MaterialColor darkThemeColors;

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class BrandColors {
  Color primary;
  Color secondary;

  BrandColors({@required this.primary, @required this.secondary});
}
