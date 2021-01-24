import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/presentation/views/splash_screen/splash_screen_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppString.appInfoApplicationName,
      debugShowCheckedModeBanner: Settings.isDevelop,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Asap',
      ),
      home: SplashScreenView(),
    );
  }
}
