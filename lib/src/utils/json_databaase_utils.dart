import 'package:tarbus2021/src/model/database/database_helper.dart';

class JsonDatabaseUtils {
  bool operationStatus;

  JsonDatabaseUtils({this.operationStatus});

  factory JsonDatabaseUtils.fromJson(List<dynamic> json) {
    for (int i = 0; i < json.length; i++) {
      Map<String, dynamic> item = json[i];
      String tableName;

      if (item['type'] == 'table') {
        tableName = item['name'];
        List<dynamic> data = item['data'];
        List<String> keysList = <String>[];
        List<List<String>> globalValues = List<List<String>>();

        int valuesCounter = 0;
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
          if (valuesCounter >= 100 || j == data.length - 1) {
            DatabaseHelper.instance
                .doSQLVoid('INSERT INTO $tableName (${sqlListOfStringToString(keysList)}) VALUES ${sqlArrayOfArrayObjectToString(globalValues)}');
            globalValues.clear();
            valuesCounter = 0;
          }
          valuesCounter++;
        }
      }
    }

    return JsonDatabaseUtils(operationStatus: true);
  }

  static String sqlArrayOfArrayObjectToString(List<List<String>> list) {
    StringBuffer result = StringBuffer();
    bool isFirstIteration = true;
    for (List<String> listInside in list) {
      if (isFirstIteration) {
        result.write('(${sqlListOfStringToString(listInside)})');
        isFirstIteration = false;
      } else {
        result.write(', (${sqlListOfStringToString(listInside)})');
      }
    }
    return result.toString();
  }

  static String sqlListOfStringToString(List<String> list) {
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
