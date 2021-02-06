import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/model/entity/destination.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';

class ScheduleStaticItemController {
  int busStopId;
  List<String> dayTypes;
  TrackRoute trackRoute;

  ScheduleStaticItemController({this.trackRoute, this.busStopId});

  List<Destination> selectUniqueDepartures(List<Departure> departures) {
    List<Destination> allDestinations = <Destination>[];
    List<String> existedSymbols = <String>[];
    for (Departure departure in departures) {
      var symbol = departure.track.destination.symbol;
      if (!existedSymbols.contains(symbol) && symbol != '-') {
        existedSymbols.add(symbol);
        allDestinations.add(departure.track.destination);
      }
    }
    return allDestinations;
  }

  Future<List<Departure>> getDeparturesByRouteAndDay() async {
    print('getDeparturesByRouteAndDay');
    var allDepartures = await DatabaseHelper.instance.getDeparturesByRouteAndDay(dayTypes, trackRoute, busStopId);
    return allDepartures;
  }
}
