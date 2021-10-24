import 'package:tarbus_app/data/model/schedule/destination.dart';
import 'package:tarbus_app/data/model/schedule/track.dart';

import 'bus_stop.dart';

class Departure {
  int id;
  int? busStopLp;
  String? externalUuid;
  int timeInMin;
  String timeInString;
  BusStop busStop;
  Track track;
  bool isLast;
  Destination destination;

  Departure({
    required this.id,
    this.busStopLp,
    this.externalUuid,
    required this.timeInMin,
    required this.timeInString,
    required this.busStop,
    required this.track,
    required this.isLast,
    required this.destination,
  });

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      id: json['d_id'],
      busStopLp: json['d_bus_stop_lp'],
      externalUuid: json['d_external_uuid'],
      timeInMin: json['d_time_in_min'],
      timeInString: json['d_time_string'],
      busStop: BusStop.fromJson(json),
      track: Track.fromJson(json),
      destination: Destination.fromJson(json),
      isLast: json['d_is_last'] == 'true' ? true : false,
    );
  }

  @override
  String toString() {
    return 'Departure{id: $id, busStopLp: $busStopLp, realTime: $timeInMin, timeInString: $timeInString, busStop: $busStop, track: $track,}';
  }
}
