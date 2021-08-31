import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/manager/database.dart';

class BusStopsDatabase {
  static const String BUS_STOP_QUERY = 'SELECT * FROM BusStop bs';

  static Future<List<BusStop>> getAllBusStops(
      {String name = '', int? limit}) async {
    String query = '$BUS_STOP_QUERY WHERE bs.bs_search_name LIKE \'%$name%\'';
    if (limit != null) {
      query += ' LIMIT $limit';
    }
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusStop.fromJson(e)).toList();
  }

  static Future<List<BusStop>> getBusStopsForRoute(int routeId) async {
    String query =
        "SELECT * FROM RouteConnections rc JOIN BusStop bs ON rc.rc_bus_stop_id = bs.bs_id WHERE rc.rc_route_id = $routeId ORDER BY rc.rc_lp";
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusStop.fromJson(e)).toList();
  }

  static Future<List<BusStop>> getBusStopsForLine(int lineId) async {
    String query =
        "SELECT * FROM RouteConnections rc JOIN BusStop bs ON rc.rc_bus_stop_id = bs.bs_id JOIN Route r ON r.r_id = rc.rc_route_id WHERE r.r_bus_line_id = $lineId ORDER BY rc.rc_lp";
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusStop.fromJson(e)).toList();
  }

  static Future<List<BusStop>> getBusStopsByIds(List<int> ids) async {
    String query = "$BUS_STOP_QUERY WHERE bs.bs_id IN (${ids.join(',')})";
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusStop.fromJson(e)).toList();
  }

  static Future<List<BusStop>> getBusStopsForTrack(String trackId) async {
    String query =
        "SELECT DISTINCT d.d_bus_stop_id FROM Departure d WHERE d.d_track_id = $trackId ORDER BY d.d_time_in_min";
    final result = await DatabaseHelper.instance.doSQL(query);
    List<int> busStopsIds =
        result.map((e) => e['d_bus_stop_id'] as int).toList();
    List<BusStop> fullBusStopsData = await getBusStopsByIds(busStopsIds);
    List<BusStop> finalResult = List.empty(growable: true);
    for (int id in busStopsIds) {
      for (BusStop stop in fullBusStopsData) {
        if (id == stop.id) {
          finalResult.add(stop);
        }
      }
    }
    return finalResult;
  }
}
