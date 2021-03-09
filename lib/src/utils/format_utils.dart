import 'package:latlong/latlong.dart';

class FormatUtils {
  static parseStringToCoords(var text) {
    List<String> coordsList = text.split(",");
    var _lat = double.parse(coordsList[1]);
    var _lng = double.parse(coordsList[0]);
    return LatLng(_lat, _lng);
  }
}
