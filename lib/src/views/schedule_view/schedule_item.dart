import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/views/track_details_view/track_details_view.dart';

import '../../utils/math_utils.dart';

class ScheduleItemView extends StatelessWidget {
  final Departure departure;

  const ScheduleItemView({Key key, this.departure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 5,
        ),
        RaisedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TrackDetailsView(track: departure.track)));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.directions_bus),
                      Text(
                        "T10",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        departure.track.destination.name,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Oznaczenia: ${departure.track.types}",
                        style: TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    MathUtils.secToHHMM(departure.timeInSec),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
