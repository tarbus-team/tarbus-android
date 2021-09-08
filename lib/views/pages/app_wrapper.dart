import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarbus_app/bloc/gps_cubit/gps_cubit.dart';
import 'package:tarbus_app/shared/router/routes.gr.dart';

class AppWrapper extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AppWrapper();
}

class _AppWrapper extends State<AppWrapper> {
  @override
  void initState() {
    context.read<GpsCubit>().initGps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AutoTabsScaffold(
          bottomNavigationBuilder: _buildBottomNav,
          routes: [
            AppHomeRoute(),
            AppBusLinesRoute(),
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
      unselectedFontSize: 11,
      selectedFontSize: 14,
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
