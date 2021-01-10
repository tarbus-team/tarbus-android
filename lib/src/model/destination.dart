class Destination {
  int id;
  String name;
  String destinationShortcut;
  String description;
  String descriptionLong;
  int busLineId;
  int lastBusStopNumber;

  Destination({this.id, this.name, this.busLineId, this.description, this.destinationShortcut, this.lastBusStopNumber, this.descriptionLong});

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        id: json['destination_id'],
        name: json['destination_name'],
        destinationShortcut: json['destination_shortcut'],
        description: json['desctiption'],
        descriptionLong: json['desctiption_long'],
        busLineId: json['destination_bus_line_id'],
        lastBusStopNumber: json['last_bus_stop_number'],
      );
}
