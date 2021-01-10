import 'package:tarbus2021/src/model/single_destination.dart';

class BusStop {
  int number;
  String name;
  String searchName;
  String type;
  int isCity;
  List<SingleDestination> destinations;

  BusStop({this.number, this.name, this.type, this.destinations, this.isCity, this.searchName});

  String get parsedDestinations {
    var result = StringBuffer();
    for (var singleDestination in destinations) {
      result.write(singleDestination.destination);
      result.write(', ');
    }
    return result.toString();
  }

  factory BusStop.fromJson(Map<String, dynamic> json) => new BusStop(
        number: json['bus_stop_number'],
        searchName: json['bus_stop_name'],
        name: json['bus_stop_name'],
        type: json['bus_stop_type'],
        isCity: json['is_city'],
      );
}