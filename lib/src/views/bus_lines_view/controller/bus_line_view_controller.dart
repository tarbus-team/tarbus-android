import 'package:tarbus2021/src/database/database_helper.dart';
import 'package:tarbus2021/src/model/bus_line.dart';

class BusLineViewController {
  Future<List<BusLine>> getBusLines() {
    return DatabaseHelper.instance.getAllBusLines();
  }
}
