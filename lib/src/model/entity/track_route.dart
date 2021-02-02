import 'package:tarbus2021/src/model/entity/bus_line.dart';

class TrackRoute {
  int id;
  String destinationName;
  BusLine busLine;

  TrackRoute({this.id, this.destinationName, this.busLine});

  factory TrackRoute.fromJson(Map<String, dynamic> json) {
    return TrackRoute(
      id: json['r_id'],
      destinationName: json['r_destination_name'],
      busLine: BusLine.fromJson(json),
    );
  }

  @override
  String toString() {
    return 'TrackRoute{id: $id, destinationName: $destinationName, busLineId: ${busLine.toString()}';
  }
}
