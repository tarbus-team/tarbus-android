import 'destination.dart';

class Track {
  int id;
  String types;
  int destinationStatus;
  Destination destination;

  Track({this.id, this.types, this.destinationStatus, this.destination});

  factory Track.fromJson(Map<String, dynamic> json) => new Track(
        id: json["track_id"],
        types: json["track_types"],
        destinationStatus: json["destination_status"],
        destination: Destination(
          id: json["destination_id"],
          name: json["destination_name"],
        ),
      );
}
