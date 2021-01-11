import 'package:flutter/cupertino.dart';
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
  int realTime;
  bool isTommorow;

  Departure({this.id, this.busStop, this.track, this.busLine, @required this.timeInSec}) {
    isTommorow = false;
    if (timeInSec < 3600) {
      realTime = timeInSec + 86400;
    } else {
      realTime = timeInSec;
    }
  }

  factory Departure.fromJson(Map<String, dynamic> json) => Departure(
      id: json['departure_id'],
      timeInSec: json['time_in_sec'],
      busStop: BusStop(
        searchName: json['bus_stop_name'],
        number: json['bus_stop_number'],
        name: json['bus_stop_name'],
        type: json['bus_stop_type'],
        isCity: json['is_city'],
      ),
      busLine: BusLine(
        id: json['bus_line_id'],
        name: json['bus_line_name'],
      ),
      track: Track(
        id: json['track_id'],
        dayType: json['day_type'],
        destinationStatus: json['track_destination_status'],
        destination: Destination(
          id: json['destination_id'],
          name: json['destination_name'],
          destinationShortcut: json['destination_shortcut'],
          //TODO Fix - desctiption - a ma być description
          description: json['desctiption'],
          descriptionLong: json['desctiption_long'],
          busLineId: json['destination_bus_line_id'],
          lastBusStopNumber: json['last_bus_stop_number'],
        ),
      ));
}
