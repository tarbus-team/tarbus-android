import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';

class ScheduleDepartureListItem extends StatelessWidget {
  final Departure departure;

  const ScheduleDepartureListItem({Key key, this.departure}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          departure.timeInString,
        ),
        Text(
          departure.track.destination.symbol == '-' ? '' : departure.track.destination.symbol,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
