class BusStopConnection {
  int busIdFrom;
  int busIdTo;
  String? distance;
  String? coords;

  BusStopConnection(
      {required this.busIdFrom,
      required this.busIdTo,
      this.distance,
      this.coords});

  factory BusStopConnection.fromJson(Map<String, dynamic> json) {
    return BusStopConnection(
        busIdFrom: json['bsc_from_bus_stop_id'] as int,
        busIdTo: json['bsc_to_bus_stop_id'] as int,
        distance: json['bsc_distance'] as String,
        coords: json['bsc_coords_list'] as String);
  }
}
