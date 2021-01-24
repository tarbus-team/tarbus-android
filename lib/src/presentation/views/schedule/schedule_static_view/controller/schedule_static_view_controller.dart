import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';
import 'package:tarbus2021/src/model/entity/line_route_holder.dart';
import 'package:tarbus2021/src/model/entity/track_departure_holder.dart';

class ScheduleStaticViewController {
  static const String WorkDays = '1,3,4';
  static const String FreeDays = '2,4,8,9';
  static const String HolidayDays = '2,6,7';

  List<Departure> allDepartures = <Departure>[];
  List<LineRouteHolder> allLineRouteHolder = <LineRouteHolder>[];

  bool isRefreshing;

  ScheduleStaticViewController() {
    isRefreshing = true;
  }

  TrackDepartureHolder selectTracksAndDepartures(BusLine busLine, var routeId) {
    List<Departure> selectedDepartures = <Departure>[];
    List<Destination> allDestinations = <Destination>[];

    for (var departure in allDepartures) {
      if (departure.busLine.id == busLine.id &&
          departure.track.route.id == routeId &&
          departure.track.destination.directionBoardName != '-' &&
          departure.track.destination.symbol != '-' &&
          departure.track.destination.scheduleName != '-' &&
          !isDestinationInList(allDestinations, departure.track.destination.id)) {
        allDestinations.add(departure.track.destination);
      }
      if (departure.busLine.id == busLine.id && departure.track.route.id == routeId) {
        selectedDepartures.add(departure);
      }
    }

    return TrackDepartureHolder(destinations: allDestinations, selectedDepartures: selectedDepartures);
  }

  bool isInList(List<LineRouteHolder> list, int id, int routeId) {
    for (var lineRouteHolder in list) {
      if (lineRouteHolder.busLine.id == id && lineRouteHolder.route.id == routeId) {
        return true;
      }
    }
    return false;
  }

  bool isDestinationInList(List<Destination> list, int id) {
    for (var destination in list) {
      if (destination.id == id) {
        return true;
      }
    }
    return false;
  }

  Future<List<Departure>> getAllDeparturesByDayType(int id, String dayTypes) async {
    allDepartures = await DatabaseHelper.instance.getAllDeparturesByDayType(id, dayTypes);
    for (var departure in allDepartures) {
      if (!isInList(allLineRouteHolder, departure.busLine.id, departure.track.route.id)) {
        allLineRouteHolder.add(LineRouteHolder(route: departure.track.route, busLine: departure.busLine));
      }
    }
    return allDepartures;
  }
}
