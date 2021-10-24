import 'package:tarbus_app/data/model/remote_departure.dart';
import 'package:tarbus_app/data/model/schedule/departure.dart';

class DepartureWrapper {
  final Departure departure;
  final bool isOnline;
  final bool isBreakpoint;
  final DateTime departureDate;
  final int daysAhead;
  final RemoteDeparture? remoteDeparture;

  DepartureWrapper({
    required this.departure,
    this.isOnline = false,
    this.isBreakpoint = false,
    required this.departureDate,
    required this.daysAhead,
    this.remoteDeparture,
  });

  String get trackName {
    if (remoteDeparture != null) {
      return remoteDeparture!.direction;
    }
    return departure.destination.directionBoardName;
  }

  bool get isLive {
    if (remoteDeparture != null) {
      return remoteDeparture!.hour.isEmpty;
    }
    return false;
  }
}
