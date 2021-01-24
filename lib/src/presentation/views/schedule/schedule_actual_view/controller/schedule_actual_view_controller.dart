import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/utils/date_utils.dart';

class ScheduleActualViewController {
  int currentTime;

  ScheduleActualViewController() {
    currentTime = DateUtils.getCurrentTimeInSec();
    if (currentTime < 3600) {
      currentTime += 86400;
    }
    currentTime -= 600;
  }

  bool showDeparture(Departure departure, int id) {
    if (departure.track.isToday && (currentTime < 3600 || departure.realTime > currentTime)) {
      return true;
    }
    return false;
  }

  Future<List<Departure>> getAllDepartures(int id) async {
    List<Departure> allDepartures = await DatabaseHelper.instance.getDeparturesByBusStopId(id);
    List<Departure> result = <Departure>[];
    for (Departure departure in allDepartures) {
      if (showDeparture(departure, id)) {
        departure.track.isTommorow = false;
        result.add(departure);
      }
    }
    if (result.length < 7) {
      for (Departure departure in allDepartures) {
        if (DateUtils.isTommorow(departure.track.dayId)) {
          Departure tommorowDeparture = Departure.copy(departure);
          tommorowDeparture.isTommorow = true;
          result.add(tommorowDeparture);
        }
      }
    }
    return result;
  }
}
