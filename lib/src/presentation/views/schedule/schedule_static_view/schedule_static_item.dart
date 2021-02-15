import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';
import 'package:tarbus2021/src/presentation/custom_widgets/nothing.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/controller/schedule_static_view_controller.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/schedule_departure_list_item.dart';

import 'controller/schedule_static_item_controller.dart';

class ScheduleStaticItem extends StatefulWidget {
  final TrackRoute trackRoute;
  final int busStopId;
  final List<String> dayTypes;

  const ScheduleStaticItem({Key key, this.trackRoute, this.dayTypes, this.busStopId}) : super(key: key);

  @override
  _ScheduleStaticItemState createState() => _ScheduleStaticItemState();
}

class _ScheduleStaticItemState extends State<ScheduleStaticItem> with TickerProviderStateMixin {
  ScheduleStaticItemController viewController;
  bool visibilityStatus = false;

  @override
  void initState() {
    viewController = ScheduleStaticItemController(trackRoute: widget.trackRoute, busStopId: widget.busStopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    viewController.dayTypes = widget.dayTypes;
    var busLineName = widget.trackRoute.busLine.name;
    if (busLineName.length == 3) {
      busLineName = "$busLineName  ";
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                visibilityStatus = !visibilityStatus;
              });
            },
            visualDensity: VisualDensity(horizontal: 0, vertical: -3),
            contentPadding: EdgeInsets.all(0),
            leading: _buildBusLineBox(busLineName),
            title: _buildDestinationNameBux(widget.trackRoute.destinationName),
            trailing: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                _buildDropdownIcon(),
                color: AppColors.instance(context).iconColor,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: AnimatedSize(
              vsync: this,
              alignment: Alignment.topCenter,
              duration: Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              child: _buildScheduleTable(),
            ),
          ),
        ],
      ),
    );
  }

  IconData _buildDropdownIcon() {
    if (visibilityStatus) {
      return Icons.keyboard_arrow_up;
    }
    return Icons.keyboard_arrow_down;
  }

  Widget _buildDestinationNameBux(String destinationName) {
    return Text(
      destinationName,
      style: TextStyle(fontSize: 15),
    );
  }

  Widget _buildBusLineBox(String busLineName) {
    var _dayName = 'Robocze';
    if (widget.dayTypes == ScheduleStaticViewController.FreeDays) {
      _dayName = 'Soboty';
    } else if (widget.dayTypes == ScheduleStaticViewController.HolidayDays) {
      _dayName = 'Święta';
    }
    return Container(
      width: 85.0,
      height: 44.0,
      decoration: new BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: new BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event_note_outlined,
                  color: Colors.white,
                  size: 16,
                ),
                Container(
                  width: 4,
                ),
                Text(
                  busLineName,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Text(
              _dayName,
              style: TextStyle(fontSize: 10.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleTable() {
    if (visibilityStatus) {
      return Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          child: FutureBuilder<List<Departure>>(
            future: viewController.getDeparturesByRouteAndDay(),
            builder: (BuildContext context, AsyncSnapshot<List<Departure>> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.isEmpty) {
                  return Text('Brak odjazdów w tym dniu');
                }
                List<Destination> destinations = viewController.selectUniqueDepartures(snapshot.data);
                return Column(
                  children: [
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2.5),
                      physics: NeverScrollableScrollPhysics(),
                      // to disable GridView's scrolling
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var departure = snapshot.data[index];
                        return ScheduleDepartureListItem(departure: departure);
                      },
                    ),
                    Container(
                      height: 20.0,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: destinations.length,
                      itemBuilder: (BuildContext context, int index) {
                        var destination = destinations[index];
                        return Text(
                          destination.scheduleName,
                          style: TextStyle(color: AppColors.instance(context).staticDeparturesNames),
                        );
                      },
                    ),
                  ],
                );
              } else {
                return Nothing();
              }
            },
          ),
        ),
      );
    } else {
      return Nothing();
    }
  }
}
