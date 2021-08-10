class BusStop {
  int id;
  double? lat;
  double? lng;
  String name;
  String searchName;
  bool isOptional;
  String destinations;

  BusStop(
      {required this.id,
      this.lat,
      this.lng,
      this.name = "",
      this.searchName = "",
      this.isOptional = false,
      this.destinations = ""});

  factory BusStop.fromJson(Map<String, dynamic> json) {
    return BusStop(
      id: json['bs_id'] as int,
      lat: json['bs_lat'] as double,
      lng: json['bs_lng'] as double,
      name: json['bs_name'] as String,
      searchName: json['bs_search_name'] as String,
      destinations: json['bs_destinations'] as String,
    );
  }

  @override
  String toString() {
    return 'BusStop{id: $id, lat: $lat, lng: $lng, name: $name, searchName: $searchName, isOptional: $isOptional, destinations: $destinations}';
  }
}
