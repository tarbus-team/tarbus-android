class TimeUtils {
  static int parseTimeToMin(DateTime date) {
    return (date.hour * 60) + date.minute;
  }

  static int getCurrentTimeInMin() {
    var date = DateTime.now();
    return parseTimeToMin(date);
  }
}
