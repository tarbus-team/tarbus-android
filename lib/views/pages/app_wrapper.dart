import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class AppWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AutoTabsScaffold(
          bottomNavigationBuilder: _buildBottomNav,
          routes: [
            AppHomeRoute(),
            AppBusLinesWrapper(),
            AppMapRoute(),
            AppSearchRoute(),
            AppMenuRoute(),
          ],
        ),
      ),
    );
  }

  BottomNavigationBar _buildBottomNav(
      BuildContext context, TabsRouter tabsRouter) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      elevation: 10,
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedLabelStyle: TextStyle(
        fontSize: 12,
      ),
      unselectedItemColor: Color(0xFFBCC5D3),
      onTap: (index) {
        if (index == tabsRouter.activeIndex) {
          tabsRouter.popTop();
        } else {
          tabsRouter.setActiveIndex(index);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timeline_outlined),
          label: 'Linie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map_rounded),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.search),
          label: 'Szukaj',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
      ],
    );
  }
}
