import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/timetable_departures_cubit/timetable_departures_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/pages/departures_page/timetable_list_item.dart';
import 'package:tarbus_app/views/widgets/generic/center_load_spinner.dart';
import 'package:tarbus_app/views/widgets/generic/keep_alive_page.dart';

class AllDeparturesTab extends StatefulWidget {
  final int busStopId;
  final String? busStopName;
  final BusLine? busLine;
  final TabController parentTabController;

  const AllDeparturesTab({
    Key? key,
    this.busStopName,
    required this.busStopId,
    required this.parentTabController,
    this.busLine,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AllDeparturesTab();
}

class _AllDeparturesTab extends State<AllDeparturesTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DragStartDetails? startVerticalDragDetails;
  DragUpdateDetails? updateVerticalDragDetails;

  final availableDayTypes = ['RO', 'WS', 'SW'];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    context.read<TimetableDeparturesCubit>().initTimetables(widget.busStopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: BlocBuilder<TimetableDeparturesCubit, TimetableDeparturesState>(
        builder: (context, state) {
          if (state is TimetableLoaded) {
            return Column(
              children: [
                Container(
                  height: 40,
                  color: AppColors.of(context).primaryLightDarker,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TabBar(
                      controller: _tabController,
                      indicator: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          color: Colors.white),
                      tabs: [
                        Tab(text: "Robocze"),
                        Tab(text: "Soboty"),
                        Tab(text: "Niedziele"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ...availableDayTypes.map(
                        (dayName) => GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onHorizontalDragStart: (dragDetails) {
                            startVerticalDragDetails = dragDetails;
                          },
                          onHorizontalDragUpdate: (dragDetails) {
                            updateVerticalDragDetails = dragDetails;
                          },
                          onHorizontalDragEnd: onDaysTabBarNotification,
                          child: KeepAlivePage(
                            child: ListView.builder(
                              itemCount: state.finalResult[dayName].length,
                              itemBuilder: (context, index) {
                                return TimetableListItem(
                                  route: state.finalResult[dayName][index]
                                      ['route'],
                                  departures: state.finalResult[dayName][index]
                                      ['departures'],
                                  destinations: state.finalResult[dayName]
                                      [index]['destinations'],
                                  dayShortcut: dayName,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
          return CenterLoadSpinner();
        },
      ),
    );
  }

  void onDaysTabBarNotification(endDetails) {
    var dx = updateVerticalDragDetails!.globalPosition.dx -
        startVerticalDragDetails!.globalPosition.dx;
    var dy = updateVerticalDragDetails!.globalPosition.dy -
        startVerticalDragDetails!.globalPosition.dy;
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
  }
}
