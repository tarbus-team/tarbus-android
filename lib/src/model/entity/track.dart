import 'package:tarbus2021/src/model/entity/track_route.dart';

import 'destination.dart';

class Track {
  String id;
  String companyDayName;
  String dayType;

  Destination destination;
  TrackRoute route;

  Track({this.id, this.companyDayName, this.dayType, this.destination, this.route});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        id: json['t_id'] as String,
        companyDayName: json['t_day_string'] as String,
        dayType: json['t_day_types'] as String,
        destination: Destination.fromJson(json),
        route: TrackRoute.fromJson(json));
  }

  @override
  String toString() {
    return 'Track{id: $id, dayInString: $companyDayName, dayId: $dayType, destination: $destination, route: $route}';
  }
}
