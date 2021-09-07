import 'package:intl/intl.dart';

class DateTimeUtils {
  static int getCurrentTimeInMinutes() {
    DateTime now = DateTime.now();
    return now.hour * 60 + now.minute;
  }

  static String getDate(String format, {int? daysAhead}) {
    var date = DateTime.now();
    if (daysAhead != null) {
      date = date.add(Duration(days: daysAhead));
    }
    return parseDate(format, date);
  }

  static String parseDate(String format, DateTime date) {
    return DateFormat(format).format(date);
  }

  static String parseMinutesToTime(int minutes) {
    int hours = (minutes / 60).floor();
    int minutesLeft = minutes - hours * 60;
    return '${hours != 24 ? hours : '0'}:${minutesLeft < 10 ? '0$minutesLeft' : minutesLeft}';
  }

  static String getNamedDate(DateTime date) {
    return DateFormat('EEEE, d MMM, yyyy').format(date);
  }

  static String getDepartureDayShortcut(DateTime todayDate, int daysAhead) {
    switch (daysAhead) {
      case 1:
        return 'Jutro';
      case 2:
        return 'Pojutrze';
      default:
        todayDate = todayDate.add(Duration(days: -1));
        return DateTimeUtils.parseDate('dd.MM', todayDate);
    }
  }
}
