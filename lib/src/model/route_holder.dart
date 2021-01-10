import 'package:tarbus2021/src/model/destination.dart';

import 'bus_stop.dart';

class RouteHolder {
  Destination destination;
  List<BusStop> busStops;

  RouteHolder({this.destination, this.busStops});
}
