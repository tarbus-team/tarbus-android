import 'dart:async';

import 'package:flutter/material.dart';

import '../../main.dart';
// custom
import '../config.dart';

bool get isInDebugMode {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig configuredApp = new AppConfig(
    brandColors: BrandColors(primary: Color.fromRGBO(28, 81, 153, 1), secondary: Color.fromRGBO(255, 255, 255, 1)),
    themeColors: MaterialColor(0xFF1C5199, {
      50: Color.fromRGBO(28, 81, 153, 1),
      100: Color.fromRGBO(28, 81, 153, 0.2),
      200: Color.fromRGBO(28, 81, 153, .3),
      300: Color.fromRGBO(28, 81, 153, .4),
      400: Color.fromRGBO(28, 81, 153, .5),
      500: Color.fromRGBO(28, 81, 153, .6),
      600: Color.fromRGBO(28, 81, 153, .7),
      700: Color.fromRGBO(28, 81, 153, .8),
      800: Color.fromRGBO(28, 81, 153, .9),
      900: Color.fromRGBO(28, 81, 153, 1),
    }),
    darkThemeColors: MaterialColor(0xFF1C5199, {
      50: Color.fromRGBO(28, 81, 153, 1),
      100: Color.fromRGBO(28, 81, 153, 0.2),
      200: Color.fromRGBO(28, 81, 153, .3),
      300: Color.fromRGBO(28, 81, 153, .4),
      400: Color.fromRGBO(28, 81, 153, .5),
      500: Color.fromRGBO(28, 81, 153, .6),
      600: Color.fromRGBO(28, 81, 153, .7),
      700: Color.fromRGBO(28, 81, 153, .8),
      800: Color.fromRGBO(28, 81, 153, .9),
      900: Color.fromRGBO(28, 81, 153, 1),
    }),
    child: MyApp(),
  );

  // This captures errors reported by the Flutter framework.
  FlutterError.onError = (FlutterErrorDetails details) async {
    if (isInDebugMode) {
      // In development mode simply print to console.
      FlutterError.dumpErrorToConsole(details);
    } else {
      // In production mode report to the application zone to report to
      // Sentry.
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(() async {
    runApp(configuredApp);
  }, onError: (error, stackTrace) async {
    print("Run error");
  });
}
