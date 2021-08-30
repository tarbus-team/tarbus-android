import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/manager/database.dart';

class BusStopsConnectionDatabase {
  static const String BUS_STOP_CONNECTION_QUERY =
      'SELECT * FROM BusStopConnection bsc';

  static Future<String> getConnection(BusStop start, BusStop end) async {
    String query =
        '$BUS_STOP_CONNECTION_QUERY WHERE bsc.bsc_from_bus_stop_id = ${start.id} AND bsc.bsc_to_bus_stop_id = ${end.id}';
    final result = await DatabaseHelper.instance.doSQL(query);
    if(result.isNotEmpty) {
      return result[0]['bsc_coords_list'];
    } else {
      return '';
    }
  }
}
