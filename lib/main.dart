import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/config/config.dart';
import 'package:tarbus2021/presentation/views/splash_screen/splash_screen_view.dart';
import 'package:tarbus2021/utils/config_storage.dart';
import 'package:tarbus2021/utils/navigation_provider.dart';
import 'package:tarbus2021/utils/theme_provider.dart';

void main() {
  runApp(MyApp());
}

AppConfig config;

getConfig(context) {
  config = AppConfig.of(context);
  ConfigStorage().init(config);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => MyTheme()),
    ], child: MyAppWithTheme());
  }
}

class MyAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<MyTheme>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: Builder(
        builder: (context) {
          return FutureBuilder(
              future: theme.currentTheme(context),
              builder: (context, snapshot) {
                return MaterialApp(
                  title: AppString.appInfoApplicationName,
                  debugShowCheckedModeBanner: false,
                  onGenerateRoute: NavigationProvider.of(context).onGenerateRoute,
                  themeMode: snapshot.data,
                  home: SplashScreenView(),
                  darkTheme: ThemeData(
                    primaryColor: AppConfig.of(context).brandColors.primary,
                    accentColor: AppConfig.of(context).themeColors.shade200,
                    brightness: Brightness.dark,
                    primarySwatch: AppConfig.of(context).themeColors,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: TextTheme(
                      bodyText1: TextStyle(fontSize: 11, fontFamily: 'Futura PT'),
                      bodyText2: TextStyle(fontSize: 13, fontFamily: 'Futura PT'),
                      headline1: TextStyle(
                          fontFamily: 'Futura PT', fontWeight: FontWeight.w700, color: Colors.grey[200], fontSize: 30),
                      headline2: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[200], fontSize: 15),
                      headline3: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[200], fontSize: 23),
                      headline4: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[200], fontSize: 14),
                      headline5: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[200], fontSize: 22),
                      headline6: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[200], fontSize: 18),
                    ),
                    appBarTheme: AppBarTheme(
                      brightness: Brightness.dark,
                      textTheme: Typography.material2018().white,
                      iconTheme: const IconThemeData(color: Colors.white),
                      actionsIconTheme: const IconThemeData(color: Colors.white),
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      selectedItemColor: AppConfig.of(context).brandColors.secondary,
                      selectedLabelStyle: TextStyle(
                        color: AppConfig.of(context).brandColors.secondary,
                      ),
                      selectedIconTheme: IconThemeData(
                        color: AppConfig.of(context).brandColors.secondary,
                      ),
                    ),
                  ),
                  theme: ThemeData(
                    primaryColor: AppConfig.of(context).brandColors.primary,
                    brightness: Brightness.light,
                    primarySwatch: AppConfig.of(context).themeColors,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    textTheme: TextTheme(
                      bodyText1: TextStyle(fontSize: 11, fontFamily: 'Futura PT'),
                      bodyText2: TextStyle(fontSize: 13, fontFamily: 'Futura PT'),
                      headline1: TextStyle(
                          fontFamily: 'Futura PT', fontWeight: FontWeight.w700, color: Colors.grey[800], fontSize: 30),
                      headline2: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[500], fontSize: 15),
                      headline3: TextStyle(fontFamily: 'Futura PT', color: Colors.black, fontSize: 23),
                      headline4: TextStyle(
                        fontFamily: 'Futura PT',
                        color: AppColors.instance(context).mainFontColor,
                        fontSize: 18,
                      ),
                      headline5: TextStyle(fontFamily: 'Futura PT', color: Colors.grey[700], fontSize: 22),
                      headline6: TextStyle(fontFamily: 'Futura PT', color: Colors.black, fontSize: 18),
                      subtitle2: TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 12),
                    ),
                    appBarTheme: AppBarTheme(
                      brightness: Brightness.light,
                      textTheme: Typography.material2018().black,
                      iconTheme: const IconThemeData(color: Colors.black87),
                      actionsIconTheme: const IconThemeData(color: Colors.black87),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
