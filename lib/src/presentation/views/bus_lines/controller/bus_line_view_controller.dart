import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/bus_line.dart';

class BusLineViewController {
  Future<List<BusLine>> getBusLines() {
    return DatabaseHelper.instance.getAllBusLines();
  }
}
