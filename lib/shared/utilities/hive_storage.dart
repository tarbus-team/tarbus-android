import 'package:hive/hive.dart';
import 'package:tarbus_app/shared/constants/enums.dart';

class HiveStorage {
  /// Returns a previously opened box.
  static Box<T> box<T>(HiveBox hiveBox) {
    return Hive.box(hiveBox.toString());
  }
}
