import 'package:tarbus2021/src/model/entity/bus_stop.dart';

class BusStopArgumentsHolder {
  BusStop busStop;
  String busLineFilter;

  BusStopArgumentsHolder({this.busStop, this.busLineFilter = ''});
}
