class BusLine {
  int id;
  String name;

  BusLine({this.id, this.name});

  factory BusLine.fromJson(Map<String, dynamic> json) => BusLine(
        id: json['bl_id'] as int,
        name: json['bl_name'] as String,
      );

  @override
  String toString() {
    return 'BusLine{id: $id, name: $name}';
  }
}
