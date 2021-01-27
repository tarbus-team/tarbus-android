import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/presentation/views/track_details/track_details_view.dart';

class ScheduleActualItem extends StatelessWidget {
  final Departure departure;
  final int busStopId;

  const ScheduleActualItem({Key key, this.departure, this.busStopId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var busLineName = departure.busLine.name;
    if (busLineName.length == 3) {
      busLineName = "$busLineName  ";
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1),
      child: Container(
        height: 36,
        color: AppColors.lightgray,
        child: ButtonTheme(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: 0,
          height: 0,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute<String>(builder: (context) => TrackDetailsView(track: departure.track, busStopId: busStopId)));
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: AppColors.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageIcon(
                            AssetImage("assets/icons/bus_b.png"),
                            size: 18,
                            color: Colors.white,
                          ),
                          Container(
                            width: 4,
                          ),
                          Text(
                            busLineName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          departure.track.destination.directionBoardName,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        if (Settings.isDevelop) _buildDevelop(),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          departure.timeInString,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (departure.isTommorow)
                          Text(
                            'Jutro',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDevelop() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TrackId: ${departure.track.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.red,
          ),
        ),
        Text(
          'DepartueId: ${departure.id}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
