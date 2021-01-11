import 'package:tarbus2021/src/utils/date_utils.dart';

import 'destination.dart';

class Track {
  String id;
  int dayType;
  int destinationStatus;
  Destination destination;
  bool isToday;

  Track({this.id, this.dayType, this.destinationStatus, this.destination}) {
    isToday = DateUtils.isToday(dayType);
  }

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json['track_id'],
        dayType: json['day_type'],
        destinationStatus: json['destination_status'],
        destination: Destination(
          id: json['destination_id'],
          name: json['destination_name'],
          destinationShortcut: json['destination_shortcut'],
          description: json['desctiption'],
          busLineId: json['destination_bus_line_id'],
          lastBusStopNumber: json['last_bus_stop_number'],
        ),
      );
}
