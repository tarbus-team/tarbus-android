import 'package:flutter/cupertino.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';

class ScheduleStaticDestinationDescItem extends StatelessWidget {
  final Destination destination;

  const ScheduleStaticDestinationDescItem({Key key, this.destination}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(destination.toString());
    return Text('${destination.scheduleName}');
  }
}
