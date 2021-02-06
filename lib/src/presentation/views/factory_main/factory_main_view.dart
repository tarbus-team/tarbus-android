import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus2021/src/model/entity/app_start_settings.dart';
import 'package:tarbus2021/src/providers/navigation_provider.dart';

class FactoryMainView extends StatelessWidget {
  static const route = '/';
  final AppStartSettings appStartSettings;

  const FactoryMainView({Key key, this.appStartSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        // Create bottom navigation bar items from screens.
        final bottomNavigationBarItems =
            provider.screens.map((screen) => BottomNavigationBarItem(icon: Icon(screen.icon), label: screen.title)).toList();

        // Initialize [Navigator] instance for each screen.
        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();
        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: Scaffold(
            drawer: Drawer(
              child: Text("Test"),
            ),
            body: IndexedStack(
              children: screens,
              index: provider.currentTabIndex,
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              items: bottomNavigationBarItems,
              currentIndex: provider.currentTabIndex,
              onTap: provider.setTab,
            ),
          ),
        );
      },
    );
  }
}
