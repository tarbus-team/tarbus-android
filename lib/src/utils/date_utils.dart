class DateUtils {
  static bool isTommorow(int id) {
    var date = DateTime.now();
    return isToday(id, dateTest: DateTime(date.year, date.month, date.day, date.hour, date.minute).add(Duration(days: 1)));
  }

  static bool isToday(int id, {DateTime dateTest}) {
    var date = DateTime.now();
    var currentTime = ((date.hour * 60) + date.minute) * 60;
    if (currentTime < 3600 && date.day != 1) {
      date = DateTime(date.year, date.month, date.day - 1, date.hour, date.minute);
    }
    if (dateTest != null) {
      date = dateTest;
    }
    var weekDay = date.weekday;
    var isHoliday = isDayHoliday(date);
    var isWorkDay = isDayWorkDay(weekDay);
    var isSchoolDay = isDaySchoolDay(date, isHoliday, isWorkDay);

    //TODO - Prettify it
    switch (id) {
      case 1: //Dni robocze bez świąt
        if (isWorkDay && !isHoliday) {
          return true;
        }
        return false;
      case 2: //Soboty i niedziele
        if (weekDay == 6 || weekDay == 7) {
          return true;
        }
        return false;
      case 3: //Dni szkolne
        return isSchoolDay;
      case 4: //pon-sob bez świąt
        if ((isWorkDay || weekDay == 6) && !isHoliday) {
          return true;
        }
        return false;
      case 5: //pon-sob ze świętami
        if (isWorkDay || weekDay == 6) {
          return true;
        }
        return false;
      case 6: // Niedziele i święta
        if (weekDay == 7 || isHoliday) {
          return true;
        }
        return false;
      case 7: //Niedziele
        return weekDay == 7;
      case 8: //Soboty
        return weekDay == 6;
      case 9:
        if (weekDay == 6 && !isHoliday) {
          return true;
        }
        return false;
    }
    return false;
  }

  static bool isDayHoliday(DateTime date) {
    var holidaysIn2021 = <DateTime>[]
      ..add(DateTime(2021, 4, 4)) // Wielkanoc
      ..add(DateTime(2021, 4, 5)) // Wielkanoc
      ..add(DateTime(2021, 5, 1)) // Święto pracy
      ..add(DateTime(2021, 5, 3)) // Święto konstytucji
      ..add(DateTime(2021, 5, 23)) // Zielone świątki
      ..add(DateTime(2021, 6, 3)) // Boże Ciało
      ..add(DateTime(2021, 8, 15)) // Święto Wojska Polskiego
      ..add(DateTime(2021, 11, 1)) // Wszystkich Świętych
      ..add(DateTime(2021, 11, 11)) // Święto Niepodległości
      ..add(DateTime(2021, 12, 25)) // Boże Narodzenie
      ..add(DateTime(2021, 12, 16)); // Boże Narodzenie

    for (var dateTime in holidaysIn2021) {
      if (date.day == dateTime.day && date.month == dateTime.month) {
        return true;
      }
    }
    return false;
  }

  static bool isDayWorkDay(int day) {
    var workDays = [1, 2, 3, 4, 5];
    for (var workDay in workDays) {
      if (workDay == day) {
        return true;
      }
    }
    return false;
  }

  static bool isDaySchoolDay(DateTime currentDate, bool isHoliday, bool isWorkDay) {
    if (isHoliday || !isWorkDay) {
      return false;
    }
    // TODO - Prettify it
    if (currentDate.month == 4 && (currentDate.day >= 1 && currentDate.day <= 6)) {
      // Wielkanoc
      return false;
    } else if ((currentDate.month == 6 && (currentDate.day >= 26)) || currentDate.month == 7 || currentDate.month == 8) {
      // Wakacje
      return false;
    } else if (currentDate.month == 12 && currentDate.day >= 23) {
      // Boże Narodzenie
      return false;
    } else if (currentDate.month == 1 && currentDate.day <= 14) {
      return false;
    } else {
      return true;
    }
  }

  static int getCurrentTimeInSec() {
    var date = DateTime.now();
    return ((date.hour * 60) + date.minute) * 60;
  }
}
