import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/utils/math_utils.dart';
import 'package:tarbus2021/src/views/schedule_view/schedule_actual_view/schedule_actual_view.dart';

class TrackDetailsItemView extends StatelessWidget {
  final Departure departure;
  final int currentIndex;
  final int index;

  const TrackDetailsItemView({Key key, this.departure, this.index, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage trackIcon;
    var isCurrent = false;
    if (currentIndex != -2 && index == currentIndex) {
      isCurrent = true;
    }
    var status = isCurrent ? 'b' : 'g';
    if (index == 0) {
      trackIcon = AssetImage('assets/icons/first_bus_stop_icon_$status.png');
    } else if (index == -1) {
      trackIcon = AssetImage('assets/icons/last_bus_stop_icon_$status.png');
    } else {
      if (currentIndex != -2 && index >= currentIndex) {
        trackIcon = AssetImage('assets/icons/next_bus_stop_icon_$status.png');
      } else {
        trackIcon = AssetImage('assets/icons/next_bus_stop_icon_g_0.png');
      }
    }

    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      //adds padding inside the button
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      //limits the touch area to the button area
      minWidth: 0,
      //wraps child's width
      height: 0,
      //wraps child's height
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<String>(builder: (context) => ScheduleActualView(busStop: departure.busStop)));
        },
        padding: EdgeInsets.all(0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Image(image: trackIcon, height: 35, fit: BoxFit.fitHeight),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  departure.busStop.name,
                  style: TextStyle(fontFamily: 'Asap', fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal),
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
    );
  }
}
