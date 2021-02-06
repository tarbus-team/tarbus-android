import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/app_circular_progress_Indicator.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_actual_view/schedule_actual_item.dart';

import 'controller/schedule_actual_view_controller.dart';

class ScheduleActualView extends StatefulWidget {
  final BusStop busStop;

  const ScheduleActualView({Key key, this.busStop}) : super(key: key);

  @override
  _ScheduleActualViewState createState() => _ScheduleActualViewState();
}

class _ScheduleActualViewState extends State<ScheduleActualView> with AutomaticKeepAliveClientMixin<ScheduleActualView> {
  @override
  bool get wantKeepAlive => true;

  ScheduleActualViewController viewController = ScheduleActualViewController();
  var isInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void update() async {
    if (await viewController.getAllDepartures(widget.busStop.id)) ;
    setState(() {
      isInitialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(5),
        child: _buildActualSchedule(),
      ),
    );
  }

  Widget _buildActualSchedule() {
    if (!isInitialized) {
      return Container(
        height: MediaQuery.of(context).size.height / 1.6,
        child: AppCircularProgressIndicator(),
      );
    }
    if (viewController.departuresList.isEmpty) {
      return Text("Brak odjazdów dzisiaj i jutro");
    } else {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: viewController.departuresList.length,
        itemBuilder: (BuildContext context, int index) {
          var departure = viewController.departuresList[index];
          return ScheduleActualItem(departure: departure, busStopId: widget.busStop.id);
        },
      );
    }
  }
}
