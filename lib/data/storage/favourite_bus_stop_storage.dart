import 'package:hive/hive.dart';
import 'package:tarbus_app/data/model/schedule/bus_stop.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';

class FavouriteBusStopsStorage {
  static Future<List<SavedBusStopModel>> getAll() async {
    Box<SavedBusStopModel> box =
        await Hive.openBox<SavedBusStopModel>('favourite_bus_stops');
    List<SavedBusStopModel> result = box.values.toList();
    await box.close();
    return result;
  }

  static Future<void> putNew(BusStop busStop, String name) async {
    Box<SavedBusStopModel> box =
        await Hive.openBox<SavedBusStopModel>('favourite_bus_stops');
    await box.put(
        busStop.id,
        SavedBusStopModel(
          id: busStop.id,
          userBusStopName: name,
          realBusStopName: busStop.name,
          destinations: busStop.destinations,
        ));
    await box.close();
  }
}
