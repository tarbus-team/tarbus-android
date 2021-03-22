import 'bus_line.dart';

class TrackRoute {
  int id;
  String destinationName;
  String destinationDesc;
  BusLine busLine;

  TrackRoute({this.id, this.destinationName, this.busLine, this.destinationDesc});

  factory TrackRoute.fromJson(Map<String, dynamic> json) {
    return TrackRoute(
      id: json['r_id'] as int,
      destinationName: json['r_destination_name'] as String,
      destinationDesc: json['r_destination_desc'] as String,
      busLine: BusLine.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'TrackRoute{id: $id, destinationName: $destinationName, destinationDesc: $destinationDesc, busLine: ${busLine.toString()}';
  }
}
