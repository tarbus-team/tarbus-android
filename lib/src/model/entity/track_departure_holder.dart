import 'package:tarbus2021/src/model/entity/destination.dart';

import 'departure.dart';

class TrackDepartureHolder {
  List<Departure> selectedDepartures = <Departure>[];
  List<Destination> destinations = <Destination>[];

  TrackDepartureHolder({this.selectedDepartures, this.destinations});
}
