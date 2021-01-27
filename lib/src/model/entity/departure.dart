import 'package:tarbus2021/src/model/entity/track.dart';

import 'bus_line.dart';
import 'bus_stop.dart';

class Departure {
  int id;
  int busStopLp;
  int timeInMin;
  String timeInString;

  BusStop busStop;
  Track track;
  BusLine busLine;
  bool isTommorow = false;

  Departure({this.id, this.busStopLp, this.timeInMin, this.timeInString, this.busStop, this.track, this.busLine});

  Departure.copy(Departure departure) {
    id = departure.id;
    busStopLp = departure.busStopLp;
    timeInMin = departure.timeInMin;
    timeInString = departure.timeInString;
    busStop = departure.busStop;
    track = departure.track;
    busLine = departure.busLine;
  }

  factory Departure.fromJson(Map<String, dynamic> json) {
    return Departure(
      id: json['d_id'],
      busStopLp: json['d_bus_stop_lp'],
      timeInMin: json['d_time_in_min'],
      timeInString: json['d_time_string'],
      busStop: BusStop.fromJson(json),
      busLine: BusLine.fromJson(json),
      track: Track.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'Departure{id: $id, busStopLp: $busStopLp, realTime: $timeInMin, timeInString: $timeInString, busStop: $busStop, track: $track, busLine: $busLine}';
  }
}
