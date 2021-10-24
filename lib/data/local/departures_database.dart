import 'package:tarbus_app/data/model/schedule/departure.dart';
import 'package:tarbus_app/manager/database.dart';

class DeparturesDatabase {
  static const String DEPARTURES_QUERY =
      'SELECT * FROM Departure d JOIN BusStop bs ON bs.bs_id = d.d_bus_stop_id JOIN Track t ON t.t_id = d.d_track_id JOIN Route r ON r.r_id = t.t_route_id JOIN BusLine bl ON bl.bl_id = r.r_bus_line_id JOIN Versions v ON v.v_id = bl.bl_version_id JOIN Company cpn ON cpn.cpn_id = v.v_company_id JOIN Destinations ds ON ds.ds_route_id = r.r_id AND ds.ds_symbol = d.d_symbols';

  static Future<List<Departure>> getNextFromBusStop({
    required int busStopId,
    required int timeInMin,
    required List<String> dayTypes,
    List<int>? busLinesId,
    int? limit,
  }) async {
    String query =
        '$DEPARTURES_QUERY WHERE bs.bs_id = $busStopId AND (d.d_time_in_min > $timeInMin OR d.d_time_in_min < 60) AND (${dayTypes.map((day) => ' ${day != dayTypes[0] ? ' OR ' : ''} t.t_day_types LIKE \'%$day%\'').toList().join(' ')}) AND d_is_last LIKE \'false\'';
    if (busLinesId != null && busLinesId.isNotEmpty) {
      query = '$query AND r.r_bus_line_id IN (${busLinesId.join(',')})';
    }
    query = '$query ORDER by d.d_time_in_min';
    if (limit != null) {
      query = '$query LIMIT $limit';
    }
    final result = await DatabaseHelper.instance.doSQL(query);

    return result.map((e) => Departure.fromJson(e)).toList();
  }

  static Future<List<Departure>> getTrackDepartures(
      {required String trackId}) async {
    String query =
        '$DEPARTURES_QUERY WHERE d.d_track_id = \'$trackId\' ORDER BY d.d_time_in_min';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => Departure.fromJson(e)).toList();
  }

  static Future<List<Departure>> getAllFromBusStopByDay(
      {required int routeId,
      required int busStopId,
      required String day}) async {
    String query =
        '$DEPARTURES_QUERY WHERE r.r_id = $routeId AND bs.bs_id = $busStopId AND d.d_is_last NOT LIKE \'true\' AND t.t_day_types LIKE \'%$day%\' ORDER BY d.d_time_in_min';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => Departure.fromJson(e)).toList();
  }
}
