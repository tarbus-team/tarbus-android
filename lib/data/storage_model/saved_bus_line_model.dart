import 'package:hive/hive.dart';
import 'package:tarbus_app/data/model/schedule/bus_line.dart';

part 'saved_bus_line_model.g.dart';

@HiveType(typeId: 2)
class SavedBusLineModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? realLineName;
  @HiveField(2)
  String? realCompanyName;

  SavedBusLineModel({this.id, this.realLineName, this.realCompanyName});

  factory SavedBusLineModel.fromScheduleModel(BusLine busLine) {
    return SavedBusLineModel(
        id: busLine.id,
        realLineName: busLine.name,
        realCompanyName: busLine.version.company.name);
  }
}
