import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/app/app_string.dart';
import 'package:tarbus2021/src/model/entity/bus_stop.dart';
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
  var loadingStatus = true;

  @override
  void initState() {
    update();
    super.initState();
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(
            "assets/logo_tarbus_header.svg",
            color: Colors.white,
            height: 35,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          bottom: PreferredSize(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    widget.busStop.name,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                TabBar(tabs: [
                  Text(
                    AppString.labelWorkDays,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppString.labelFreeDays,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    AppString.labelHolyDays,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ]),
              ],
            ),
            preferredSize: Size.fromHeight(80),
          ),
        ),
        body: TabBarView(
          children: [
            _buildStaticSchedule(ScheduleStaticViewController.WorkDays),
            _buildStaticSchedule(ScheduleStaticViewController.FreeDays),
            _buildStaticSchedule(ScheduleStaticViewController.HolidayDays),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticSchedule(List<String> dayTypes) {
    if (loadingStatus) {
      return Center(child: CircularProgressIndicator());
    } else {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppDimens.margin_view_horizontally, horizontal: 5),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: viewController.routesFromBusStop.length,
            itemBuilder: (BuildContext context, int index) {
              var trackRoute = viewController.routesFromBusStop[index];
              return ScheduleStaticItem(trackRoute: trackRoute, dayTypes: dayTypes, busStopId: widget.busStop.id);
            },
          ),
        ),
      );
    }
  }
}
