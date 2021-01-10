import 'package:flutter/material.dart';
import 'package:tarbus2021/src/views/splash_screen_view/splash_screen_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tarBUS',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenView(),
    );
  }
}
