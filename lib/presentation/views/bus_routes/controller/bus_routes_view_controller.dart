import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/route_holder.dart';

class BusRoutesViewController {
  Future<List<RouteHolder>> getAllDeparturesByLineId(int id) {
    return DatabaseHelper.instance.getRouteDetailsByLineId(id);
  }
}
