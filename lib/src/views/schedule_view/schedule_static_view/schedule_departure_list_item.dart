import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/model/departure.dart';
import 'package:tarbus2021/src/utils/math_utils.dart';

class ScheduleDepartureListItem extends StatelessWidget {
  final Departure departure;

  const ScheduleDepartureListItem({Key key, this.departure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          MathUtils.secToHHMM(departure.realTime),
          style: TextStyle(fontFamily: 'Asap'),
        ),
        Text(
          departure.track.destination.destinationShortcut == '-' ? '' : departure.track.destination.destinationShortcut,
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Asap'),
        ),
        Text(departure.track.dayType == 3 ? '+' : '', style: TextStyle(fontFamily: 'Asap')),
      ],
    );
  }
}
