import 'package:latlong/latlong.dart';
import 'package:tarbus2021/src/model/track_route.dart';
import 'package:tarbus2021/src/utils/geo_utils.dart';

class BusStop {
  int id;
  int number;
  LatLng coords;
  String name;
  String searchName;
  bool isCity;

  List<TrackRoute> routesFromBusStop;

  BusStop({this.id, this.number, this.coords, this.name, this.searchName, this.isCity});

  String get parsedRoutesFromBusStop {
    StringBuffer result;
    for (TrackRoute route in routesFromBusStop) {
      result.write(' ${route.destinationName},');
    }
    return result.toString();
  }

  factory BusStop.fromJson(Map<String, dynamic> json) {
    var coords = GeoUtils.parseStringToCoords(json['bs_coords']);
    var isCity = false;
    if (json['bs_is_city'] == 1) {
      isCity = true;
    }
    return BusStop(
        id: json['bs_id'], number: json['bs_number'], coords: coords, name: json['bs_name'], searchName: json['bs_search_name'], isCity: isCity);
  }
}
