class BusStop {
  int id;
  int number;
  double lat;
  double lng;
  String name;
  String searchName;
  bool isOptional;
  String destinations;

  BusStop({this.id, this.number, this.lat, this.lng, this.name, this.searchName, this.isOptional, this.destinations});

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      id: json['bs_id'] as int,
      number: json['bs_number'] as int,
      lat: json['bs_lat'] as double,
      lng: json['bs_lng'] as double,
      name: json['bs_name'] as String,
      searchName: json['bs_search_name'] as String,
      destinations: json['bs_destinations'] as String,
    );
  }

  factory BusStop.fromJsonRoute(Map<String, dynamic> json) {
    var isOptional = false;
    if (json['rc_is_optional'] == 1) {
      isOptional = true;
    }
    return BusStop(
        id: json['bs_id'] as int,
        number: json['bs_number'] as int,
        lat: json['bs_lat'] as double,
        lng: json['bs_lng'] as double,
        name: json['bs_name'] as String,
        searchName: json['bs_search_name'] as String,
        destinations: json['bs_destinations'] as String,
        isOptional: isOptional);
  }
}
