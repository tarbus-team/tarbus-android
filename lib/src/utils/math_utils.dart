class MathUtils {
  static String secToHHMM(int seconds) {
    var result = new StringBuffer();
    int hours = seconds ~/ 3600;
    int minutes = ((seconds / 60) % 60).toInt();

    result.write(hours);
    result.write(":");
    if (minutes < 10) {
      result.write(0);
    }
    result.write(minutes);

    return result.toString();
    // return seconds.toString();
  }
}
