import 'package:tarbus2021/src/model/entity/track.dart';

import 'bus_line.dart';
import 'bus_stop.dart';

class Departure {
  int id;
  int busStopLp;
  int timeInSec;
  int realTime;
  String timeInString;

  BusStop busStop;
  Track track;
  BusLine busLine;
  bool isTommorow = false;

  Departure({this.id, this.busStopLp, this.timeInSec, this.realTime, this.timeInString, this.busStop, this.track, this.busLine});

  Departure.copy(Departure departure) {
    id = departure.id;
    busStopLp = departure.busStopLp;
    timeInSec = departure.timeInSec;
    realTime = departure.realTime;
    timeInString = departure.timeInString;
    busStop = departure.busStop;
    track = departure.track;
    busLine = departure.busLine;
  }

  factory Departure.fromJson(Map<String, dynamic> json) {
    var timeInSec = json['d_time_in_sec'];
    var realTime = timeInSec;
    if (timeInSec < 3600) {
      realTime = timeInSec + 86400;
    }

    return Departure(
      id: json['d_id'],
      busStopLp: json['d_bus_stop_lp'],
      realTime: realTime,
      timeInString: json['d_time_string'],
      timeInSec: timeInSec,
      busStop: BusStop.fromJson(json),
      busLine: BusLine.fromJson(json),
      track: Track.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'Departure{id: $id, busStopLp: $busStopLp, timeInSec: $timeInSec, realTime: $realTime, timeInString: $timeInString, busStop: $busStop, track: $track, busLine: $busLine}';
  }
}
