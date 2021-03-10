import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/presentation/custom_widgets/app_circular_progress_indicator.dart';
import 'package:tarbus2021/presentation/custom_widgets/nothing.dart';
import 'package:tarbus2021/presentation/views/schedule/schedule_actual_view/schedule_actual_item.dart';

import 'controller/schedule_actual_view_controller.dart';
import 'filter_departure_dialog.dart';

class ScheduleActualView extends StatefulWidget {
  final BusStop busStop;
  final String busLineFilter;

  const ScheduleActualView({Key key, this.busStop, this.busLineFilter}) : super(key: key);

  @override
  _ScheduleActualViewState createState() => _ScheduleActualViewState();
}

class _ScheduleActualViewState extends State<ScheduleActualView> with AutomaticKeepAliveClientMixin {
  ScheduleActualViewController viewController = ScheduleActualViewController();
  bool isInitialized = false;
  String filterLine;
  bool firstInitial = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    firstInitial = false;
    filterLine = widget.busLineFilter;
    print(filterLine);
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void update() async {
    isInitialized = false;
    if (await viewController.getAllDepartures(widget.busStop.id)) {
      setState(() {
        filter();
        isInitialized = true;
      });
    }
  }

  void filter() {
    if (filterLine.isNotEmpty) {
      var filterList = filterLine.split(',');
      viewController.visibleDeparturesList = viewController.departuresList.where((departure) {
        return filterList.contains(departure.busLine.name);
      }).toList();
    } else {
      viewController.visibleDeparturesList = viewController.departuresList;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildFilterBox(),
                FlatButton.icon(
                  onPressed: () async {
                    var allBusLines = viewController.departuresList.map((departure) => departure.busLine.name).toSet().toList();
                    filterLine = await showDialog(
                      context: context,
                      builder: (ctx) => FilterDepartureDialog(allBusLines: allBusLines, filter: filterLine),
                    );
                    filterLine ??= '';
                    setState(filter);
                  },
                  icon: Icon(Icons.filter_list),
                  label: Text(
                    AppString.labelFilter,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            _buildActualSchedule(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterBox() {
    if (filterLine.isNotEmpty) {
      return SizedBox(
        width: 250,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Wrap(
            children: _buildChoiceList(),
          ),
        ),
      );
    } else {
      return Nothing();
    }
  }

  List<Widget> _buildChoiceList() {
    var choices = <Widget>[];
    filterLine.split(',').forEach((item) {
      choices.add(
        Padding(
          padding: EdgeInsets.all(2),
          child: Chip(
            deleteIcon: Icon(
              Icons.cancel,
            ),
            onDeleted: () {
              setState(() {
                var tmp = filterLine.split(',')..removeWhere((busLine) => busLine == item);

                filterLine = tmp.join(',');
                filter();
              });
            },
            label: Text(item),
          ),
        ),
      );
    });
    return choices;
  }

  Widget _buildActualSchedule() {
    if (!isInitialized) {
      return SizedBox(
        height: MediaQuery.of(context).size.height / 1.6,
        child: AppCircularProgressIndicator(),
      );
    }
    if (viewController.departuresList.isEmpty) {
      return Text(AppString.labelEmptyDepartures);
    } else {
      return ListView.builder(
        itemCount: viewController.visibleDeparturesList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var departure = viewController.visibleDeparturesList[index];
          return ScheduleActualItem(departure: departure, busStopId: widget.busStop.id);
        },
      );
    }
  }
}
