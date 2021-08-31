import 'package:tarbus_app/data/model/schedule/bus_stop.dart';

class BusStopConnection {
  int busIdFrom;
  int busIdTo;
  String? distance;
  String? coords;
  BusStop? startBusStop;
  BusStop? endBusStop;

  BusStopConnection(
      {required this.busIdFrom,
      required this.busIdTo,
      this.distance,
      this.startBusStop,
      this.endBusStop,
      this.coords});

  factory BusStopConnection.fromJson(Map<String, dynamic> json) {
    return BusStopConnection(
        busIdFrom: json['bsc_from_bus_stop_id'] as int,
        busIdTo: json['bsc_to_bus_stop_id'] as int,
        distance: json['bsc_distance'] as String,
        coords: json['bsc_coords_list'] as String);
  }

  factory BusStopConnection.fromJsonFull(
      BusStop start, BusStop end, Map<String, dynamic> json) {
    return BusStopConnection(
      startBusStop: start,
      endBusStop: end,
      busIdFrom: json['bsc_from_bus_stop_id'] as int,
      busIdTo: json['bsc_to_bus_stop_id'] as int,
      distance: json['bsc_distance'] as String,
      coords: json['bsc_coords_list'] as String,
    );
  }
}
