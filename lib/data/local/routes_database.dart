import 'package:tarbus_app/data/model/schedule/track_route.dart';
import 'package:tarbus_app/manager/database.dart';

class RoutesDatabase {
  static const String ROUTES_QUERY =
      'SELECT * FROM Route r JOIN BusLine bl ON bl.bl_id = r.r_bus_line_id JOIN Versions v ON v.v_id = bl.bl_version_id JOIN Company cpn ON cpn.cpn_id = v.v_company_id';

  static Future<List<TrackRoute>> getRoutesForBusLine(int busLineId) async {
    String query = '$ROUTES_QUERY WHERE r.r_bus_line_id = $busLineId';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => TrackRoute.fromJson(e)).toList();
  }

  static Future<List<TrackRoute>> findAllById(List<int> routesIds) async {
    String query = '$ROUTES_QUERY WHERE r.r_id IN(${routesIds.join(',')})';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => TrackRoute.fromJson(e)).toList();
  }

  static Future<List<TrackRoute>> getAllFromBusStop(int busStopId) async {
    String query =
        'SELECT DISTINCT t.t_route_id FROM Departure d JOIN Track t ON t.t_id = d.d_track_id WHERE d.d_bus_stop_id = $busStopId AND d.d_is_last NOT LIKE \'true\'';
    final result = await DatabaseHelper.instance.doSQL(query);
    print(result);
    List<int> routesIds = result.map((e) => e['t_route_id'] as int).toList();
    return findAllById(routesIds);
  }
}
