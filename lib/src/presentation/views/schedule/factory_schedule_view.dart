import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/bottom_navigation_object.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';

import 'controller/factory_schedule_view_controller.dart';

class FactoryScheduleView extends StatefulWidget {
  final BusStop busStop;
  const FactoryScheduleView({Key key, this.busStop}) : super(key: key);

  @override
  _FactoryScheduleViewState createState() => _FactoryScheduleViewState();
}

class _FactoryScheduleViewState extends State<FactoryScheduleView> {
  FactoryScheduleViewController viewController;

  @override
  void initState() {
    viewController = FactoryScheduleViewController(busStop: widget.busStop);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewController.getBottomNavigationItemHolders()[viewController.currentIndex].route,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.primaryColor,
        selectedFontSize: 12,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: viewController.currentIndex,
        items: viewController
            .getBottomNavigationItemHolders()
            .map((BottomNavigationObject bottomNavigationObject) => bottomNavigationObject.item)
            .toList(),
        onTap: (index) {
          setState(() {
            viewController.currentIndex = index;
          });
        },
      ),
    );
  }
}
