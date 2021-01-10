import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/model/bus_stop.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_actual_view/controller/schedule_actual_view_controller.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_actual_view/schedule_actual_item.dart';

class ScheduleActualView extends StatefulWidget {
  final BusStop busStop;

  const ScheduleActualView({Key key, this.busStop}) : super(key: key);

  @override
  _ScheduleActualViewState createState() => _ScheduleActualViewState();
}

class _ScheduleActualViewState extends State<ScheduleActualView> {
  ScheduleActualViewController viewController = ScheduleActualViewController();

  @override
  Widget build(BuildContext context) {
    var busStopName = widget.busStop.name;
    if (Settings.isDevelop) {
      busStopName = 'ID: ${widget.busStop.number} : $busStopName';
    }
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          "assets/logo_tarbus_header.svg",
          color: Colors.white,
          height: 35,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        bottom: PreferredSize(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                busStopName,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            preferredSize: Size.fromHeight(35)),
      ),
      body: _buildActualSchedule(),
    );
  }

  Widget _buildActualSchedule() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
        child: FutureBuilder<List<Departure>>(
          future: viewController.getAllDepartures(widget.busStop.number),
          builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var departure = snapshot.data[index];
                  return ScheduleActualItem(departure: departure, busStopId: widget.busStop.number);
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
