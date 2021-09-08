import 'package:hive/hive.dart';
import 'package:tarbus_app/data/storage_model/saved_bus_line_model.dart';

class FavouriteBusLinesStorage {
  static Box<SavedBusLineModel> box =
      Hive.box<SavedBusLineModel>('favourite_bus_lines');

  static Future<List<SavedBusLineModel>> getAll() async {
    List<SavedBusLineModel> result = box.values.toList();
    return result;
  }

  static Future<void> putNewOrRemove(
      SavedBusLineModel savedBusLineModel) async {
    if (await contains(savedBusLineModel.identity!)) {
      await box.delete(savedBusLineModel.identity);
    } else {
      await box.put(savedBusLineModel.identity, savedBusLineModel);
    }
  }

  static Future<bool> contains(String identity) async {
    SavedBusLineModel? result = box.get(identity);
    return result != null;
  }
}
