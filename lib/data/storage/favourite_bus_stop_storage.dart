import 'package:hive/hive.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_stop_model.dart';

class FavouriteBusStopsStorage {
  static Box<SavedBusStopModel> box =
      Hive.box<SavedBusStopModel>('favourite_bus_stops');

  static Future<List<SavedBusStopModel>> getAll() async {
    List<SavedBusStopModel> result = box.values.toList();
    return result;
  }

  static Future<void> putNew(SavedBusStopModel savedBusStopModel) async {
    await box.put(savedBusStopModel.id, savedBusStopModel);
  }

  static Future<bool> contains(int id) async {
    SavedBusStopModel? result = box.get(id);
    return result != null;
  }

  static Future<SavedBusStopModel?> getById(int id) async {
    SavedBusStopModel? result = box.get(id);
    return result;
  }

  static Future<void> remove(int id) async {
    box.delete(id);
  }
}
