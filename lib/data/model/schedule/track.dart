import 'package:tarbus_app/data/model/schedule/track_route.dart';

class Track {
  String id;
  String companyDayName;
  String dayType;
  TrackRoute route;

  Track(
      {required this.id,
      required this.companyDayName,
      required this.dayType,
      required this.route});

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
        id: json['t_id'] as String,
        companyDayName: json['t_day_string'] as String,
        dayType: json['t_day_types'] as String,
        route: TrackRoute.fromJson(json));
  }

  @override
  String toString() {
    return 'Track{id: $id, dayInString: $companyDayName, dayId: $dayType, route: $route}';
  }
}
