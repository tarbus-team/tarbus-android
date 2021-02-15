class BusLine {
  int id;
  String name;

  BusLine({this.id, this.name});

  factory BusLine.fromJson(Map<String, dynamic> json) => BusLine(
        id: json['bl_id'],
        name: json['bl_name'],
      );

  @override
  String toString() {
    return 'BusLine{id: $id, name: $name}';
  }
}
