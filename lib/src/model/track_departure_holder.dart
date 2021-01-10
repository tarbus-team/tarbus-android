import 'package:tarbus2021/src/model/track.dart';

import 'departure.dart';

class TrackDepartureHolder {
  List<Departure> selectedDepartures = <Departure>[];
  List<Track> tracks = <Track>[];

  TrackDepartureHolder({this.selectedDepartures, this.tracks});
}
