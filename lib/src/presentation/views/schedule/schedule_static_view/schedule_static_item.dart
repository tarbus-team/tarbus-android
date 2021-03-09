import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';
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
    viewController = ScheduleStaticItemController(dayTypes: widget.dayTypes, trackRoute: widget.trackRoute, busStopId: widget.busStopId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.5),
      child: Container(
        color: AppColors.lightgray,
        child: ButtonTheme(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: 0,
          height: 0,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {
              setState(() {
                visibilityStatus = !visibilityStatus;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 40,
                      color: AppColors.primaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageIcon(
                              AssetImage("assets/icons/bus_b.png"),
                              size: 19,
                              color: Colors.white,
                            ),
                            Container(
                              width: 5,
                            ),
                            Text(
                              widget.trackRoute.busLine.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 5,
                    ),
                    Container(
                      child: Text(
                        widget.trackRoute.destinationName,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTable() {
    if (visibilityStatus) {
      return Container(
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: destinations.length,
                    itemBuilder: (BuildContext context, int index) {
                      var destination = destinations[index];
                      return Text(destination.scheduleName);
                    },
                  ),
                ],
              );
            } else {
              return Container(
                width: 0,
                height: 0,
              );
            }
          },
        ),
      );
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
