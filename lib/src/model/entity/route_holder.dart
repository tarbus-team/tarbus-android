import 'package:tarbus2021/src/model/entity/track_route.dart';

import 'bus_stop.dart';

class RouteHolder {
  TrackRoute trackRoute;
  List<BusStop> busStops;

  RouteHolder({this.trackRoute, this.busStops});

  @override
  String toString() {
    return 'RouteHolder{trackRoute: $trackRoute, busStops: $busStops}';
  }
}
