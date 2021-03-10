import 'package:intl/intl.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/utils/time_utils.dart';

class ScheduleActualViewController {
  int currentTime;
  List<Departure> departuresList;
  List<Departure> visibleDeparturesList;

  ScheduleActualViewController() {
    currentTime = TimeUtils.getCurrentTimeInMin();
    if (currentTime < 60) {
      currentTime += 3600;
    }
    currentTime -= 10;
  }

  Future<bool> getAllDepartures(int id) async {
    var dateFormatter = DateFormat('dd-MM-yyyy');
    var dateToday = DateTime.now();
    var startFromTime = TimeUtils.parseTimeToMin(dateToday) - 10;
    if (dateToday.hour == 0) {
      dateToday = dateToday.subtract(Duration(days: 1));
      startFromTime = 1430 + dateToday.minute;
    }

    var formattedDateToday = dateFormatter.format(dateToday);
    var currentDayTypes = await DatabaseHelper.instance.getCurrentDayType(formattedDateToday);

    departuresList = await DatabaseHelper.instance.getNextDepartures(id, currentDayTypes, startFromTime);

    print('Today is $formattedDateToday');

    if (departuresList.length < 13) {
      dateToday = dateToday.add(Duration(days: 1));

      formattedDateToday = dateFormatter.format(dateToday);
      print('Tommorow is $formattedDateToday');
      currentDayTypes = await DatabaseHelper.instance.getCurrentDayType(formattedDateToday);
      List<Departure> tommorowDepartures = await DatabaseHelper.instance.getNextDepartures(id, currentDayTypes, 0);
      for (var departure in tommorowDepartures) {
        departure.isTommorow = true;
      }
      departuresList.addAll(tommorowDepartures);
    }
    visibleDeparturesList = departuresList;
    return true;
  }
}
