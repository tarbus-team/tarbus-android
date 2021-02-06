import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/app_circular_progress_Indicator.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/clear_button.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/controller/schedule_static_view_controller.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/schedule_static_item.dart';

class ScheduleStaticView extends StatefulWidget {
  final BusStop busStop;

  const ScheduleStaticView({Key key, this.busStop}) : super(key: key);

  @override
  _ScheduleStaticViewState createState() => _ScheduleStaticViewState();
}

class _ScheduleStaticViewState extends State<ScheduleStaticView> {
  final ScheduleStaticViewController viewController = ScheduleStaticViewController();
  var displayedDayTypes = ScheduleStaticViewController.WorkDays;
  var loadingStatus = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
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
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: Container(
              decoration: new BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: new BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDayButton(
                      days: ScheduleStaticViewController.WorkDays,
                      title: 'Dni robocze',
                    ),
                    _buildDayButton(
                      days: ScheduleStaticViewController.FreeDays,
                      title: 'Soboty',
                    ),
                    _buildDayButton(
                      days: ScheduleStaticViewController.HolidayDays,
                      title: 'Święta',
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildStaticSchedule(),
        ],
      ),
    );
  }

  Widget _buildDayButton({List<String> days, String title, bool isLast = false}) {
    var _isSelected = displayedDayTypes == days;
    return Expanded(
      flex: 3,
      child: Container(
        decoration: new BoxDecoration(
          borderRadius: new BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Container(
          decoration: new BoxDecoration(
            border: Border(
              right: BorderSide(width: isLast ? 0 : 1.0, color: Colors.black12),
            ),
          ),
          child: ClearButton(
            button: RaisedButton(
              elevation: 0,
              color: _isSelected ? Colors.white : Theme.of(context).accentColor,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(title),
              ),
              onPressed: () {
                setState(() {
                  displayedDayTypes = days;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStaticSchedule() {
    if (loadingStatus) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.6,
        child: AppCircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally, horizontal: 5),
        child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: viewController.routesFromBusStop.length,
          itemBuilder: (BuildContext context, int index) {
            var trackRoute = viewController.routesFromBusStop[index];
            return ScheduleStaticItem(trackRoute: trackRoute, dayTypes: displayedDayTypes, busStopId: widget.busStop.id);
          },
        ),
      );
    }
  }
}
