import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/app_start_settings.dart';
import 'package:tarbus2021/model/entity/bus_line.dart';
import 'package:tarbus2021/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/model/entity/screen.dart';
import 'package:tarbus2021/model/entity/track.dart';
import 'package:tarbus2021/presentation/views/bus_lines/bus_lines_view.dart';
import 'package:tarbus2021/presentation/views/bus_map/bus_map_view.dart';
import 'package:tarbus2021/presentation/views/bus_routes/bus_routes_view.dart';
import 'package:tarbus2021/presentation/views/factory_main/factory_main_view.dart';
import 'package:tarbus2021/presentation/views/home/home_view.dart';
import 'package:tarbus2021/presentation/views/schedule/factory_schedule_view.dart';
import 'package:tarbus2021/presentation/views/search/search_view.dart';

const firstScreen = 0;
const secondScreen = 1;
const thirdScreen = 2;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = firstScreen;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.route:
        return MaterialPageRoute<void>(builder: (_) => HomeView());
      case BusLinesView.route:
        return MaterialPageRoute<void>(builder: (_) => BusLinesView());
      case SearchView.route:
        return MaterialPageRoute<void>(builder: (_) => SearchView());
      case BusRoutesView.route:
        return MaterialPageRoute<void>(builder: (_) => BusRoutesView(busLine: settings.arguments as BusLine));
      case FactoryScheduleView.route:
        var args = settings.arguments as BusStopArgumentsHolder;
        return PageRouteBuilder<void>(
            pageBuilder: (context, animation1, animation2) {
              return FactoryScheduleView(busStop: args.busStop, busLineFilter: args.busLineFilter);
            },
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 0));
      case '/start':
        return MaterialPageRoute<void>(
            builder: (_) => FactoryMainView(appStartSettings: settings.arguments as AppStartSettings));
      case '/map':
        return MaterialPageRoute<void>(builder: (_) => BusMapView(track: settings.arguments as Track));
      default:
        return MaterialPageRoute<void>(builder: (_) => FactoryMainView());
    }
  }

  final Map<int, Screen> _screens = {
    firstScreen: Screen(
      title: AppString.bottomNavigationHome,
      icon: Icons.home_outlined,
      child: HomeView(),
      initialRoute: HomeView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute<void>(builder: (_) => HomeView());
        }
      },
      scrollController: ScrollController(),
    ),
    secondScreen: Screen(
      title: AppString.bottomNavigationBusLines,
      icon: Icons.timeline_outlined,
      child: BusLinesView(),
      initialRoute: BusLinesView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute<void>(builder: (_) => BusLinesView());
        }
      },
      scrollController: ScrollController(),
    ),
    thirdScreen: Screen(
      title: AppString.bottomNavigationSearch,
      icon: Icons.search_outlined,
      child: SearchView(),
      initialRoute: SearchView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute<void>(builder: (_) => SearchView());
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen get currentScreen => _screens[_currentScreenIndex];

  /// Set currently visible tab.
  void setTab(int tab) {
    final currentNavigatorState = currentScreen.navigatorState.currentState;
    if (tab == currentTabIndex) {
      if (currentNavigatorState.canPop()) {
        while (currentNavigatorState.canPop()) {
          currentNavigatorState.pop();
        }
      }
      notifyListeners();
    } else {
      while (currentNavigatorState.canPop()) {
        currentNavigatorState.pop();
      }
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// Provide this to [WillPopScope] callback.
  Future<bool> onWillPop(BuildContext context) async {
    final currentNavigatorState = currentScreen.navigatorState.currentState;

    if (currentNavigatorState.canPop()) {
      currentNavigatorState.pop();
      return false;
    } else {
      if (currentTabIndex != firstScreen) {
        setTab(firstScreen);
        notifyListeners();
        return false;
      }
      return true;
    }
  }
}
