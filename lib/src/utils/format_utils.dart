import 'package:latlong/latlong.dart';

class FormatUtils {
  static LatLng parseStringToCoords(String text) {
    var coordsList = text.split(',');
    var _lat = double.parse(coordsList[1]);
    var _lng = double.parse(coordsList[0]);
    return LatLng(_lat, _lng);
  }
}
