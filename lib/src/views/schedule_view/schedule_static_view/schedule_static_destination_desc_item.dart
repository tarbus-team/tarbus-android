import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/model/track.dart';

class ScheduleStaticDestinationDescItem extends StatelessWidget {
  final Track track;

  const ScheduleStaticDestinationDescItem({Key key, this.track}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (track.destination.descriptionLong != null) {
      return Text('${track.destination.descriptionLong}', style: TextStyle(fontFamily: 'Asap'));
    } else {
      return Container(
        width: 0,
        height: 0,
      );
    }
  }
}
