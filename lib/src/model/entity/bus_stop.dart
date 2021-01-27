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
      id: json['bs_id'],
      number: json['bs_number'],
      lat: json['bs_lat'],
      lng: json['bs_lng'],
      name: json['bs_name'],
      searchName: json['bs_search_name'],
      destinations: json['bs_destinations'],
    );
  }

  factory BusStop.fromJsonRoute(Map<String, dynamic> json) {
    var isOptional = false;
    if (json['rc_is_optional'] == 1) {
      isOptional = true;
    }
    return BusStop(
        id: json['bs_id'],
        number: json['bs_number'],
        lat: json['bs_lat'],
        lng: json['bs_lng'],
        name: json['bs_name'],
        searchName: json['bs_search_name'],
        destinations: json['bs_destinations'],
        isOptional: isOptional);
  }
}
