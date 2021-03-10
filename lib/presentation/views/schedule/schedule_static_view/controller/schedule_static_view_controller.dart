import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/track_route.dart';

class ScheduleStaticViewController {
  static const List<String> workDays = ['RO', 'SC'];
  static const List<String> freeDays = ['WS'];
  static const List<String> holidayDays = ['SW'];

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
