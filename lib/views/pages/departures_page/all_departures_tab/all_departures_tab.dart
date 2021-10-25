import 'package:extended_tabs/extended_tabs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarbus_app/bloc/timetable_departures_cubit/timetable_departures_cubit.dart';
import 'package:tarbus_app/config/app_colors.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/views/pages/departures_page/all_departures_tab/timetable_list_item.dart';
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

  final availableDayTypes = ['RO', 'WS', 'SW'];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    context.read<TimetableDeparturesCubit>().initTimetables(widget.busStopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimetableDeparturesCubit, TimetableDeparturesState>(
      builder: (context, state) {
        if (state is TimetableLoaded) {
          return Column(
            children: [
              Container(
                color: AppColors.of(context).breakpoint,
                height: 24,
                width: double.infinity,
              ),
              Container(
                height: 40,
                color: AppColors.of(context).breakpoint,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TabBar(
                    controller: _tabController,
                    indicator: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      color: Colors.white,
                    ),
                    tabs: const <Tab>[
                      Tab(text: "Robocze"),
                      Tab(text: "Soboty"),
                      Tab(text: "Niedziele"),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ExtendedTabBarView(
                  link: true,
                  controller: _tabController,
                  // physics: NeverScrollableScrollPhysics(),
                  children: [
                    ...availableDayTypes.map(
                      (dayName) => KeepAlivePage(
                        child: ListView(
                          // controller: ScrollController(),
                          children: [
                            ...state.finalResult[dayName].map((e) {
                              if (e['departures'].isNotEmpty)
                                return TimetableListItem(
                                  route: e['route'],
                                  departures: e['departures'],
                                  destinations: e['destinations'],
                                  dayShortcut: dayName,
                                );
                              else
                                return SizedBox(
                                  height: 0,
                                );
                            }).toList(),
                          ],
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
    );
  }
}
