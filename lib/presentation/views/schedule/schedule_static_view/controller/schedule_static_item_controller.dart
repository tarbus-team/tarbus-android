import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/model/entity/destination.dart';
import 'package:tarbus2021/model/entity/track_route.dart';

class ScheduleStaticItemController {
  int busStopId;
  List<String> dayTypes;
  TrackRoute trackRoute;

  ScheduleStaticItemController({this.trackRoute, this.busStopId});

  List<Destination> selectUniqueDepartures(List<Departure> departures) {
    var allDestinations = <Destination>[];
    var existedSymbols = <String>[];
    for (var departure in departures) {
      var symbol = departure.track.destination.symbol;
      if (!existedSymbols.contains(symbol) && symbol != '-') {
        existedSymbols.add(symbol);
        allDestinations.add(departure.track.destination);
      }
    }
    return allDestinations;
  }

  Future<List<Departure>> getDeparturesByRouteAndDay() async {
    var allDepartures = await DatabaseHelper.instance.getDeparturesByRouteAndDay(dayTypes, trackRoute, busStopId);
    return allDepartures;
  }
}
