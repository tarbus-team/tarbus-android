import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/bottom_navigation_object.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_actual_view/schedule_actual_view.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_static_view/schedule_static_view.dart';

class FactoryScheduleViewController {
  int currentIndex;
  BusStop busStop;

  FactoryScheduleViewController({this.busStop}) {
    currentIndex = 0;
  }

  List<BottomNavigationObject> getBottomNavigationItemHolders() {
    return <BottomNavigationObject>[
      BottomNavigationObject(
        index: 0,
        route: ScheduleActualView(busStop: busStop),
        item: BottomNavigationBarItem(
          icon: Icon(Icons.bus_alert),
          label: 'Najbliższe odjazdy',
        ),
      ),
      BottomNavigationObject(
        index: 1,
        route: ScheduleStaticView(busStop: busStop),
        item: BottomNavigationBarItem(
          icon: Icon(Icons.web_outlined),
          label: 'Rozkład jazdy',
        ),
      ),
    ];
  }
}
