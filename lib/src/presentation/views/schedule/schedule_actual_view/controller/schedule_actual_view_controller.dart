import 'package:intl/intl.dart';
import 'package:tarbus2021/src/model/database/database_helper.dart';
import 'package:tarbus2021/src/model/entity/departure.dart';
import 'package:tarbus2021/src/utils/time_utils.dart';

class ScheduleActualViewController {
  int currentTime;

  ScheduleActualViewController() {
    currentTime = TimeUtils.getCurrentTimeInMin();
    if (currentTime < 60) {
      currentTime += 3600;
    }
    currentTime -= 10;
  }

  Future<List<Departure>> getAllDepartures(int id) async {
    var dateFormatter = new DateFormat('dd-MM-yyyy');
    var dateToday = new DateTime.now();
    String formattedDateToday = dateFormatter.format(dateToday);
    var currentDayTypes = await DatabaseHelper.instance.getCurrentDayType(formattedDateToday);

    List<Departure> allDepartures = await DatabaseHelper.instance.getNextDepartures(id, currentDayTypes, (TimeUtils.parseTimeToMin(dateToday) - 10));
    if (allDepartures.length < 10) {
      dateToday.add(Duration(days: 1));
      formattedDateToday = dateFormatter.format(dateToday);
      currentDayTypes = await DatabaseHelper.instance.getCurrentDayType(formattedDateToday);
      List<Departure> tommorowDepartures = await DatabaseHelper.instance.getNextDepartures(id, currentDayTypes, 0);
      for (var departure in tommorowDepartures) {
        departure.isTommorow = true;
      }
      allDepartures.addAll(tommorowDepartures);
    }
    return allDepartures;
  }
}
