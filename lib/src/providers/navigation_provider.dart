import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/screen.dart';
import 'package:tarbus2021/src/presentation/views/bus_lines/bus_lines_view.dart';
import 'package:tarbus2021/src/presentation/views/bus_routes/bus_routes_view.dart';
import 'package:tarbus2021/src/presentation/views/factory_main/factory_main_view.dart';
import 'package:tarbus2021/src/presentation/views/home/home_view.dart';
import 'package:tarbus2021/src/presentation/views/schedule/factory_schedule_view.dart';
import 'package:tarbus2021/src/presentation/views/search/search_view.dart';

const FIRST_SCREEN = 0;
const SECOND_SCREEN = 1;
const THIRD_SCREEN = 2;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) => Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = FIRST_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeView.route:
        return MaterialPageRoute(builder: (_) => HomeView());
      case BusLinesView.route:
        return MaterialPageRoute(builder: (_) => BusLinesView());
      case SearchView.route:
        return MaterialPageRoute(builder: (_) => SearchView());
      case BusRoutesView.route:
        return MaterialPageRoute(builder: (_) => BusRoutesView(busLine: settings.arguments));
      case FactoryScheduleView.route:
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return FactoryScheduleView(busStop: settings.arguments);
            },
            transitionsBuilder: (context, animation1, animation2, child) {
              return FadeTransition(
                opacity: animation1,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 0));
      case '/start':
        return MaterialPageRoute(builder: (_) => FactoryMainView(appStartSettings: settings.arguments));
      default:
        return MaterialPageRoute(builder: (_) => FactoryMainView());
    }
  }

  final Map<int, Screen> _screens = {
    FIRST_SCREEN: Screen(
      title: AppString.bottomNavigationHome,
      icon: Icons.home_outlined,
      child: HomeView(),
      initialRoute: HomeView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => HomeView());
        }
      },
      scrollController: ScrollController(),
    ),
    SECOND_SCREEN: Screen(
      title: AppString.bottomNavigationBusLines,
      icon: Icons.timeline_outlined,
      child: BusLinesView(),
      initialRoute: BusLinesView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => BusLinesView());
        }
      },
      scrollController: ScrollController(),
    ),
    THIRD_SCREEN: Screen(
      title: AppString.bottomNavigationSearch,
      icon: Icons.search_outlined,
      child: SearchView(),
      initialRoute: SearchView.route,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(builder: (_) => SearchView());
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
      if (currentTabIndex != FIRST_SCREEN) {
        setTab(FIRST_SCREEN);
        notifyListeners();
        return false;
      }
      return false;
    }
  }
}
