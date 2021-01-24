import 'package:latlong/latlong.dart';

class FormatUtils {
  static String secToHHmm(int seconds) {
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

  static parseStringToCoords(var text) {
    List<String> coordsList = text.split(",");
    var _lat = double.parse(coordsList[1]);
    var _lng = double.parse(coordsList[0]);
    return LatLng(_lat, _lng);
  }
}
