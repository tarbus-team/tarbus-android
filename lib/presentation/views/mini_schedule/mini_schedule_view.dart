import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/app/app_colors.dart';
import 'package:tarbus2021/model/entity/bus_stop.dart';
import 'package:tarbus2021/model/entity/bus_stop_arguments_holder.dart';
import 'package:tarbus2021/presentation/custom_widgets/app_circular_progress_indicator.dart';
import 'package:tarbus2021/presentation/views/schedule/factory_schedule_view.dart';

import 'controller/mini_schedule_view_controller.dart';
import 'mini_schedule_item.dart';

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
    return Wrap(
      direction: Axis.vertical,
      runAlignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(
              context,
              rootNavigator: true,
            ).pushNamed(FactoryScheduleView.route, arguments: BusStopArgumentsHolder(busStop: widget.busStop));
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Card(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: Wrap(
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text('Przystanek:'),
                        SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            widget.busStop.name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: AppColors.instance(context).mainFontColor,
                            ),
                          ),
                        ),
                        Container(
                          height: 10,
                        ),
                        Text('Najbliższe odjazdy:'),
                      ],
                    ),
                    _buildActualSchedule()
                  ],
                ),
              ),
            ),
          ),
        ),
        Image(
          image: AssetImage('assets/icons/down-arrow.png'),
        )
      ],
    );
  }

  Widget _buildActualSchedule() {
    if (!isInitialized) {
      return SizedBox(
        height: 80,
        child: AppCircularProgressIndicator(),
      );
    }
    if (viewController.departuresList.isEmpty) {
      return Text(
        'Brak odjazdów w dniu dzisiejszym',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: AppColors.instance(context).mainFontColor,
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 1),
        itemCount: viewController.visibleDeparturesList.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          var departure = viewController.visibleDeparturesList[index];
          return MiniScheduleItem(departure: departure, busStopId: widget.busStop.id);
        },
      );
    }
  }
}
