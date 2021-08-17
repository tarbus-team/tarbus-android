import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

class MiniScheduleView extends StatefulWidget {
  final BusStop busStop;

  const MiniScheduleView({Key? key, required this.busStop}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _MiniScheduleViewState();
}

class _MiniScheduleViewState extends State<MiniScheduleView> {
  @override
  Widget build(BuildContext context) {
    return Text('hello');
  }
}
