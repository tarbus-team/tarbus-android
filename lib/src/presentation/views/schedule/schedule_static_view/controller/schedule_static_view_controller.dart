import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';

class ScheduleStaticViewController {
  static const List<String> WorkDays = ['RO', 'SC'];
  static const List<String> FreeDays = ['WS'];
  static const List<String> HolidayDays = ['SW'];

  List<TrackRoute> routesFromBusStop = <TrackRoute>[];

  bool isRefreshing;

  ScheduleStaticViewController() {
    isRefreshing = true;
  }

  Future<bool> getRoutesByBusStopId(int busStopId) async {
    routesFromBusStop = await DatabaseHelper.instance.getRoutesByBusStopId(busStopId);
    return true;
  }
}
