import 'package:tarbus2021/src/database/database_helper.dart';

class JsonHolder {
  static bool fromJson(List<dynamic> json) {
    for (int i = 0; i < json.length; i++) {
      Map<String, dynamic> item = json[i];
      String tableName;

      if (item['type'] == 'table') {
        tableName = item['name'];
        List<dynamic> data = item['data'];
        List<String> keysList = <String>[];
        List<List<String>> globalValues = List<List<String>>();

        for (int j = 0; j < data.length; j++) {
          Map<String, dynamic> record = data[j];
          List<String> valuesList = <String>[];
          for (var key in record.keys) {
            if (j == 0) {
              keysList.add(key);
            }
            var recordKey = record[key];
            valuesList.add('\'$recordKey\'');
          }
          globalValues.add(valuesList);
        }
        DatabaseHelper.instance.doSQL('INSERT INTO $tableName (${listOfStringToString(keysList)}) VALUES ${objectListToString(globalValues)}');
      }
    }

    return true;
  }

  static String objectListToString(List<List<String>> list) {
    StringBuffer result = StringBuffer();
    int i = 0;
    for (List<String> listInside in list) {
      if (i == 0) {
        result.write('(${listOfStringToString(listInside)})');
      } else {
        result.write(', (${listOfStringToString(listInside)})');
      }
      i++;
    }
    return result.toString();
  }

  static String listOfStringToString(List<String> list) {
    StringBuffer result = StringBuffer();
    int i = 0;
    for (String item in list) {
      if (i == 0) {
        result.write(item);
      } else {
        result.write(', $item');
      }
      i++;
    }
    return result.toString();
  }
}
