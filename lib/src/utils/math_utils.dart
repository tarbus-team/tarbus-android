class MathUtils {
  static String secToHHMM(int seconds) {
    var hours = seconds ~/ 3600;
    var minutes = ((seconds / 60) % 60).toInt();
    var result = StringBuffer()..write(hours)..write(':');

    if (minutes < 10) {
      result.write(0);
    }
    result.write(minutes);

    return result.toString();
    // return seconds.toString();
  }
}
