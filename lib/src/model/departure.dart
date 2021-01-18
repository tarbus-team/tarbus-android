import 'package:tarbus2021/src/model/track.dart';

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

  Departure({this.id, this.busStopLp, this.timeInSec, this.realTime, this.timeInString, this.busStop, this.track, this.busLine});

  factory Departure.fromJson(Map<String, dynamic> json) {
    var timeInSec = json['d_time_in_sec'];
    var realTime = timeInSec;
    if (timeInSec < 3600) {
      realTime = timeInSec + 86400;
    }

    return Departure(
      id: json['DepartureId'],
      busStopLp: json['DepartureId'],
      realTime: realTime,
      timeInString: json['DepartureId'],
      timeInSec: timeInSec,
      busStop: BusStop.fromJson(json),
      busLine: BusLine.fromJson(json),
      track: Track.fromJson(json),
    );
  }
}
