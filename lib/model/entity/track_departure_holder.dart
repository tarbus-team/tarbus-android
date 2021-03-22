import 'departure.dart';
import 'destination.dart';

class TrackDepartureHolder {
  List<Departure> selectedDepartures = <Departure>[];
  List<Destination> destinations = <Destination>[];

  TrackDepartureHolder({this.selectedDepartures, this.destinations});
}
