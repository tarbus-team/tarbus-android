import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<List<String>> getSharedListString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList(key) ?? <String>[];
    return result;
  }

  static void setSharedListString(List<String> values, String key) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, values);
  }

  static Future<bool> add(String key, String id) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    sharedList.add(id);
    SharedPreferencesUtils.setSharedListString(sharedList, key);
    return true;
  }

  static Future<bool> checkIfExist(String key, String id) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    if (sharedList.contains(id)) {
      return true;
    }
    return false;
  }

  static Future<bool> checkIfExistByIndex(String key, String id, int index) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    for (var item in sharedList) {
      var splited = item.split(',');
      if (splited[index] == id) {
        return true;
      }
    }
    return false;
  }

  static Future<bool> remove(String key, String id) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    sharedList.remove(id);
    SharedPreferencesUtils.setSharedListString(sharedList, key);
    return true;
  }

  static Future<bool> removeByIndex(String key, String id, int index) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    for (var item in sharedList) {
      var splited = item.split(',');
      if (splited[index] == id) {
        sharedList.remove(item);
        break;
      }
    }

    SharedPreferencesUtils.setSharedListString(sharedList, key);
    return true;
  }

  static Future<bool> editByIndex(String key, String id, String newValue, int index) async {
    print('$key $id $newValue, $index');
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    var resultList = <String>[];
    for (var item in sharedList) {
      var splited = item.split(',');
      if (splited[index] == id) {
        item = '$id, $newValue';
      }
      resultList.add(item);
    }
    SharedPreferencesUtils.setSharedListString(resultList, key);
    return true;
  }

  static void replace(String key, int oldIndex, int newIndex) async {
    var sharedList = await SharedPreferencesUtils.getSharedListString(key);
    var tmp = sharedList[oldIndex];
    sharedList.removeAt(oldIndex);
    sharedList.insert(newIndex, tmp);
    SharedPreferencesUtils.setSharedListString(sharedList, key);
  }
}
