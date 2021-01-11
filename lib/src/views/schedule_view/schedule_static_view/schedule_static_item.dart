import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/app_dimens.dart';
import 'package:tarbus2021/src/model/bus_line.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/model/track.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_static_view/schedule_departure_list_item.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_static_view/schedule_static_destination_desc_item.dart';

class ScheduleStaticItem extends StatefulWidget {
  final BusLine busLine;
  final List<Departure> selectedDepartures;
  final List<Track> tracks;

  const ScheduleStaticItem({Key key, this.busLine, this.selectedDepartures, this.tracks}) : super(key: key);

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
                children: [
                  Container(
                    width: 100,
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage("assets/icons/bus_b.png"),
                            size:20,
                            color: Colors.white,
                          ),
                          Container(
                            width: 5,
                          ),
                          Text(
                            widget.busLine.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Asap',
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
                    width: 260,
                    child: Text(
                      widget.selectedDepartures[0].track.destination.name,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      softWrap: true,
                      style: TextStyle(fontSize: 15, fontFamily: 'Asap'),
                    ),
                  ),
                ],
              ),
              _buildScheduleTable(),
            ],
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
            ListView(
                physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                shrinkWrap: true, // You won't see infinite size error
                children: widget.tracks.map((track) => ScheduleStaticDestinationDescItem(track: track)).toList()),
            Text(' + - Dni nauki szkolnej')
          ],
        ),
      );
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }
}
