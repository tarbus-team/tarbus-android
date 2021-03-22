import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/presentation/custom_widgets/app_circular_progress_indicator.dart';
import 'package:tarbus2021/presentation/views/schedule/schedule_static_view/schedule_static_item.dart';

import 'controller/schedule_static_view_controller.dart';

class ScheduleStaticView extends StatefulWidget {
  final BusStop busStop;
  final TabController parentTabController;

  const ScheduleStaticView({Key key, this.busStop, this.parentTabController}) : super(key: key);

  @override
  _ScheduleStaticViewState createState() => _ScheduleStaticViewState();
}

class _ScheduleStaticViewState extends State<ScheduleStaticView> with SingleTickerProviderStateMixin {
  final ScheduleStaticViewController viewController = ScheduleStaticViewController();
  bool swipeStatus;
  List<List<String>> displayedDayTypes = [
    ScheduleStaticViewController.workDays,
    ScheduleStaticViewController.freeDays,
    ScheduleStaticViewController.holidayDays,
  ];

  bool loadingStatus = true;
  TabController _tabController;
  DragStartDetails startVerticalDragDetails;
  DragUpdateDetails updateVerticalDragDetails;

  @override
  void initState() {
    swipeStatus = false;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
    _tabController = TabController(length: 3, vsync: this);
  }

  void update() async {
    if (await viewController.getRoutesByBusStopId(widget.busStop.id)) {
      setState(() {
        loadingStatus = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            pinned: false,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10.0), // here the desired height
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.instance(context).lightGrey,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: SizedBox(
                          height: 33,
                          child: TabBar(
                            controller: _tabController,
                            indicatorColor: Colors.indigo,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                              color: AppColors.instance(context).staticTabBarColor,
                            ),
                            labelColor: AppColors.instance(context).staticTabBarFontColorActive,
                            unselectedLabelColor: AppColors.instance(context).staticTabBarFontColorUnactive,
                            labelPadding: const EdgeInsets.all(0),
                            labelStyle: TextStyle(
                              fontSize: 13.0,
                            ),
                            isScrollable: true,
                            tabs: [
                              _buildDayButton(
                                days: ScheduleStaticViewController.workDays,
                                title: 'Dni robocze',
                              ),
                              _buildDayButton(
                                days: ScheduleStaticViewController.freeDays,
                                title: 'Soboty',
                              ),
                              _buildDayButton(
                                days: ScheduleStaticViewController.holidayDays,
                                title: 'Święta',
                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildStaticSchedule(days: ScheduleStaticViewController.workDays),
          _buildStaticSchedule(days: ScheduleStaticViewController.freeDays),
          _buildStaticSchedule(days: ScheduleStaticViewController.holidayDays),
        ],
      ),
    );
  }

  Widget _buildDayButton({List<String> days, String title, bool isLast = false}) {
    var _borderColor = isLast ? Colors.transparent : Colors.black12;
    return Container(
      width: (MediaQuery.of(context).size.width / 3) - 13,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(width: isLast ? 0 : 1.0, color: _borderColor),
        ),
      ),
      child: Center(
        child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(title),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticSchedule({List<String> days}) {
    if (loadingStatus) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.6,
        child: AppCircularProgressIndicator(),
      );
    } else {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragStart: (dragDetails) {
          startVerticalDragDetails = dragDetails;
        },
        onHorizontalDragUpdate: (dragDetails) {
          updateVerticalDragDetails = dragDetails;
        },
        onHorizontalDragEnd: (endDetails) {
          var dx = updateVerticalDragDetails.globalPosition.dx - startVerticalDragDetails.globalPosition.dx;
          var dy = updateVerticalDragDetails.globalPosition.dy - startVerticalDragDetails.globalPosition.dy;
          var velocity = endDetails.primaryVelocity;

          if (dx < 0) dx = -dx;
          if (dy < 0) dy = -dy;

          if (velocity < 0) {
            if (_tabController.index < _tabController.length) {
              _tabController.animateTo(_tabController.index + 1);
            }
          } else {
            if (_tabController.index >= 1) {
              _tabController.animateTo(_tabController.index - 1);
            } else if (_tabController.index == 0) {
              widget.parentTabController.animateTo(0);
            }
          }
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: viewController.routesFromBusStop.length,
            itemBuilder: (BuildContext context, int index) {
              var trackRoute = viewController.routesFromBusStop[index];
              return ScheduleStaticItem(trackRoute: trackRoute, dayTypes: days, busStopId: widget.busStop.id);
            },
          ),
        ),
      );
    }
  }
}
