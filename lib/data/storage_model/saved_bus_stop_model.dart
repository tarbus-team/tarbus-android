import 'package:hive/hive.dart';

part 'saved_bus_stop_model.g.dart';

@HiveType(typeId: 1)
class SavedBusStopModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? userBusStopName;
  @HiveField(2)
  String? realBusStopName;
  @HiveField(3)
  String? destinations;

  SavedBusStopModel(
      {this.id, this.userBusStopName, this.realBusStopName, this.destinations});
}
