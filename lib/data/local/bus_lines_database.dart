import 'package:tarbus_app/data/model/schedule/bus_line.dart';
import 'package:tarbus_app/manager/database.dart';

class BusLinesDatabase {
  static const String BUS_LINE_QUERY =
      'SELECT * FROM BusLine bl JOIN Versions v ON v.v_id = bl.bl_version_id JOIN Company cpn ON v.v_company_id = cpn.cpn_id ';

  static Future<List<BusLine>> getAllBusLines(
      {String name = '', int? limit}) async {
    String query = '$BUS_LINE_QUERY WHERE bl.bl_name LIKE \'%$name%\'';
    if (limit != null) {
      query += ' LIMIT $limit';
    }
    final result = await DatabaseHelper.instance.doSQL(query);

    return result.map((e) => BusLine.fromJson(e)).toList();
  }

  static Future<List<BusLine>> getByCompany(int companyId) async {
    String query = '$BUS_LINE_QUERY WHERE v.v_company_id = $companyId';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusLine.fromJson(e)).toList();
  }

  // UNUSED
  static Future<List<BusLine>> findAllById(List<int> busLinesIds) async {
    String query =
        '$BUS_LINE_QUERY WHERE bl.bl_id IN(${busLinesIds.join(',')})';
    final result = await DatabaseHelper.instance.doSQL(query);
    return result.map((e) => BusLine.fromJson(e)).toList();
  }

  // UNUSED
  static Future<List<BusLine>> getAllFromBusStop(int busStopId) async {
    String query =
        'SELECT DISTINCT r.r_bus_line_id FROM Departure d JOIN Track t ON t.t_id = d.d_track_id JOIN Route r ON r.r_id = t.t_route_id WHERE d.d_bus_stop_id = $busStopId';
    final result = await DatabaseHelper.instance.doSQL(query);
    List<int> busLinesId =
        result.map((e) => e['r_bus_line_id'] as int).toList();
    return findAllById(busLinesId);
  }
}
