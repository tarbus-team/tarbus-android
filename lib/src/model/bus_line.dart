class BusLine {
  int id;
  String name;

  BusLine({this.id, this.name});

  factory BusLine.fromJson(Map<String, dynamic> json) => BusLine(
        id: json['bus_line_id'],
        name: json['bus_line_name'],
      );
}
