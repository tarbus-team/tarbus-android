import 'package:tarbus_app/data/model/schedule/version.dart';

class BusLine {
  int id;
  String name;
  Version version;

  BusLine({required this.id, required this.name, required this.version});

  factory BusLine.fromJson(Map<String, dynamic> json) => BusLine(
        id: json['bl_id'] as int,
        name: json['bl_name'] as String,
        version: Version.fromJSON(json),
      );

  @override
  String toString() {
    return 'BusLine{id: $id, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BusLine && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
