import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/app/app_colors.dart';
import 'package:tarbus2021/src/app/settings.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/views/track_details_view/track_details_view.dart';

import '../../../utils/math_utils.dart';

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
      child: FlatButton(
        padding: EdgeInsets.all(0),
        color: AppColors.lightgray,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => TrackDetailsView(track: departure.track, busStopId: busStopId)));
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: AppColors.primaryColor,
                child: Padding(
                  padding: EdgeInsets.all(7),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageIcon(
                        AssetImage("assets/icons/bus_b.png"),
                        size: 21,
                        color: Colors.white,
                      ),
                      Container(
                        width: 5,
                      ),
                      Text(
                        busLineName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
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
                      departure.track.destination.name,
                      style: TextStyle(
                        fontSize: 13,
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
                  children: [
                    Text(
                      MathUtils.secToHHMM(departure.timeInSec),
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
