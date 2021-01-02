class Destination {
  int id;
  String name;

  Destination({this.id, this.name});

  factory Destination.fromJson(Map<String, dynamic> json) => new Destination(
        id: json["id"],
        name: json["bus_stop_name"],
      );
}
