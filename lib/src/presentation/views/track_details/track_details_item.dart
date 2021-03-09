import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/presentation/views/schedule/schedule_actual_view/schedule_actual_view.dart';
import 'package:tarbus2021/src/presentation/views/track_details/controller/track_detailis_view_controller.dart';

class TrackDetailsItemView extends StatelessWidget {
  final Departure departure;
  final int currentIndex;
  final int index;

  const TrackDetailsItemView({Key key, this.departure, this.index, this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TrackDetailsViewController viewController = TrackDetailsViewController(index, currentIndex);
    viewController.checkIfCurrentBusStop();

    return ButtonTheme(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 0,
      height: 0,
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
                child: Image(image: AssetImage(viewController.getTrackIconPath()), height: 35, fit: BoxFit.fitHeight),
              ),
              Expanded(
                flex: 7,
                child: Text(
                  departure.busStop.name,
                  style: TextStyle(fontWeight: viewController.isCurrent ? FontWeight.bold : FontWeight.normal),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  departure.timeInString,
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
