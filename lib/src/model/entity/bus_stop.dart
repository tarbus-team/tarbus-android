import 'package:latlong/latlong.dart';
import 'package:tarbus2021/src/model/entity/track_route.dart';
import 'package:tarbus2021/src/utils/format_utils.dart';

class BusStop {
  int id;
  int number;
  LatLng coords;
  String name;
  String searchName;
  bool isCity;
  bool isOptional;

  List<TrackRoute> routesFromBusStop;

  BusStop({this.id, this.number, this.coords, this.name, this.searchName, this.isCity, this.isOptional});

  String get parsedRoutesFromBusStop {
    StringBuffer result = StringBuffer();
    for (TrackRoute route in routesFromBusStop) {
      result.write(' ${route.destinationName},');
    }
    return result.toString();
  }

  factory BusStop.fromJson(Map<String, dynamic> json) {
    var coords = FormatUtils.parseStringToCoords(json['bs_coords']);
    var isCity = false;
    if (json['bs_is_city'] == 1) {
      isCity = true;
    }
    return BusStop(
        id: json['bs_id'], number: json['bs_number'], coords: coords, name: json['bs_name'], searchName: json['bs_search_name'], isCity: isCity);
  }

  factory BusStop.fromJsonRoute(Map<String, dynamic> json) {
    var coords = FormatUtils.parseStringToCoords(json['bs_coords']);
    var isCity = false;
    var isOptional = false;
    if (json['bs_is_city'] == 1) {
      isCity = true;
    }
    if (json['rc_is_optional'] == 1) {
      isOptional = true;
    }
    return BusStop(
        id: json['bs_id'],
        number: json['bs_number'],
        coords: coords,
        name: json['bs_name'],
        searchName: json['bs_search_name'],
        isCity: isCity,
        isOptional: isOptional);
  }
}
