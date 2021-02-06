import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/presentation/views/splash_screen/splash_screen_view.dart';
import 'package:tarbus2021/src/providers/navigation_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _fontFamily = 'Roboto';

  @override
  Widget build(BuildContext context) {
    ThemeData _darkTheme = ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        textTheme: Typography.material2018().white,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      primaryColor: AppColors.primaryColor,
      accentColor: AppColors.lightGrey,
      brightness: Brightness.dark,
      fontFamily: _fontFamily,
      textTheme: TextTheme(),
      iconTheme: IconThemeData(color: Colors.black87),
    );

    ThemeData _lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.light,
        textTheme: Typography.material2018().black,
        iconTheme: const IconThemeData(color: Colors.black87),
        actionsIconTheme: const IconThemeData(color: Colors.black87),
      ),
      accentColor: AppColors.lightGrey,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      fontFamily: _fontFamily,
      textTheme: TextTheme(),
      iconTheme: IconThemeData(color: Colors.black87),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Splash Sample',
            debugShowCheckedModeBanner: false,
            theme: _lightTheme,
            home: SplashScreenView(),
            onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
          );
        },
      ),
    );
  }
}
