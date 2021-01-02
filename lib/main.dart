import 'package:flutter/material.dart';
import 'package:tarbus2021/src/views/bus_stop_list_view/bus_stop_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BusStopListView(),
    );
  }
}
