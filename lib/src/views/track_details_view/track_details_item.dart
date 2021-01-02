import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/utils/math_utils.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_view.dart';

class TrackDetailsItemView extends StatelessWidget {
  final Departure departure;
  final int index;

  const TrackDetailsItemView({Key key, this.departure, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage trackIcon;
    int isCity = departure.busStop.isCity;
    if (index == 0) {
      trackIcon = AssetImage('assets/icons/bs-pin-start-$isCity.png');
    } else if (index == -1) {
      trackIcon = AssetImage('assets/icons/bs-pin-end-$isCity.png');
    } else {
      trackIcon = AssetImage('assets/icons/bs-pin-center-$isCity.png');
    }

    return FlatButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ScheduleView(busStop: departure.busStop)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image(image: trackIcon, height: 50, fit: BoxFit.fitHeight),
            ),
            Expanded(
              flex: 7,
              child: Text("${departure.busStop.name}"),
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
    );
  }
}
