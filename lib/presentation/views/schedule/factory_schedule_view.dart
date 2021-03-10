import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/presentation/custom_widgets/appbar_title.dart';
import 'package:tarbus2021/presentation/custom_widgets/favourites_bus_stop_icon.dart';
import 'package:tarbus2021/presentation/views/schedule/schedule_actual_view/schedule_actual_view.dart';
import 'package:tarbus2021/presentation/views/schedule/schedule_static_view/schedule_static_view.dart';
import 'package:tarbus2021/presentation/views/schedule/schedule_tab_item.dart';

import 'controller/factory_schedule_view_controller.dart';

class FactoryScheduleView extends StatefulWidget {
  static const route = '/scheduleView';
  final BusStop busStop;
  final String busLineFilter;

  const FactoryScheduleView({Key key, this.busStop, this.busLineFilter}) : super(key: key);

  @override
  _FactoryScheduleViewState createState() => _FactoryScheduleViewState();
}

class _FactoryScheduleViewState extends State<FactoryScheduleView> with SingleTickerProviderStateMixin {
  FactoryScheduleViewController viewController;
  TabController _tabController;

  @override
  void initState() {
    viewController = FactoryScheduleViewController();
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FavouritesBusStopIcon(busStop: widget.busStop),
        ],
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            AppBarTitle(
              title: AppString.titleSchedule,
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  widget.busStop.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              TabBar(
                controller: _tabController,
                indicatorColor: Colors.indigo,
                labelColor: AppColors.instance(context).mainFontColor,
                physics: AlwaysScrollableScrollPhysics(),
                indicatorSize: TabBarIndicatorSize.label,
                labelPadding: const EdgeInsets.symmetric(vertical: 8.0),
                labelStyle: TextStyle(
                  fontSize: 14.0,
                ),
                isScrollable: true,
                tabs: [
                  ScheduleTabItem(title: AppString.labelNextDepartures),
                  ScheduleTabItem(title: AppString.labelAllDepartures),
                ],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ScheduleActualView(
            busStop: widget.busStop,
            busLineFilter: widget.busLineFilter,
          ),
          ScheduleStaticView(
            parentTabController: _tabController,
            busStop: widget.busStop,
          ),
        ],
      ),
    );
  }
}
