import 'package:tarbus2021/src/model/track_route.dart';

import 'bus_stop.dart';

class RouteHolder {
  TrackRoute trackRoute;
  List<BusStop> busStops;

  RouteHolder({this.trackRoute, this.busStops});
}
