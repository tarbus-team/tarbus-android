import 'package:tarbus2021/src/model/entity/track_route.dart';
import 'package:tarbus2021/src/utils/date_utils.dart';

import 'destination.dart';

class Track {
  String id;
  String dayInString;
  int dayId;

  Destination destination;
  TrackRoute route;

  bool isToday;
  bool isTommorow = false;

  Track({this.id, this.dayInString, this.dayId, this.destination, this.isToday, this.route});

  factory Track.fromJson(Map<String, dynamic> json) {
    var dayId = json['t_day_id'];
    var isToday = DateUtils.isToday(dayId);

    return Track(
      id: json['t_id'],
      dayInString: json['t_day_string'],
      dayId: dayId,
      destination: Destination.fromJson(json),
      route: TrackRoute.fromJson(json),
      isToday: isToday,
    );
  }

  @override
  String toString() {
    return 'Track{id: $id, dayInString: $dayInString, dayId: $dayId, destination: $destination, route: $route, isToday: $isToday}';
  }
}
