import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/schedule_departure_list_item.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_static_view/schedule_static_destination_desc_item.dart';

class ScheduleStaticItem extends StatefulWidget {
  final BusLine busLine;
  final List<Departure> selectedDepartures;
  final List<Destination> destinations;

  const ScheduleStaticItem({Key key, this.busLine, this.selectedDepartures, this.destinations}) : super(key: key);

  @override
  _ScheduleStaticItemState createState() => _ScheduleStaticItemState();
}

class _ScheduleStaticItemState extends State<ScheduleStaticItem> {
  bool visibilityStatus = false;

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
                      height: 36,
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
                              widget.busLine.name,
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
                        widget.selectedDepartures[0].track.route.destinationName,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
                _buildScheduleTable(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleTable() {
    if (visibilityStatus) {
      return Padding(
        padding: EdgeInsets.all(AppDimens.margin_view_horizontally),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: 2.5),
              physics: NeverScrollableScrollPhysics(),
              // to disable GridView's scrolling
              shrinkWrap: true,
              itemCount: widget.selectedDepartures.length,
              itemBuilder: (BuildContext context, int index) {
                var departure = widget.selectedDepartures[index];
                return ScheduleDepartureListItem(departure: departure);
              },
            ),
            Container(
              height: 20,
            ),
            ListView(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true, // You won't see infinite size error
                children: widget.destinations.map((destination) => ScheduleStaticDestinationDescItem(destination: destination)).toList()),
          ],
        ),
      );
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }
}
