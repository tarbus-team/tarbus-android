import 'package:intl/intl.dart';
import 'package:tarbus2021/model/database/database_helper.dart';
import 'package:tarbus2021/model/entity/departure.dart';
import 'package:tarbus2021/utils/time_utils.dart';

class MiniScheduleViewController {
  int currentTime;
  List<Departure> departuresList;
  List<Departure> visibleDeparturesList;

  MiniScheduleViewController() {
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

    departuresList = await DatabaseHelper.instance.getNextDeparturesWithLimit(id, currentDayTypes, startFromTime, 8);

    visibleDeparturesList = departuresList;
    return true;
  }
}
