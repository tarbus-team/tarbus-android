import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/config/app_config.dart';
import 'package:tarbus_app/config/locator.dart';
import 'package:tarbus_app/config/providers.dart';
import 'package:tarbus_app/config/theme.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';
import 'package:tarbus_app/data/storage_model/subscribed_version_model.dart';
import 'package:tarbus_app/shared/guards/gps_guard.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

import 'generated/l10n.dart';

Future<void> setUpHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(SubscribedVersionModelAdapter());
  Hive.registerAdapter(SavedBusStopModelAdapter());
  Hive.registerAdapter(SavedBusLineModelAdapter());

  await Hive.openBox("configuration");
  await Hive.openBox<SavedBusStopModel>('favourite_bus_stops');
  await Hive.openBox<SavedBusLineModel>('favourite_bus_lines');
  await Hive.openBox<SubscribedVersionModel>('subscribed_versions');
}

Future main() async {
  await initLocator();
  // await initUniLinks();
  // var res = await Hive.openBox<TokenModel>('token');
  // res.clear();

  // TODO - If error
  await setUpHive();

  GestureBinding.instance!.resamplingEnabled = true;

  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pl_PL';
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // setPathUrlStrategy();
  runApp(ChangeNotifierProvider.value(
    value: getIt<GetAppConfigUseCaseImpl>(),
    child: MultiProvider(
      providers: appProviders,
      child: CoreApp(),
    ),
  ));
}

class CoreApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoreApp();
}

class _CoreApp extends State<CoreApp> {
  final appRouter = AppRouter(gpsGuard: GpsGuard());

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<GetAppConfigUseCaseImpl>().initConfig();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetAppConfigUseCaseImpl>(builder: (context, value, child) {
      return MaterialApp.router(
        routeInformationParser: appRouter.defaultRouteParser(),
        routerDelegate: appRouter.delegate(),
        debugShowCheckedModeBanner: false,
        locale: Locale(context.read<GetAppConfigUseCaseImpl>().locale!,
            context.read<GetAppConfigUseCaseImpl>().locale!.toUpperCase()),
        theme: context.read<GetAppConfigUseCaseImpl>().themeData,
        builder: (context, routerWidget) {
          return routerWidget as Widget;
        },
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
      );
    });
  }
}
