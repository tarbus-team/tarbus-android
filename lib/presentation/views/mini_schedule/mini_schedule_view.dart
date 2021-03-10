import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/app/app_string.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/presentation/custom_widgets/app_circular_progress_indicator.dart';
import 'package:tarbus2021/presentation/views/mini_schedule/mini_schedule_item.dart';

import 'controller/mini_schedule_view_controller.dart';

class MiniScheduleView extends StatefulWidget {
  final BusStop busStop;

  const MiniScheduleView({Key key, this.busStop}) : super(key: key);

  @override
  _MiniScheduleViewState createState() => _MiniScheduleViewState();
}

class _MiniScheduleViewState extends State<MiniScheduleView> {
  MiniScheduleViewController viewController = MiniScheduleViewController();
  bool isInitialized = false;
  String filterLine;
  bool firstInitial = true;

  @override
  void initState() {
    super.initState();
    firstInitial = false;
    print(filterLine);
    WidgetsBinding.instance.addPostFrameCallback((_) => update());
  }

  void update() async {
    isInitialized = false;
    if (await viewController.getAllDepartures(widget.busStop.id)) {
      setState(() {
        isInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildActualSchedule();
  }

  Widget _buildActualSchedule() {
    if (!isInitialized) {
      return SizedBox(
        height: 80,
        child: AppCircularProgressIndicator(),
      );
    }
    if (viewController.departuresList.isEmpty) {
      return Text(AppString.labelEmptyDepartures);
    } else {
      return Wrap(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Wrap(
              children: [
                Text('Przystanek:'),
                Text(
                  widget.busStop.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.instance(context).mainFontColor,
                  ),
                ),
                Container(
                  height: 10,
                ),
                Text('Najbliższe odjazdy:'),
              ],
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 1, mainAxisSpacing: 1, crossAxisCount: 4, childAspectRatio: 1.2),
            itemCount: viewController.visibleDeparturesList.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              var departure = viewController.visibleDeparturesList[index];
              return MiniScheduleItem(departure: departure, busStopId: widget.busStop.id);
            },
          ),
        ],
      );
    }
  }
}
