import 'package:tarbus2021/src/model/database/database_helper.dart';

class JsonDatabaseUtils {
  bool operationStatus;

  JsonDatabaseUtils({this.operationStatus});

  factory JsonDatabaseUtils.fromJson(List<dynamic> json) {
    for (var i = 0; i < json.length; i++) {
      var item = json[i] as Map<String, dynamic>;
      String tableName;

      if (item['type'] == 'table') {
        tableName = item['name'] as String;
        var data = item['data'] as List<dynamic>;
        var keysList = <String>[];
        var globalValues = <List<String>>[];

        var valuesCounter = 0;
        for (var j = 0; j < data.length; j++) {
          var record = data[j] as Map<String, dynamic>;
          var valuesList = <String>[];
          for (var key in record.keys) {
            if (j == 0) {
              keysList.add(key);
            }
            var recordKey = record[key] as String;
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
    var result = StringBuffer();
    var isFirstIteration = true;
    for (var listInside in list) {
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
    var result = StringBuffer();
    var i = 0;
    for (var item in list) {
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
