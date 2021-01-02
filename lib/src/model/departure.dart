import 'package:tarbus2021/src/model/track.dart';

import 'bus_line.dart';
import 'bus_stop.dart';
import 'destination.dart';

class Departure {
  int id;
  BusStop busStop;
  Track track;
  BusLine busLine;
  int timeInSec;

  Departure({this.id, this.busStop, this.track, this.busLine, this.timeInSec});

  factory Departure.fromJson(Map<String, dynamic> json) => new Departure(
      id: json["departure_id"],
      timeInSec: json["time_in_sec"],
      busStop: BusStop(
        number: json["bus_stop_number"],
        name: json["bus_stop_name"],
        type: json["bus_stop_type"],
        isCity: json["is_city"],
      ),
      busLine: BusLine(
        id: json["bus_line_id"],
        name: json["bus_line_name"],
      ),
      track: Track(
        id: json["track_id"],
        types: json["track_types"],
        destinationStatus: json["track_destination_status"],
        destination: Destination(
          id: json["destination_id"],
          name: json["destination_name"],
        ),
      ));
}
