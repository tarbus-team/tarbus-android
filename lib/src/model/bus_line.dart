class BusLine {
  int id;
  String name;

  BusLine({this.id, this.name});

  factory BusLine.fromJson(Map<String, dynamic> json) => new BusLine(
        id: json["id"],
        name: json["name"],
      );
}
